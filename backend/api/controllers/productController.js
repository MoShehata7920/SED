const Product=require('../models/product')
const mongoose=require('mongoose')
const fs=require('fs')

exports.createProduct=(req,res)=>{
    new Product({
        productName : req.body.productName,
        description : req.body.description,
        category:req.body.category,
        purpose:req.body.purpose,
        quantity : req.body.quantity,
        productImage : req.file.path,
        price : req.body.price,
        seller:req.body.seller
    }).save().then((newproduct)=>{
        res.status(200).json(newproduct)
    }).catch(err=>{
        console.log(err);
    })
}

exports.getAllProducts=(req,res)=>{
    Product.find().exec().then((docs)=>{
        res.status(200).json(docs)
    }).catch(err=>{
        res.status(500).json(err)
    })
}

exports.getSingleProduct=(req,res)=>{
    Product.findById(req.params.prodId).exec().then(doc=>{
        res.status(200).json(doc)
    }).catch(err=>{
        res.status(500).json(err)
    })
}

exports.updateProduct=async(req,res)=>{
    try {
        const product = await Product.findOne({ _id: req.params.prodId });
        if (!product) {
            return res.status(404).json({ message: 'There is no product with this id' });
        }
        if (req.user.id != product.seller) {                                // if seller id of product equal = to user.id who trying to edit > req.user.id // will upload 1 product to make sure 
            return res.status(405).json({ message: 'not allowed' });
        }
        const newPhoto = req.file ? req.file.path : null 
        const oldPhoto = product.productImage
        const needToDelete = newPhoto && newPhoto !== oldPhoto;
        const updatedImage= newPhoto ? newPhoto : oldPhoto          // if there is new image will put its new path on product image ,,, if not the old one will remain
        await Product.updateOne({_id:req.params.prodId},{ $set:req.body , productImage : updatedImage , updatedAt:Date.now()})
        if (needToDelete && fs.existsSync(product.productImage)) {
            fs.unlink(product.productImage , (err) => {
                if (err) {
                    console.error(err);
                }
            });
        }
        res.status(200).json({message:'Product has been updated successfully'})
    } catch (error) {
        res.status(555).json(error)
    }    
}

exports.deleteProduct=(req,res)=>{
    Product.findById(req.params.prodId).exec().then(doc=>{
        if(doc){
            Product.deleteOne({ _id : req.params.prodId}).exec().then(()=>{
                res.status(200).json('Product has been deleted successfully')
            }) 
        } else{
            res.status(404).json('There is no product with this id')
        }   
    }).catch(err=>{
        res.status(500).json(err)
    })
}


exports.getProductsByQuery=async (req, res, next) => {
    const page = req.query.page || 1;
    var purpose = req.query.purpose;
    var Category = req.query.category;
    if(!purpose){
        purpose='all'
    }
    if(!Category){
        Category='all'
    }
    const perPage = 10;
    const skip = (page - 1) * perPage;
    try {
        if (Category !=='all' && purpose !=='all') {
            const doc = await Product.find({ category: Category , purpose: purpose }).skip(skip).limit(perPage);
            if (!doc) {
                res.status(404).json({ message: 'not found' });
                return;
            }
            res.status(200).json({ message: doc });
            return;

        }
        if(Category=='all'&&purpose=='all'){
            const doc = await Product.find({}).skip(skip).limit(perPage);
            if (!doc) {
                res.status(404).json({ message: 'not found' });
                return;
            }
            res.status(200).json({ message: doc });
            return;
        }
        if(Category =='all' || purpose =='all'){
            const doc = await Product.find({$or:[{ category: Category },{ purpose: purpose }]}).skip(skip).limit(perPage);
            if (!doc) {
                res.status(404).json({ message: 'not found' });
                return;
            }
            res.status(200).json({ message: doc });
            return;
        }
    } catch (err) {
        res.status(404).json({ message: err });
    }
};