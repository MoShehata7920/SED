var express = require('express');
var router = express.Router();
const userController = require('../controllers/users');
const check_auth = require('../auth/check-auth');
const { body, validationResult } = require('express-validator');


router.patch('/updateProfile',
    body('newPassword').not().isEmpty().withMessage('Empty Password Field'),
    body('newPassword').isLength({ min: 5 }).matches(/^(?=.*\d)(?=.*[a-z])(?=.*[A-Z])(?=.*[a-zA-Z]).{8,}$/).withMessage('weak password'),
    body('confirmPassword').custom((value, { req }) => {
        if (value !== req.body.newPassword) { throw new Error('Password And Confirmation Doesn\'t Match'); }
        return true;
    }), check_auth, userController.updateProfile);


router.post('/favlist', check_auth, userController.postWishList);

router.get('/favlist', check_auth, userController.getWishlist);
  
  




module.exports = router;