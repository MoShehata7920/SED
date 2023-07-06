const passportSetup = require('../config/passport-setup')
const passport = require('passport')
const router = require('express').Router()
const authController = require('../controllers/auth');
const {resetVerification , resetVerificationByOTP } = require('../middleware/check-reset')
const { body, validationResult } = require('express-validator');
const { verifyTokenAndAdmin, verifyToken , verifyTokenAndAuthorization } = require('../middleware/check-auth')

router.post('/register',
    body('email').not().isEmpty().withMessage('Empty Mail Field').isEmail().withMessage('Not A Valid Mail'),
    body('phone').not().isEmpty().withMessage('Empty Phone Field'),
    body('password').not().isEmpty().withMessage('Empty Password Field').isLength({ min: 5 }).matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/).withMessage('weak password'),
    body('confirmPassword').custom((value, { req }) => {
        if (value !== req.body.password) { throw new Error('Password And Confirmation Doesn\'t Match'); }
        return true;
    }), authController.registerController);



// verify email
router.post('/verifyemail',verifyToken,
body('code').not().isEmpty().withMessage('Empty code Field'),
authController.verifyEmailByOtp);

router.post('/login',
    body('loginOption').not().isEmpty().withMessage('Empty Mail Or Phone Field'),
    body('password').not().isEmpty().withMessage('Empty Password Field'),
    authController.loginController);

router.get('/', (req, res) => {
    res.send("<button><a href='/auth/google'>Login With Google</a></button>")
});

router.get('/google', passport.authenticate('google', {
    scope:
        ['email', 'profile']
}));

router.get('/google/redirect', passport.authenticate('google', { failureRedirect: '/' })
    , authController.googleLogin);

router.post('/forgot', authController.forgotPassword);

router.post('/reset',resetVerification,
    body('password').not().isEmpty().withMessage('Empty Password Field'),
    body('password').isLength({ min: 5 }).matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/).withMessage('weak password'),
    body('confirmPassword').custom((value, { req }) => {
        if (value !== req.body.password) { throw new Error('Password And Confirmation Doesn\'t Match'); }
        return true;
    }), authController.resetPassword);


router.get('/logout', (req, res) => {
    req.logout()
    res.redirect('/')
});

// @route for resending email verification
router.post('/resendVerifyEmail',verifyToken,authController.resendVerifyEmail)


//new edits for mobile app to send otp as the email verify with  otp
router.post('/forgotOTP', authController.forgotPasswordByOTP);
router.post('/resetOTP',
    body('code').matches(/^.{6}$/)  //  validating is onyl 6 chars
    .withMessage('Code must be 6 characters long.')
    , authController.VerifyresetPasswordOTP);
router.patch('/verified-pw-change',verifyTokenAndAuthorization
    ,[
    body('password').isLength({ min: 5 }).matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/).withMessage('weak password , Enter a strong one that contains cap chars and numbers'),
    body('confirmPassword').custom((value, { req }) => {
        if (value !== req.body.password) { throw new Error('Password And Confirmation Doesn\'t Match'); }
        return true;
    }),
    ],authController.verifiedPwChange)
//////////////////

module.exports = router;