const router=require('express').Router()
const { verifyTokenAndAdmin ,verifyToken,verifyTokenAndAuthorization} = require('../middleware/check-auth')
const productController=require('../controllers/productController')

const multer=require('multer')
const storage=multer.diskStorage({
    destination:(req,file,cb)=>{
        cb(null,'./uploads/')
    },
    filename:(req,file,cb)=>{
        cb(null,file.originalname)
    }
})
const upload=multer({storage:storage})


//router for creating new product
router.post('/newproduct',upload.single('productImage'),productController.createProduct)

//finding single product by it's id
router.get('/product/:prodId',productController.getSingleProduct)

//updating product
router.patch('/product/:prodId', verifyToken ,upload.single('productImage'),productController.updateProduct)

//deleting a product by it's Id
router.delete('/product/:prodId',verifyTokenAndAuthorization,productController.deleteProduct)


                         //for admin dashboard
//getting all products
router.get('/getallproducts',verifyTokenAndAdmin,productController.getAllProducts)

module.exports=router;