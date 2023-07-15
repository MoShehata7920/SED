const Product = require("../models/product");
const Images = require('../models/appImages');
const Category = require('../models/category');
const User = require('../models/user');
const check_auth = require('../middleware/check-auth');
const lodash = require('lodash');

exports.homePage = async (req, res) => {
  const productPerCat = 10; // Number of products to show beside category, set to 10 items
  let userData = {};
  let wishList = [];

  // Verify user authentication and retrieve user data if available
  if (req.headers.authentication) {
    userData = check_auth.verifyTokenWithReturn(req.headers.authentication);
  }

  // Check if user data is available and retrieve wishlist
  if (!lodash.isEmpty(userData)) {
    const user = await User.findById(userData.id).select('wishList fullName -_id');
    if (user) {
      wishList = user.wishList;
    }
  }

  try {
    // Retrieve carousel images
    const carouselPromise = Images.find({ imageLocation: 'carousel' })
      .select('image')
      .lean();

    // Retrieve categories
    const categoriesPromise = Category.find({})
      .sort({ _id: 1 })
      .select('name image')
      .lean();

    // Retrieve sell items
    const sellPromise = Product.find({ purpose: 'sell' })
      .sort({ createdAt: -1 })
      .limit(productPerCat)
      .select('productName description category price productImage seller createdAt')
      .populate('seller', 'government address')
      .lean();

    // Retrieve exchange items
    const exchangePromise = Product.find({ purpose: 'exchange' })
      .sort({ createdAt: -1 })
      .limit(productPerCat)
      .select('productName description category price productImage seller createdAt')
      .populate('seller', 'government address')
      .lean();

    // Retrieve donate items
    const donatePromise = Product.find({ purpose: 'donate' })
      .sort({ createdAt: -1 })
      .limit(productPerCat)
      .select('productName description category price productImage seller createdAt')
      .populate('seller', 'government address')
      .lean();

    // Retrieve section images
    const sectionsPromise = Images.find({ imageLocation: 'sections' })
      .select('image SectionId')
      .lean();

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
    const carousel = { Images: carouselDb.map(item => item.image) };

    // Iterate over sellItems and add 'isSaved' property based on wishlist
    sellItems.forEach(item => {
      item.isSaved = wishList.includes(item._id);
    });

    // Iterate over donateItems and add 'isSaved' property based on wishlist
    donateItems.forEach(item => {
      item.isSaved = wishList.includes(item._id);
    });

    // Iterate over exchangeItems and add 'isSaved' property based on wishlist
    exchangeItems.forEach(item => {
      item.isSaved = wishList.includes(item._id);
    });

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

