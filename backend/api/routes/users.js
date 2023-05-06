const router = require('express').Router()
const { verifyTokenAndAdmin, verifyToken, verifyTokenAndAuthorization } = require('../middleware/check-auth')
const userController = require('../controllers/userController')
const authController = require('../controllers/auth')
const { body, validationResult } = require('express-validator');

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
router.patch("/update/:userId", verifyTokenAndAuthorization , upload.single('userImage') , [
    body('fullName').optional().isLength({ min: 4 }).withMessage('Name must be at least 4 characters').isString().withMessage('Please enter a valid string name'),
    body('phone').optional().isLength({ min: 11 , max : 20}).withMessage('Please enter a valid mobile number with 11 digit at least'),
    body('government').optional().isString().withMessage('Please choose valid goverment'),
    body('address').optional().isString().withMessage('Please choose valid address').isLength({ min: 5 , max : 100}),
    body('userImage').optional().isString().withMessage('image format error'),
] , userController.updateUser)

router.get('/myproduct',verifyToken,userController.userPostedProducts)

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

//changing user password
router.patch('/change-password/:userId',verifyTokenAndAuthorization ,
[
    body('password').isLength({ min: 5 }).matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/).withMessage('weak password , Enter a strong one that contains cap chars and numbers'),
    body('confirmPassword').custom((value, { req }) => {
        if (value !== req.body.password) { throw new Error('Password And Confirmation Doesn\'t Match'); }
        return true;
    }),
    body('oldPassword').custom((value, { req }) => {
        if (value === req.body.password) { throw new Error('You can\'t use your old password again '); }
        return true;
    })
],userController.passwordChange)

module.exports = router;