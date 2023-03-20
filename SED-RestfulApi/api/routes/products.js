var express = require('express');
var router = express.Router();
const check_auth = require('../auth/check-auth');
const multer = require('multer');
const productController = require('../controllers/products');


const storage = multer.diskStorage({
  destination: function (req, file, cb) {
    cb(null, './SEDimages/products')
  },
  filename: function (req, file, cb) {
    cb(null, new Date().toDateString() +process.env.SPLIT_KEY+ file.originalname)
  }
});


const upload = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 5
  }
});

router.post('/', check_auth, upload.single('productImage'), productController.postNewProduct);

router.get('/',productController.getProductsByQuery);

router.get('/:product', productController.getProductById);

router.patch('/:product', check_auth, upload.single('productImage'), productController.updateProductById);

router.delete('/:product', check_auth, productController.deleteProductById);

router.get('/:productFor/:category/:page',productController.getProductsByParams);



module.exports = router;