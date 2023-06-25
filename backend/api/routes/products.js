const router = require('express').Router()
const { v4: uuidv4 } = require('uuid');
const fs = require('fs');
const path = require('path');
const { verifyTokenAndAdmin, verifyToken, verifyTokenAndAuthorization } = require('../middleware/check-auth')
const productController = require('../controllers/productController')

const multer = require('multer')
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
      cb(null, './SEDimages/products')
    },
    filename: (req, file, cb) => {
      const ext = file.originalname.split('.').pop(); // extract file extension
      // const filename = `${new Date().toDateString()}${uuidv4()}.${ext}`;
      const filename = `${new Date().toISOString().replace(/:/g, '-')}${uuidv4()}.${ext}`;
      const filePath = path.join('./SEDimages/products', filename);
  
      // Check if the file already exists
      fs.access(filePath, (err) => {
        if (err) {
          // File does not exist, so it's a new upload
          cb(null, filename);
        } else {
          // File already exists, so it's an update
          const existingFilename = req.body.filename; // retrieve the existing filename from the request body
          if (filename === existingFilename) {
            // The names are the same, so the image has not been updated
            cb(null, existingFilename);
          } else {
            // The names are different, so the image has been updated
            cb(null, filename);
          }
        }
      });
    }
  });
const upload = multer({
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 5
    }
})


//router for creating new product
router.post('/newproduct', verifyToken, upload.single('productImage'), productController.createProduct)

//finding single product by it's id
router.get('/product/:prodId', productController.getSingleProduct)

//updating product
router.patch('/product/:prodId', verifyToken, upload.single('productImage'), productController.updateProduct)

//deleting a product by it's Id , 'must be your product or you are admin'
router.delete('/product/:prodId', verifyTokenAndAuthorization, productController.deleteProduct)     

router.get('/get',productController.getProductsByQuery)

router.get('/:purpose/:category/:page',productController.getProductsByParams)

//specific user products
router.get('/seller/:sellerId',verifyToken,productController.userProducts)

//seperated search router
router.get('/search',productController.searchQuery)

//for admin dashboard
//getting all products
router.get('/getallproducts', verifyTokenAndAdmin, productController.getAllProducts)


module.exports = router;