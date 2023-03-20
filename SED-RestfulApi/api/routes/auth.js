var express = require('express');
var router = express.Router();
const authController = require('../controllers/auth');
const check_auth = require('../auth/check-auth');
const passport = require('passport');
const { body, validationResult } = require('express-validator');


router.post('/register',
    body('username').not().isEmpty().withMessage('Empty username Field'),
    body('username').matches(/^(?=.*[0-9])(?=.*[_\-@$#%!*])[a-zA-Z0-9_\-@$#%!*]+$/).withMessage('username not valied'),
    body('email').not().isEmpty().withMessage('Empty Mail Field'),
    body('email').isEmail().withMessage('Not A Valid Mail'),
    body('password').not().isEmpty().withMessage('Empty Password Field'),
    body('password').isLength({ min: 5 }).matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/).withMessage('weak password'),
    body('confirmPassword').custom((value, { req }) => {
        if (value !== req.body.password) { throw new Error('Password And Confirmation Doesn\'t Match'); }
        return true;
    }),
    authController.registerController);
    
router.post('/login',
    body('loginOption').not().isEmpty().withMessage('Empty Mail Or Phone Field'),
    body('password').not().isEmpty().withMessage('Empty Password Field'),
    authController.loginController);

router.get('/google', passport.authenticate('google', {
    scope: ['email', 'profile']
}));

router.get('/google/redirect', passport.authenticate('google'), authController.googleLogin);

router.post('/forgot', authController.forgetPassword);

router.post('/reset/:token',
    body('password').not().isEmpty().withMessage('Empty Password Field'),
    body('password').isLength({ min: 5 }).matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/).withMessage('weak password'),
    body('confirmPassword').custom((value, { req }) => {
        if (value !== req.body.password) { throw new Error('Password And Confirmation Doesn\'t Match'); }
        return true;
    }), authController.resetPassword);

router.get('/verifyrequest', check_auth, authController.verifyEmail);

router.post('/verifyconfirm',check_auth,
    body('code').not().isEmpty().isLength({ min: 6 }).withMessage('wrong code'),
    authController.otpVerification);

module.exports = router;
