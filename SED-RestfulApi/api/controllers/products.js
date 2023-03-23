const product = require('../models/Product');
const dataCryption = require('../helpers/dataprotector');
const fs = require('fs');



exports.postNewProduct = async (req, res, next) => {
    try {
        const { productname, description, productprice, category, productstatus } = req.body;

        const newProduct = new product({
            name: productname,
            description,
            price: productprice,
            category,
            productFor: productstatus,
            image: req.file.path,
            seller: req.userData._id
        });
        const doc = await newProduct.save();
        res.status(200).json({ message: doc });
    } catch (err) {
        res.status(404).json({ message: err });
    }
};

exports.getProductById = async (req, res, next) => {
    try {
        const doc = await product.findOne({ _id: req.params.product }).populate('seller', 'firstName lastName phone address city country');
        if (!doc) {
            res.status(404).json({ message: 'not found' });
            return;
        }
        doc.seller.firstName = dataCryption.decryptdData(doc.seller.firstName);
        doc.seller.lastName = dataCryption.decryptdData(doc.seller.lastName);
        doc.seller.address = dataCryption.decryptdData(doc.seller.country) + ' ,' + dataCryption.decryptdData(doc.seller.city) + ' ,' + dataCryption.decryptdData(doc.seller.address);
        doc.seller.city = dataCryption.decryptdData(doc.seller.city);
        doc.seller.country = dataCryption.decryptdData(doc.seller.country);
        res.status(200).json({ message: doc });
    } catch (err) {
        res.status(404).json({ message: err });
    }
};

exports.updateProductById = async (req, res, next) => {
    try {
        const doc = await product.findOne({ _id: req.params.product });
        if (!doc) {
            return res.status(404).json({ message: 'not found' });
        }
        if (req.userData._id != doc.seller) {
            return res.status(202).json({ message: 'not allowed' });
        }
        const newPhoto = req.file ? req.file.path.split(process.env.SPLIT_KEY)[1] : null;
        const oldPhoto = doc.image.split(process.env.SPLIT_KEY)[1];
        const needToDelete = newPhoto && newPhoto !== oldPhoto;
        const newProductData = {
            name: req.body.productname,
            description: req.body.description,
            price: req.body.productprice,
            category: req.body.category,
            productFor: req.body.productstatus,
            updatedAt: Date.now(),
        };
        if (newPhoto) {
            newProductData.image = req.file.path;
        }
        const ackg = await product.updateOne({ _id: req.params.product }, { $set: newProductData });
        if (needToDelete && fs.existsSync(doc.image)) {
            fs.unlink(doc.image, (err) => {
                if (err) {
                    console.error(err);
                }
            });
        }
        res.status(202).json({ message: ackg });
    } catch (err) {
        res.status(202).json({ message: err });
    }
};

exports.deleteProductById = async (req, res, next) => {
    try {
        const doc = await product.findOne({ _id: req.params.product });
        if (!doc) {
            return res.status(404).json({ message: 'not found' });
        }
        if (req.userData._id != doc.seller) {
            return res.status(500).json({ message: 'not allowed' });
        }
        const ackg = await product.deleteOne({ _id: req.params.product });
        if (fs.existsSync(doc.image)) {
            fs.unlinkSync(doc.image);
        }
        return res.status(202).json({ message: 'deleted' });
    } catch (err) {
        return res.status(500).json({ message: err });
    }
};

exports.getProductsByParams = async (req, res, next) => {
    const page = req.params.page || 1;
    const ProductFor = req.params.productFor;
    const Category = req.params.category;
    const perPage = 10;
    const skip = (page - 1) * perPage;
    try {
        if (Category !=='all' && ProductFor !=='all') {
            const doc = await product.find({ category: Category , productFor: ProductFor }).skip(skip).limit(perPage);
            if (!doc) {
                res.status(404).json({ message: 'not found' });
                return;
            }
            res.status(200).json({ message: doc });
            return;

        }
        if(Category=='all'&&ProductFor=='all'){
            const doc = await product.find({}).skip(skip).limit(perPage);
            if (!doc) {
                res.status(404).json({ message: 'not found' });
                return;
            }
            res.status(200).json({ message: doc });
            return;
        }
        if(Category =='all' || ProductFor =='all'){
            const doc = await product.find({$or:[{ category: Category },{ productFor: ProductFor }]}).skip(skip).limit(perPage);
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

exports.getProductsByQuery=async (req, res, next) => {
    const page = req.query.page || 1;
    var ProductFor = req.query.productFor;
    var Category = req.query.category;
    if(!ProductFor){
        ProductFor='all'
    }
    if(!Category){
        Category='all'
    }
    const perPage = 10;
    const skip = (page - 1) * perPage;
    try {
        if (Category !=='all' && ProductFor !=='all') {
            const doc = await product.find({ category: Category , productFor: ProductFor }).skip(skip).limit(perPage);
            if (!doc) {
                res.status(404).json({ message: 'not found' });
                return;
            }
            res.status(200).json({ message: doc });
            return;

        }
        if(Category=='all'&&ProductFor=='all'){
            const doc = await product.find({}).skip(skip).limit(perPage);
            if (!doc) {
                res.status(404).json({ message: 'not found' });
                return;
            }
            res.status(200).json({ message: doc });
            return;
        }
        if(Category =='all' || ProductFor =='all'){
            const doc = await product.find({$or:[{ category: Category },{ productFor: ProductFor }]}).skip(skip).limit(perPage);
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
