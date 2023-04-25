const Product = require('../models/product')
const User = require('../models/user')
const fs = require('fs')
const check_auth = require('../middleware/check-auth')
const lodash = require('lodash');


exports.createProduct = (req, res) => {
    new Product({
        productName: req.body.productName,
        description: req.body.description,
        category: req.body.category,
        purpose: req.body.purpose,
        quantity: req.body.quantity,
        productImage: req.file.path,
        condition:req.body.condition,
        price: req.body.price,
        seller: req.user.id
    }).save().then((newproduct) => {
        res.status(200).json({status:0 ,newproduct,message:'Product has been published successfully'})
    }).catch(err => {
        console.log({status:1,err,message:err.message});
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
        const product=await Product.findById(req.params.prodId).populate('seller','fullName _id email personalInfo.phone')
        const sellerInfo=product.seller
        res.status(200).json({status: 0 , product , sellerInfo,phone:sellerInfo.personalInfo.phone}) // sending product information and some of seller information and status
    } catch (err) {
        res.status(500).json({status: 1,err})
    }
}

exports.updateProduct = async (req, res) => {
    try {
        const product = await Product.findOne({ _id: req.params.prodId });
        if (!product) {
            return res.status(400).json({status: 0, message: 'There is no product with this id' });
        }
        if (req.user.id != product.seller) {                                // if seller id of product equal = to user.id who trying to edit > req.user.id // will upload 1 product to make sure 
            return res.status(405).json({ status: 0,message: 'not allowed' });
        }
        const newPhoto = req.file ? req.file.path : null
        const oldPhoto = product.productImage
        const needToDelete = newPhoto && newPhoto !== oldPhoto;
        const updatedImage = newPhoto ? newPhoto : oldPhoto          // if there is new image will put its new path on product image ,,, if not the old one will remain
        await Product.updateOne({ _id: req.params.prodId }, { $set: req.body, productImage: updatedImage, updatedAt: Date.now() })
        if (needToDelete && fs.existsSync(product.productImage)) {
            fs.unlink(product.productImage, (err) => {
                if (err) {
                    console.error(err);
                }
            });
        }
        res.status(200).json({ status: 0,message: 'Product has been updated successfully' })
    } catch (err) {
        res.status(555).json({status: 1,err})
    }
}

exports.deleteProduct = (req, res) => {
    Product.findById(req.params.prodId).exec().then(doc => {
        if (doc) {
            Product.deleteOne({ _id: req.params.prodId }).exec().then(() => {
                res.status(200).json({status: 0,message:'Product has been deleted successfully'})
            })
        } else {
            res.status(404).json({status: 0,message:'There is no product with this id'})
        }
    }).catch(err => {
        res.status(500).json({status: 1,err})
    })
}


exports.getProductsByQuery = async (req, res, next) => {
    const page = req.query.page || 1;
    const purpose = req.query.purpose || 'all';
    const category = req.query.category || 'all';
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
        const doc = await Product.find(query)
            .select('-seller -updatedAt -__v')
            .lean()
            .skip(skip)
            .limit(perPage);
        if (!doc) {
            res.status(400).json({ status: 0, message: 'not found' });
            return;
        }
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
        res.status(200).json({ status: 0, items: doc });
        return;
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
            res.status(200).json({ status: 0, items: doc });
            return;

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
            res.status(200).json({ status: 0, items: doc });
            return;
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
            res.status(200).json({ status: 0, items: doc });
            return;
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
        // console.log(products);
        res.status(200).json({products,status:0});
    } catch (err) {
        res.status(500).json({status:1,err});
    }
}