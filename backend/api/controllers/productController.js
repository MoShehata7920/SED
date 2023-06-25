const Product = require('../models/product')
const User = require('../models/user')
const fs = require('fs')
const path = require('path');
const check_auth = require('../middleware/check-auth')
const lodash = require('lodash');


exports.createProduct = (req, res) => {
    if(!req.user.isVerified){
        return res.status(200).json({status:0 , message : " You have to verify your email before posting any ads "})
    }
    new Product({
        productName: req.body.productName,
        description: req.body.description,
        category: req.body.category,
        purpose: req.body.purpose,
        // productImage: req.file.path ,
        productImage: `http://47.243.7.214:3000/${req.file.path}` || `http://47.243.7.214:3000/${req.file.name}` ,
        condition:req.body.condition,
        price: req.body.price,
        seller: req.user.id
    }).save().then((newproduct) => {
        res.status(200).json({status:0 ,newproduct,message:'Product has been published successfully'})
    }).catch(err => {
        res.status(500).json({status:1,err,message:err.message});
    })
}

exports.getAllProducts = (req, res) => {
    Product.find().exec().then((docs) => {
        res.status(200).json({status: 0,docs})
    }).catch(err => {
        res.status(500).json({status: 1,err})
    })
}

exports.getSingleProduct = async(req, res) => {
    try {
        const product=await Product.findById(req.params.prodId).populate('seller','fullName _id email phone userImage government address ')
        const sellerInfo=product.seller
        res.status(200).json({status: 0 , product , sellerInfo }) // sending product information and some of seller information and status
    } catch (err) {
        res.status(500).json({status: 1,err})
    }
}

exports.updateProduct = async (req, res) => {
    try {
      const product = await Product.findOne({ _id: req.params.prodId });
      if (!product) {
        return res.status(400).json({ status: 0, message: 'There is no product with this id' });
      }
      if (req.user.id != product.seller) {
        return res.status(405).json({ status: 0, message: 'not allowed' });
      }
  
      const newPhoto = req.file ? `http://47.243.7.214:3000/${req.file.path}` : null;
      const oldPhoto = product.productImage;
      const needToDelete = newPhoto !== oldPhoto;
      const updatedImage = newPhoto ? newPhoto : oldPhoto;
  
      try {
        await fs.promises.access(updatedImage);
  
        // File already exists, so it's an update
        const existingFilename = path.basename(oldPhoto);
        const newFilename = path.basename(updatedImage);
  
        if (newFilename === existingFilename) {
          // The names are the same, so the image has not been updated
          // Update the product with the existing filename
          await Product.updateOne({ _id: req.params.prodId }, { $set: { ...req.body, productImage: oldPhoto, updatedAt: Date.now() } });
        } else {
          // The names are different, so the image has been updated
          // Update the product with the new filename
          await Product.updateOne({ _id: req.params.prodId }, { $set: { ...req.body, productImage: updatedImage, updatedAt: Date.now() } });
  
          if (needToDelete &&  fs.existsSync(oldPhoto)) {
            await fs.promises.unlink(oldPhoto);
          }
        }
      } catch (err) {
        // File does not exist, so it's a new upload
        // Update the product with the new filename
        await Product.updateOne({ _id: req.params.prodId }, { $set: { ...req.body, productImage: updatedImage, updatedAt: Date.now() } });
  
        if (needToDelete &&  fs.existsSync(oldPhoto)) {
          await fs.promises.unlink(oldPhoto);
        }
      }
  
      res.status(200).json({ status: 0, message: 'Product has been updated successfully' });
    } catch (err) {
        console.log(err)
      res.status(500).json({ status: 1, err });
    }
  }
  

  

exports.deleteProduct = (req, res) => {
    Product.findById(req.params.prodId).exec().then(doc => {
        if (doc) {
            Product.deleteOne({ _id: req.params.prodId }).exec().then(() => {
                res.status(200).json({status: 0,message:'Product has been deleted successfully'})
            })
        } else {
            res.status(200).json({status: 0,message:'There is no product with this id'})
        }
    }).catch(err => {
        res.status(500).json({status: 1,err})
    })
}


exports.getProductsByQuery = async (req, res, next) => {
    const page = req.query.page || 1;
    const purpose = req.query.purpose || 'all';
    const category = req.query.category || 'all';
    const sortBy = req.query.sort  || '-createdAt'
    const { condition , minPrice , maxPrice , search }=req.query
    
    var userData = {};
    let wishList = [];
    if (req.headers.authentication) {
        userData = check_auth.verifyTokenWithReturn(req.headers.authentication);
    }
    if (!lodash.isEmpty(userData)) {
        const doc = await User.findById(userData.id).select('wishList -_id');
        if (doc) { // check if doc is not null or undefined
            wishList = doc.wishList;
        }
    }
    const perPage = 10;
    const skip = (page - 1) * perPage;
    try {
        let query = {};
        if (category !== 'all') {
            query.category = category;
        }
        if (purpose !== 'all') {
            query.purpose = purpose;
        }
        if(condition ){
            query.condition=condition
        }
        if (minPrice && maxPrice) {
            query.price = {
                $gte: minPrice,
                $lte: maxPrice
            };
        }else if (minPrice) {
            query.price = {
            $gte: minPrice
            };
        }else if (maxPrice) {
            query.price = {
            $lte: maxPrice
            };
        }
        if(search){
            query.$or = [
                {productName:{$regex:search , $options:'i' }}, // i option to disable key sensetivity
                {description:{$regex:search , $options: 'i' }},
                {purpose:{$regex:search , $options: 'i' }},
                {category:{$regex:search , $options: 'i' }}
                ]
            // query.$text= { $search: search, $diacriticSensitive: false }   
        }

        const doc = await Product.find(query)
            .select('-seller -updatedAt -__v')
            .sort(sortBy)
            .lean()
            .skip(skip)
            .limit(perPage);
        // if (doc.length === 0) {          // commented for frontend , he need items to be empty better
        //     return res.status(200).json({ status: 0, message: 'There are no products with this filters' });
        // }

        // calculating whole number of pages 
        const totalDocs=await Product.countDocuments(query)
        const totalPageNumber=Math.ceil( totalDocs / perPage )

        // iterate over each object in the list
        for (let i = 0; i < doc.length; i++) {
            const obj = doc[i];

            // set default isSaved property to false
            obj.isSaved = false;

            // check if object _id is in wishlist
            if (wishList.includes(obj._id)) {
                obj.isSaved = true;
            }
        }

        return res.status(200).json({ status: 0, items: doc , totalDocs , totalPageNumber , currentPage:page });
    } catch (err) {
        res.status(404).json({ status: 1, message: err });
    }
};


exports.getProductsByParams = async (req, res, next) => {
    const page = req.params.page || 1;
    var purpose = req.params.purpose;
    var Category = req.params.category;
    var userData = {}
    var wishList = []
    if (req.headers.authentication) {
        userData = check_auth.verifyTokenWithReturn(req.headers.authentication)
    }
    if (!lodash.isEmpty(userData)) {
        const doc = await User.findById(userData.id).select('wishList -_id');
        if (doc) { // check if doc is not null or undefined
            wishList = doc.wishList
        }
    }
    if (!purpose) {
        purpose = 'all'
    }
    if (!Category) {
        Category = 'all'
    }
    const perPage = 10;
    const skip = (page - 1) * perPage;
    try {
        if (Category !== 'all' && purpose !== 'all') {
            const doc = await Product.find({ category: Category, purpose: purpose }).select('-seller -updatedAt -__v').lean().skip(skip).limit(perPage);
            if (!doc) {
                res.status(404).json({ status: 1, message: 'not found' });
                return;
            }
            // iterate over each object in the list
            for (let i = 0; i < doc.length; i++) {
                var obj = doc[i];

                // set default isSaved property to false
                obj.isSaved = false;

                // check if object _id is in wishlist
                if (wishList.includes(obj._id)) {
                    obj.isSaved = true;
                }
            }     
            return res.status(200).json({ status: 0, items: doc })

        }
        if (Category == 'all' && purpose == 'all') {
            const doc = await Product.find({}).select('-seller -updatedAt -__v').lean().skip(skip).limit(perPage);
            if (!doc) {
                res.status(404).json({ status: 1, message: 'not found' });
                return;
            }
            // iterate over each object in the list
            for (let i = 0; i < doc.length; i++) {
                var obj = doc[i];

                // set default isSaved property to false
                obj.isSaved = false;

                // check if object _id is in wishlist
                if (wishList.includes(obj._id)) {
                    obj.isSaved = true;
                }
            }
            return res.status(200).json({ status: 0, items: doc });
            
        }
        if (Category == 'all' || purpose == 'all') {
            const doc = await Product.find({ $or: [{ category: Category }, { purpose: purpose }] }).select('-seller -updatedAt -__v').lean().skip(skip).limit(perPage);
            if (!doc) {
                res.status(404).json({ status: 1, message: 'not found' });
                return;
            }
            // iterate over each object in the list
            for (let i = 0; i < doc.length; i++) {
                var obj = doc[i];

                // set default isSaved property to false
                obj.isSaved = false;

                // check if object _id is in wishlist
                if (wishList.includes(obj._id)) {
                    obj.isSaved = true;
                }
            }
            
            return res.status(200).json({ status: 0, items: doc });
        }
    } catch (err) {
        res.status(404).json({ status: 1, message: err });
    }

};

// to get products created by specific seller
exports.userProducts=async(req,res)=>{ 
    const sellerId=req.params.sellerId
    try {
        const products =await Product.find({seller:sellerId})
        if(products.length === 0){
            return res.status(200).json({status: 0 , message:'There are no products for this user' , products })
        }
        res.status(200).json({status:0 , products });
    } catch (err) {
        res.status(500).json({status:1 , err});
    }
}

// exports.searchQuery = async (req, res) => {
//     const search = req.query.search;
//     try {
//         const result = await Product.find({ $text: { $search: search, $diacriticSensitive: false } });
//         const result_number = result.length;
//         res.status(200).json({ status: 0, result, result_number });
//     } catch (err) {
//         res.status(500).json({ status: 1, err });
//     }
// }

exports.searchQuery=async(req,res)=>{
    const search=req.query.search
    let query={}
    try {
        query.$or = [
                {productName:{$regex:search , $options:'i' }}, // i option to disable key sensetivity
                {description:{$regex:search , $options: 'i' }},
                {purpose:{$regex:search , $options: 'i' }},
                {category:{$regex:search , $options: 'i' }},
            ]
        const result=await Product.find(query)
        const result_number=result.length
        res.status(200).json({status:0,result ,result_number})
    } catch (err) {
        res.status(500).json({status:1 , err});
    }
}

