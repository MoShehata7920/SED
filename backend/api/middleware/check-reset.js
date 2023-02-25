const User=require('../models/user')
const mongoose=require('mongoose')

exports.resetVerification=async (req,res,next) => {
    const { token , id } = req.query
    if( !token || !id )return res.status(455).json('invalid Request')   // something wrong with values from query
    if( !mongoose.isValidObjectId(id) )  return res.status(455).json('invalid req ,something wrong with user Id')
    // const user = await User.findById(id)
    const user = await User.findOne({ _id : id ,reset_password_expires:{       // if token expired so its time will be less than the current time so won't find user so he has to do reset request again!
        $gt : Date.now()
    }})

    if( !user ) return res.status(455).json('the token has been expired')      // only stays 6 hours
    if( !user.reset_password_token || !user.reset_password_expires ) return res.status(455).json('something went wrong ,kindly ask for reset pw again ') //lw 7sl moshkla during forgot pw route we el values not updated
    if( !token === user.reset_password_token ) return res.status(455).json('reset token not valid !')

    req.user=user
    next()
}