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

// creating carousel images
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
//displaying carousel images
router.get('/application-images',verifyTokenAndAdmin,async (req,res)=>{
    try {
        const images =await appImages.find({imageLocation: 'carousel'})
        res.status(200).json({status:0 , images})
    } catch (error) {
        res.status(500).json({status:1 , message:error.message})
    }
})

//deleting carousel images
router.delete('/delete/:imageId', verifyTokenAndAdmin , async(req,res)=>{
    try {
        const imageId=req.params.imageId
        await appImages.find()
        res.status(200).json({status:0 , message:"User deleted successfully"})
    } catch (error) {
        res.status(500).json({status:1 , message:error.message})
    }
})

router.patch('/editcarousel/:imageId',upload.single('image'),verifyTokenAndAdmin,async(req,res)=>{
    const imageId=req.params.imageId
    try {
        const image = await Product.findOne({ _id: imageId });
        if (!image) {
          return res.status(400).json({ status: 0, message: 'There is no image with this id' });
        }
        const newPhoto = req.file ? `http://47.243.7.214:3000/${req.file.path}` : null;
        const oldPhoto = product.productImage;
        const needToDelete = newPhoto !== oldPhoto;
        const updatedImage = newPhoto ? newPhoto : oldPhoto;
    
        try {
          await fs.promises.access(updatedImage);
    
          // File already exists, so it's an update
          const existingFilename = path.basename(oldPhoto);
          const newFilename = path.basename(updatedImage);
    
            if (newFilename === existingFilename) {
            // The names are the same, so the image has not been updated
            // Update the product with the existing filename
                await appImages.updateOne({ _id: imageId }, { $set: { ...req.body, image: oldPhoto, updatedAt: Date.now() } });
            } else {
            // The names are different, so the image has been updated
            // Update the product with the new filename
            await appImages.updateOne({ _id: imageId }, { $set: { ...req.body, image: updatedImage, updatedAt: Date.now() } });
    
            if (needToDelete &&  fs.existsSync(oldPhoto)) {
                await fs.promises.unlink(oldPhoto);
            }
            }
        } catch (err) {
          // File does not exist, so it's a new upload
          // Update the product with the new filename
            await appImages.updateOne({ _id: imageId }, { $set: { ...req.body, image : updatedImage, updatedAt: Date.now() } });
    
            if (needToDelete &&  fs.existsSync(oldPhoto)) {
                await fs.promises.unlink(oldPhoto);
            }
        }
    
        res.status(200).json({ status: 0, message: 'image has been updated successfully' });
        } catch (err) {
            console.log(err)
        res.status(500).json({ status: 1, err });

        }
    
})
module.exports=router