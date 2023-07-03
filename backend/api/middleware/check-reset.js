const User = require('../models/user')

exports.resetVerification = async (req, res, next) => {
    const token = req.query.token
    if (!token) return res.status(455).json('invalid Request')   // something wrong with values from query
    const user = await User.findOne({ reset_password_token: token, reset_password_expires: { $gt: Date.now() } });
    console.log(user)
    if (!user) return res.status(455).json('the token has been expired');      // only stays 6 hours
    if (!user.reset_password_token || !user.reset_password_expires) return res.status(455).json('something went wrong ,kindly ask for reset pw again '); //lw 7sl moshkla during forgot pw route we el values not updated
    if (!token === user.reset_password_token) return res.status(455).json('reset token not valid !');
    req.user = user;
    next()
}

exports.resetVerificationByOTP = async (req, res, next) => {
    const code = req.body.code
    if (!code) return res.status(406).json('invalid Request , please enter the reset code')   // something wrong with values from query
    const user = await User.findOne({ reset_password_token: code, reset_password_expires: { $gt: Date.now() } });
    // console.log(user)
    if (!user) return res.status(406).json('the code has been expired');      // only stays 6 hours
    if (!user.reset_password_token || !user.reset_password_expires) return res.status(500).json('something went wrong ,kindly ask for password reset again '); //lw 7sl moshkla during forgot pw route we el values not updated
    if (!code === user.reset_password_token) return res.status(406).json('reset token not valid !');
    req.user = user;
    next()
}