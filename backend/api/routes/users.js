const router = require('express').Router()
const { verifyTokenAndAdmin, verifyToken } = require('../middleware/check-auth')
const userController = require('../controllers/userController')
const authController = require('../controllers/auth')

const multer = require('multer')
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, './SEDimages/user-profile')
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

//updating user info
router.patch("/update/:userId", verifyToken,upload.single('userImage'), userController.updateUser)

//deleting user by it's Id
router.delete('/delete/:userId', verifyTokenAndAdmin, userController.deleteUser)

//if needed to verify another email after registration

// send verify email otp
router.get('/verifyrequest', authController.sendOtpVerifyEmail);

// check verify email otp
router.post('/verifyemail', authController.verifyEmailByOtp);

//route for user's wishlist adding/removing items
router.patch('/addToWishlist', verifyToken, userController.addToWishList);

//route for getting user's wishlist 
router.get('/getWishlist', verifyToken, userController.getWishlist);

// To find a Single User 
router.get('/get', verifyToken, userController.getSingleUser)

// getting all users , must be an admin
router.get('/getallusers', verifyTokenAndAdmin, userController.getAllUsers)



module.exports = router;