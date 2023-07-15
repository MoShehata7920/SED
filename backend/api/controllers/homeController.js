const Product = require("../models/product");
const Images = require('../models/appImages');
const Category = require('../models/category');
const User = require('../models/user');
const check_auth = require('../middleware/check-auth');
const lodash = require('lodash');

exports.homePage = async (req, res) => {
  const productPerCat = 10; // Number of products to show beside category, set to 10 items
  var userData = {};
  let wishList = [];

  // Verify user authentication and retrieve user data if available
  if (req.headers.authentication) {
    userData = check_auth.verifyTokenWithReturn(req.headers.authentication);
  }

  // Check if user data is available and retrieve wishlist
  if (!lodash.isEmpty(userData)) {
    const doc = await User.findById(userData.id).select('wishList fullName -_id');
    if (doc) {
      wishList = doc.wishList;
    }
  }

  try {
    // Retrieve carousel images
    const carouselPromise = Images.find({ imageLocation: 'carousel' })
      .select('image')
      .lean()
      .exec();

    // Retrieve categories
    const categoriesPromise = Category.find({})
      .sort({_id:1})
      .select('name image')
      .lean()
      .exec();

    // Retrieve sell items
    const sellPromise = Product.find({ purpose: 'sell' })
      .sort({ createdAt: -1 })
      .limit(productPerCat)
      .select('productName description category price productImage seller createdAt')
      .populate('seller', 'government address')
      .lean()
      .exec();

    // Retrieve exchange items
    const exchangePromise = Product.find({ purpose: 'exchange' })
      .sort({ createdAt: -1 })
      .limit(productPerCat)
      .populate('seller', 'government address')
      .select('productName description category price productImage seller createdAt')
      .lean()
      .exec();

    // Retrieve donate items
    const donatePromise = Product.find({ purpose: 'donate' })
      .sort({ createdAt: -1 })
      .limit(productPerCat)
      .select('productName description category price productImage seller createdAt')
      .populate('seller', 'government address')
      .lean()
      .exec();

    // Retrieve section images
    const sectionsPromise = Images.find({ imageLocation: 'sections' })
      .select('image SectionId')
      .lean()
      .exec();

    // Await all the promises
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

    // Process carousel images
    const carouselAsArray = [];
    for (var i = 0; i < carouselDb.length; i++) {
      carouselAsArray.push(carouselDb[i].image);
    }
    const carousel = { Images: carouselAsArray };

    // Iterate over sellItems and add 'isSaved' property based on wishlist
    for (let i = 0; i < sellItems.length; i++) {
      const obj = sellItems[i];
      obj.isSaved = false; // Set default 'isSaved' property to false

      // Check if object _id is in wishlist
      if (wishList.includes(obj._id)) {
        obj.isSaved = true;
      }
    }

    // Iterate over donateItems and add 'isSaved' property based on wishlist
    for (let i = 0; i < donateItems.length; i++) {
      const obj = donateItems[i];
      obj.isSaved = false; // Set default 'isSaved' property to false

      // Check if object _id is in wishlist
      if (wishList.includes(obj._id)) {
        obj.isSaved = true;
      }
    }

    // Iterate over exchangeItems and add 'isSaved' property based on wishlist
    for (let i = 0; i < exchangeItems.length; i++) {
      const obj = exchangeItems[i];
      obj.isSaved = false; // Set default 'isSaved' property to false

      // Check if object _id is in wishlist
      if (wishList.includes(obj._id)) {
        obj.isSaved = true;
      }
    }

    // Send the response with the retrieved data
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
