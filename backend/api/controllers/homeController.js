const Product = require("../models/product");
const Images = require('../models/appImages');
const Category = require('../models/category');
const User = require('../models/user');
const check_auth = require('../middleware/check-auth');
const lodash = require('lodash');

exports.homePage = async (req, res) => {
  const productPerCat = 10            // number of products to show beside category which equal to 10 items
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
  try {
    const carouselPromise = Images.find({ imageLocation: 'carousel' })
      .select('image')
      .lean()
      .exec();
    const categoriesPromise = Category.find({})
      .select('name image')
      .lean()
      .exec();
    const sellPromise = Product.find({ purpose: 'sell' }).sort({ createdAt: -1 })
      .limit(productPerCat)
      .select('productName description category price productImage seller createdAt')
      .populate('seller','government address')
      .lean()
      .exec();
    const exchangePromise = Product.find({ purpose: 'exchange' }).sort({ createdAt: -1 })
      .limit(productPerCat)
      .populate('seller','government address')
      .select('productName description category price productImage seller createdAt')
      .lean()
      .exec();
    const donatePromise = Product.find({ purpose: 'donate' }).sort({ createdAt: -1 })
      .limit(productPerCat)
      .select('productName description category price productImage seller createdAt')
      .populate('seller','government address')
      .lean()
      .exec();

    const sectionsPromise = Images.find({ imageLocation: 'sections' })
      .select('image SectionId')
      .lean()
      .exec();

    const [
      carouselDb,
      categories,
      sellItems,
      donateItems,
      exchangeItems,
      sections,
    ] = await Promise.all([
      carouselPromise,
      categoriesPromise,
      sellPromise,
      donatePromise,
      exchangePromise,
      sectionsPromise,
    ]);
    const carouselAsArray = []
    for (var i = 0; i < carouselDb.length; i++) {
      carouselAsArray.push(carouselDb[i].image)
    }
    const carousel = { Images: carouselAsArray }
    // iterate over each object in the list
    for (let i = 0; i < sellItems.length; i++) {
      const obj = sellItems[i];

      // set default isSaved property to false
      obj.isSaved = false;

      // check if object _id is in wishlist
      if (wishList.includes(obj._id)) {
        obj.isSaved = true;
      }
    }
    // iterate over each object in the list
    for (let i = 0; i < donateItems.length; i++) {
      const obj = donateItems[i];

      // set default isSaved property to false
      obj.isSaved = false;

      // check if object _id is in wishlist
      if (wishList.includes(obj._id)) {
        obj.isSaved = true;
      }
    }
    // iterate over each object in the list
    for (let i = 0; i < exchangeItems.length; i++) {
      const obj = exchangeItems[i];

      // set default isSaved property to false
      obj.isSaved = false;

      // check if object _id is in wishlist
      if (wishList.includes(obj._id)) {
        obj.isSaved = true;
      }
    }
    res.status(200).json({
      carousel,
      categories,
      sellItems,
      donateItems,
      exchangeItems,
      sections,
      status: 0,
      message: 'Successfully loaded data',
    });
  } catch (error) {
    console.error(error);
    res.status(500).json({ status: 1, message: 'Internal server error' });
  }
};