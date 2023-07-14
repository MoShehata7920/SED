const router = require('express').Router()
const { verifyTokenAndAdmin, verifyToken, verifyTokenAndAuthorization } = require('../middleware/check-auth')
const userController = require('../controllers/userController')
const authController = require('../controllers/auth')
const { body, validationResult } = require('express-validator');
const productController=require('../controllers/productController')
const appImages=require('../models/appImages')

const multer = require('multer')
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './SEDimages/adminAppImages')
    },
    filename: (req, file, cb) => {
        cb(null, new Date().toDateString() + process.env.SPLIT_KEY + file.originalname)
    }
})
const upload = multer({
    storage: storage,
    limits: {
        fileSize: 1024 * 1024 * 5
    }
})

// ---------------------------------  users  ---------------------------------------

// @ getting all users , must be an admin  >> /admin/getallusers
router.get('/getallusers', verifyTokenAndAdmin, userController.getAllUsers)
// @ deleting user by his Id
router.delete('/delete/:userId', verifyTokenAndAdmin, userController.deleteUser)


// ---------------------------------  products  ---------------------------------------

//@ getting all products
router.get('/getallproducts', verifyTokenAndAdmin, productController.getAllProducts)

//deleting a product by it's Id , 'must be your product or you are admin'
router.delete('/product/:prodId', verifyTokenAndAdmin, productController.deleteProduct) 


// ---------------------------------- App Images  ---------------------------

router.post('/appImages',verifyTokenAndAdmin, upload.single('image'),async (req,res)=>{
    try {
        if (req.file) {
            req.body.image = `http://47.243.7.214:3000/${req.file.path}`;
          }
        const appImage  =  new appImages({
            imageLocation:req.body.imageLocation,
            image:req.body.image,
            sectionId:req.body.sectionId,
        })
        const doc = await appImage.save()
        res.status(200).json({status:0 , doc , message:"Image has been added successfully"})
    } catch (error) {
        res.status(500).json({status:1 , message:error.message})
    }
})

router.get('/application-images',verifyTokenAndAdmin,async (req,res)=>{
    try {
        const images =await appImages.find()
        res.status(200).json({status:0 , images})
    } catch (error) {
        res.status(500).json({status:1 , message:error.message})
    }
})

router.delete('/delete/:imageId', verifyTokenAndAdmin , async(req,res)=>{
    try {
        const imageId=req.params.imageId
        await appImages.find
        res.status(200).json({status:0 , message:"User deleted successfully"})
    } catch (error) {
        res.status(500).json({status:1 , message:error.message})
    }
})

module.exports=router