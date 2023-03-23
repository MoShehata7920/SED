const router = require("express").Router();
const homeController=require('../controllers/homeController');

// the main page route >> http://sedDomain/
router.get("/", homeController.homePage);

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
