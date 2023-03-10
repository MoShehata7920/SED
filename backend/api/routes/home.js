const router = require("express").Router();
const Product = require("../models/product");
const Images=require('../models/appImages')
const Category=require('../models/category')

// the main page route >> http://sedDomain/
router.get("/", async(req, res) => {
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
    const sellPromise = Product.find({ purpose: 'sale' }).sort({ createdAt: -1 })
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
      carousel,
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
});

// specified category 'when user clicks see all ' for example sell > http://sedDomain/sell ,, http://sedDomain/exchange ,, http://sedDomain/donate
router.get("/:category", (req, res) => {
  const category = req.params.category;
  const productsPerPage = 30;
  var pageNumber = req.query.page ? req.query.page : 1;
  var toSkip = (pageNumber - 1) * productsPerPage;
  if ( category==='sell' || category==='exchange' || category==='donate' ){
    Product.find({ purpose: category })
      .skip(toSkip)
      .limit(productsPerPage)
      .exec()
      .then((products) => {
        if (products.length <= 0) return res.status(444).json({ message: `Sorry, there are no more ${category} products to show ` });
        res.status(200).json(products);
      })
      .catch((err) => {
        res.status(505).json({ error_message: err });
      });
  }else{
    res.status(404).json({message:'Not found'});
  }
});

module.exports = router;
