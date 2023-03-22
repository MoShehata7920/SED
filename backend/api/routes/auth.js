const passportSetup = require('../config/passport-setup')
const passport = require('passport')
const router = require('express').Router()
const authController = require('../controllers/auth');
const {resetVerification} = require('../middleware/check-reset')
const { body, validationResult } = require('express-validator');

router.post('/register',
    body('email').not().isEmpty().withMessage('Empty Mail Field').isEmail().withMessage('Not A Valid Mail'),
    body('password').not().isEmpty().withMessage('Empty Password Field').isLength({ min: 5 }).matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/).withMessage('weak password'),
    body('confirmPassword').custom((value, { req }) => {
        if (value !== req.body.password) { throw new Error('Password And Confirmation Doesn\'t Match'); }
        return true;
    }), authController.registerController);

// verify email
router.post('/verifyemail',authController.otpVerification);

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



module.exports = router;