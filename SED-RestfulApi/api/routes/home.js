var express = require('express');
var router = express.Router();
const homePageController=require('../controllers/homePageControl')

// router.get('/',homePageController.getHomePage);

router.get('/', (req, res) => {
  res.sendFile(__dirname + '/file.html');
});
router.get('/querystring',(req,res)=>{
    console.log(req.query)
    res.status(200).json({message: req.query})
  });


module.exports = router;