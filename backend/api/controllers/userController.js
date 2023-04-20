const User = require('../models/user')
const Product=require('../models/product');
const mongoose = require('mongoose')
const bcrypt = require('bcrypt')
const jwt = require('jsonwebtoken')
const { generateOTP, mailTransport, creatResetToken, generateForgotPasswordTemplate } = require('../helpers/mail')
const EmailVerification = require('../models/emailVerification')
const { body, validationResult } = require('express-validator')


exports.addToWishList = async (req, res) => {
  const { id } = req.user
  const prodId = req.body.prodId
  try {
    const user = await User.findById(id);
    const alreadyExisted = user.wishList.find((element) => element.toString() === prodId) // condition to check if the product is already exists in user wishlst or not
    if (alreadyExisted) {
      let user = await User.findByIdAndUpdate(id, { $pull: { wishList: prodId } }, { new: true })
      res.status(200).json(user);
    } else {
      let user = await User.findByIdAndUpdate(id, { $push: { wishList: prodId } }, { new: true })
      res.status(200).json(user);
    }
  } catch (error) {
    res.status(404).json(error);
  }
};

exports.getWishlist = async (req, res, next) => {
  try {
      const id = req.user.id;
      const user = await User.findById(id);
      if (!user) {
          return res.status(404).json({ message: 'User not found' });
      }
      const favProducts = user.wishList;
      const favProductsInfo = await Product.find({ _id: { $in: favProducts } }, '-__v');
      res.status(200).json(favProductsInfo);
  } catch (error) {
      console.log(error);
      res.status(500).json({ error: error });
  }
};

//for admin dashboard
// (1) getting all users 
exports.getAllUsers = (req, res) => {
  User.find()
    .select('-password')            // to hide user password
    .exec()
    .then(docs => {
      res.status(200).json(docs)
    }).catch(err => {
      res.status(500).json(err)
    })
}

//getting single user 
exports.getSingleUser = async(req, res) => {
  try {
    const user=await User.findById(req.params.userId)
    if(!user){
      res.status(200).json({status:1,message:'There Is No User with this id '})
    }
    res.status(200).json({status:0,user})
  } catch (error) {
    res.status(500).json({success:1,error})
  }
}

// (2) updating single user
exports.updateUser = (req, res) => {
  if (req.user.id === req.params.userId || req.user.isAdmin) {
    User.findByIdAndUpdate(req.params.userId, { $set: req.body }, { new: true })
      .then((newdoc) => {
        res.status(200).json(newdoc);
      })
      .catch((err) => {
        res.status(500).json(err);
      });
  } else {
    console.log('Error from updating user else condition');
  }
}

// (3) deleting single user
exports.deleteUser = (req, res) => {
  User.findById(req.params.userId).exec().then(doc => {
    if (doc) {
      User.deleteOne({ _id: req.params.userId }).exec().then(() => {
        res.status(200).json('user has been deleted successfully')
      })
    } else {
      res.status(404).json('There is no user with this id')
    }
  }).catch(err => {
    res.status(500).json(err)
  })
}
