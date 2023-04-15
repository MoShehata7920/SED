const Product = require("../models/product");
const Images=require('../models/appImages');
const Category=require('../models/category');

exports.homePage=async(req, res) => {
    const productPerCat = 10            // number of products to show beside category which equal to 10 items
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
        .select('productName description price productImage seller createdAt')
        .lean()
        .exec();
      const exchangePromise = Product.find({ purpose: 'exchange' }).sort({ createdAt: -1 })
      .limit(productPerCat)
      .select('productName description price productImage seller createdAt')
      .lean()
      .exec();
      const donatePromise = Product.find({ purpose: 'donate' }).sort({ createdAt: -1 })
        .limit(productPerCat)
        .select('productName description price productImage seller createdAt')
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
      const carouselAsArray=[]
      for(var i=0;i<carouselDb.length;i++){
        carouselAsArray.push(carouselDb[i].image)
      }
       const carousel={Images:carouselAsArray}
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