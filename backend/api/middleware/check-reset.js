const User=require('../models/user')
const mongoose=require('mongoose')

exports.resetVerification=async (req,res,next) => {
    const { token } = req.query
    if( !token)return res.status(455).json('invalid Request')   // something wrong with values from query
    const user = await User.findOne({  reset_password_token : token ,reset_password_expires:{       // if token expired so its time will be less than the current time so won't find user so he has to do reset request again!
        $gt : Date.now()
    }});
    if( !user ) return res.status(455).json('the token has been expired');      // only stays 6 hours
    if( !user.reset_password_token || !user.reset_password_expires ) return res.status(455).json('something went wrong ,kindly ask for reset pw again '); //lw 7sl moshkla during forgot pw route we el values not updated
    if( !token === user.reset_password_token ) return res.status(455).json('reset token not valid !');
    req.user=user;
    next()
}