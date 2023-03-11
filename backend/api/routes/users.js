const router=require('express').Router()
const { body, validationResult } = require('express-validator')
const { verifyTokenAndAdmin, verifyToken } = require('../middleware/check-auth')
const {resetVerification} = require('../middleware/check-reset')
const userController=require('../controllers/userController')

// new user sign up 
router.post('/register',
    [body('password').isLength({min:5}).withMessage('Please enter a valid password with at least 5 chars')]
    , userController.userRegister )

// user login
router.post('/login', userController.userLogin )

// getting all users , must be an admin
router.get('/getallusers' , verifyTokenAndAdmin , userController.getAllUsers)

// To find a Single User , must be and admin or the userhim self
router.get('/:userId',verifyToken,userController.getSingleUser)

//updating user info
router.patch("/update/:userId", verifyToken ,userController.updateUser)

//deleting user by it's Id
router.delete('/delete/:userId',verifyTokenAndAdmin,userController.deleteUser)

// verify email
router.post('/verify-email',userController.verifyEmail)

//forgot password 
router.post('/forgot-password',
    [body('email').notEmpty().withMessage(' invalid parameter \'email\' ').isEmail().withMessage('Please Enter A valid email address')]
    ,userController.forgotPassword
)
//reset password redirect
router.post('/reset-password', resetVerification ,userController.resetPassword )

module.exports=router;