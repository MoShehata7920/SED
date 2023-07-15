const Product = require('../models/product')
const User = require('../models/user')
const fs = require('fs')
const path = require('path');
const check_auth = require('../middleware/check-auth')
const lodash = require('lodash');


exports.createProduct = async (req, res) => {
    if (!req.user.isVerified) {
      return res.status(400).json({ status: 0, message: "You have to verify your email before posting any ads" });
    }
  
    try {
      const newProduct = new Product({
        productName: req.body.productName,
        description: req.body.description,
        category: req.body.category,
        purpose: req.body.purpose,
        productImage: req.file ? `http://47.243.7.214:3000/${req.file.path}` : `http://47.243.7.214:3000/${req.file.name}`,
        condition: req.body.condition,
        price: req.body.price,
        seller: req.user.id
      });
  
      await newProduct.save();
  
      res.status(200).json({ status: 0, newproduct: newProduct, message: 'Product has been published successfully' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ status: 1, error: error, message: 'Internal server error' });
    }
  };
  
  exports.getAllProducts = async (req, res) => {
    try {
      const docs = await Product.find().exec();
      res.status(200).json({ status: 0, docs: docs });
    } catch (error) {
      console.error(error);
      res.status(500).json({ status: 1, error: error, message: 'Internal server error' });
    }
  };
  
  exports.getSingleProduct = async (req, res) => {
    try {
      const product = await Product.findById(req.params.prodId).populate('seller', 'fullName _id email phone userImage government address');
      const sellerInfo = product.seller;
      res.status(200).json({ status: 0, product: product, sellerInfo: sellerInfo });
    } catch (error) {
      console.error(error);
      res.status(500).json({ status: 1, error: error, message: 'Internal server error' });
    }
  };
  
  exports.updateProduct = async (req, res) => {
    try {
      const product = await Product.findOne({ _id: req.params.prodId });
  
      if (!product) {
        return res.status(400).json({ status: 0, message: 'There is no product with this id' });
      }
  
      if (req.user.id !== product.seller && !req.user.isAdmin) {
        return res.status(405).json({ status: 0, message: 'Not allowed' });
      }
  
      const newPhoto = req.file ? `http://47.243.7.214:3000/${req.file.path}` : null;
      const oldPhoto = product.productImage;
      const needToDelete = newPhoto !== oldPhoto;
      const updatedImage = newPhoto || oldPhoto;
  
      await fs.promises.access(updatedImage);
  
      if (needToDelete && fs.existsSync(oldPhoto)) {
        await fs.promises.unlink(oldPhoto);
      }
  
      await Product.updateOne(
        { _id: req.params.prodId },
        { $set: { ...req.body, productImage: updatedImage, updatedAt: Date.now() } }
      );
  
      res.status(200).json({ status: 0, message: 'Product has been updated successfully' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ status: 1, error: error, message: 'Internal server error' });
    }
  };
  
  exports.deleteProduct = async (req, res) => {
    try {
      const doc = await Product.findById(req.params.prodId).exec();
  
      if (doc) {
        await Product.deleteOne({ _id: req.params.prodId }).exec();
        res.status(200).json({ status: 0, message: 'Product has been deleted successfully' });
      } else {
        res.status(400).json({ status: 0, message: 'There is no product with this id' });
      }
    } catch (error) {
      console.error(error);
      res.status(500).json({ status: 1, error: error, message: 'Internal server error' });
    }
  };
  


  exports.getProductsByQuery = async (req, res, next) => {
    const page = req.query.page || 1;
    const purpose = req.query.purpose || 'all';
    const category = req.query.category || 'all';
    const sortBy = req.query.sort || '-createdAt';
    const { condition, minPrice, maxPrice, search } = req.query;
  
    var userData = {};
    let wishList = [];
  
    if (req.headers.authentication) {
      userData = check_auth.verifyTokenWithReturn(req.headers.authentication);
    }
  
    if (!lodash.isEmpty(userData)) {
      const doc = await User.findById(userData.id).select('wishList -_id');
      if (doc) {
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
  
      if (condition) {
        query.condition = condition;
      }
  
      if (minPrice && maxPrice) {
        query.price = {
          $gte: minPrice,
          $lte: maxPrice
        };
      } else if (minPrice) {
        query.price = {
          $gte: minPrice
        };
      } else if (maxPrice) {
        query.price = {
          $lte: maxPrice
        };
      }
  
      if (search) {
        query.$or = [
          { productName: { $regex: search, $options: 'i' } },
          { description: { $regex: search, $options: 'i' } },
          { purpose: { $regex: search, $options: 'i' } },
          { category: { $regex: search, $options: 'i' } }
        ];
      }
  
      const doc = await Product.find(query)
        .select('-seller -updatedAt -__v')
        .sort(sortBy)
        .lean()
        .skip(skip)
        .limit(perPage);
  
      const totalDocs = await Product.countDocuments(query);
      const totalPageNumber = Math.ceil(totalDocs / perPage);
  
      for (let i = 0; i < doc.length; i++) {
        const obj = doc[i];
        obj.isSaved = false;
  
        if (wishList.includes(obj._id)) {
          obj.isSaved = true;
        }
      }
  
      res.status(200).json({
        status: 0,
        items: doc,
        totalDocs,
        totalPageNumber,
        currentPage: page
      });
    } catch (err) {
      console.error(err);
      res.status(500).json({ status: 1, message: 'Internal server error' });
    }
  };
  
  exports.getProductsByParams = async (req, res, next) => {
    const page = req.params.page || 1;
    let purpose = req.params.purpose;
    let category = req.params.category;
    var userData = {};
    var wishList = [];
  
    if (req.headers.authentication) {
      userData = check_auth.verifyTokenWithReturn(req.headers.authentication);
    }
  
    if (!lodash.isEmpty(userData)) {
      const doc = await User.findById(userData.id).select('wishList -_id');
      if (doc) {
        wishList = doc.wishList;
      }
    }
  
    if (!purpose) {
      purpose = 'all';
    }
  
    if (!category) {
      category = 'all';
    }
  
    const perPage = 10;
    const skip = (page - 1) * perPage;
  
    try {
      let query = {};
  
      if (Category !== 'all' && purpose !== 'all') {
        query = { category: category, purpose: purpose };
      } else if (Category === 'all' && purpose === 'all') {
        query = {};
      } else {
        query = { $or: [{ category: category }, { purpose: purpose }] };
      }
  
      const doc = await Product.find(query)
        .select('-seller -updatedAt -__v')
        .lean()
        .skip(skip)
        .limit(perPage);
  
      if (!doc || doc.length === 0) {
        return res.status(404).json({ status: 1, message: 'Not found' });
      }
  
      for (let i = 0; i < doc.length; i++) {
        const obj = doc[i];
        obj.isSaved = false;
  
        if (wishList.includes(obj._id)) {
          obj.isSaved = true;
        }
      }
  
      res.status(200).json({ status: 0, items: doc });
    } catch (err) {
      console.error(err);
      res.status(500).json({ status: 1, message: 'Internal server error' });
    }
  };
  
  exports.userProducts = async (req, res) => {
    const sellerId = req.params.sellerId;
  
    try {
      const products = await Product.find({ seller: sellerId });
  
      if (products.length === 0) {
        return res.status(200).json({ status: 0, message: 'There are no products for this user', products });
      }
  
      res.status(200).json({ status: 0, products });
    } catch (err) {
      console.error(err);
      res.status(500).json({ status: 1, error: err, message: 'Internal server error' });
    }
  };
  
  exports.searchQuery = async (req, res) => {
    const search = req.query.search;
    let query = {};
  
    try {
      query.$or = [
        { productName: { $regex: search, $options: 'i' } },
        { description: { $regex: search, $options: 'i' } },
        { purpose: { $regex: search, $options: 'i' } },
        { category: { $regex: search, $options: 'i' } }
      ];
  
      const items = await Product.find(query);
      const result_number = items.length;
  
      res.status(200).json({ status: 0, items, result_number });
    } catch (err) {
      console.error(err);
      res.status(500).json({ status: 1, error: err, message: 'Internal server error' });
    }
  };
  

