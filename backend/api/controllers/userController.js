const User = require("../models/user");
const Product = require("../models/product");
const bcrypt = require("bcrypt");
const { body, validationResult } = require("express-validator");

exports.addToWishList = async (req, res) => {
  const { id } = req.user;
  const prodId = req.body.prodId;
  try {
    const user = await User.findById(id);
    const alreadyExisted = user.wishList.find(
      (element) => element.toString() === prodId
    ); // condition to check if the product is already exists in user wishlst or not
    if (alreadyExisted) {
      let user = await User.findByIdAndUpdate(
        id,
        { $pull: { wishList: prodId } },
        { new: true }
      );
      res.status(200).json({ status: 0, user: user.wishList });
    } else {
      let user = await User.findByIdAndUpdate(
        id,
        { $push: { wishList: prodId } },
        { new: true }
      );
      res.status(200).json({ status: 0, user: user.wishList });
    }
  } catch (error) {
    res.status(404).json({ status: 1, error });
  }
};

exports.getWishlist = async (req, res, next) => {
  try {
    const id = req.user.id;
    const user = await User.findById(id);
    if (!user) {
      return res.status(400).json({ status: 0, message: "User not found" });
    }
    const favProducts = user.wishList;
    const favProductsInfo = await Product.find({ _id: { $in: favProducts } });
    const items = favProductsInfo.map((el) => {
      el = el.toObject();
      el.isSaved = true;
      return el;
    });
    console.log(items);
    res.status(200).json({ status: 0, items });
  } catch (err) {
    console.log(err);
    res.status(500).json({ status: 1, err });
  }
};

//for admin dashboard
// (1) getting all users
exports.getAllUsers = (req, res) => {
  User.find()
    .select("-password") // to hide user password
    .exec()
    .then((docs) => {
      res.status(200).json({ status: 0, docs });
    })
    .catch((err) => {
      res.status(500).json({ status: 1, err });
    });
};

//getting single user
exports.getSingleUser = async (req, res) => {
  try {
    const user = await User.findById(req.user.id).select(
      "-password -verify_account_otp -verify_otp_expires -__v "
    );
    if (!user) {
      res
        .status(200)
        .json({ status: 0, message: "There Is No User with this id " });
    }
    res.status(200).json({ status: 0, user });
  } catch (error) {
    res.status(500).json({ success: 1, error });
  }
};

// (2) updating single user
exports.updateUser = async (req, res) => {
  try {
    // validation result
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      const errorMessages = errors.array().map(error=>error.msg);
      return res.status(400).json({ status: 0, message: errorMessages });
    }

    if (req.file) {
      req.body.userImage = `http://47.243.7.214:3000/${req.file.path}`;
    }
    const updated = await User.findByIdAndUpdate(
      req.params.userId,
      {
        $set: {
          fullName: req.body.fullName,
          userImage: req.body.userImage,
          phone: req.body.phone,
          address: req.body.address,
          government: req.body.government,
        },
      },
      { new: true }
    );
    res.status(200).json({
      status: 0,
      message: "User information has been updated successfully",
      updated,
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({ status: 1, err });
  }
};

exports.passwordChange= async(req,res)=>{
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const errorMessages = errors.array().map(error=>error.msg);
    return res.status(400).json({ status: 0, message: errorMessages });
  }

  try {
    const user=await User.findById(req.params.userId)
    const match = await bcrypt.compare(req.body.oldPassword , user.password ); // checks if old password true
    if(match){
      const hashedPassword=await bcrypt.hash(req.body.password,10)
      const updated = await User.findByIdAndUpdate(
        req.params.userId,
        {
          $set: {
            password:hashedPassword,
          },
        },
        { new: true }
      );
      res.status(200).json({
        status: 0,
        message: "Password has been updated successfully",
        updated,
      });
    }else{
      return res.status(200).json({message:"old password is wrong"})
    }
  } catch (err) {
    res.status(400).json({message:err.message , err})
  }
}

exports.userPostedProducts = async (req, res, next) => {
  const result = await Product.find({ seller: req.user.id });
  res.status(200).json({ status: 0, result });
};

// (3) deleting single user
exports.deleteUser = (req, res) => {
  User.findById(req.params.userId)
    .exec()
    .then((doc) => {
      if (doc) {
        User.deleteOne({ _id: req.params.userId })
          .exec()
          .then(() => {
            res.status(200).json({
              status: 0,
              message: "user has been deleted successfully",
            });
          });
      } else {
        res
          .status(404)
          .json({ status: 0, message: "There is no user with this id" });
      }
    })
    .catch((err) => {
      res.status(500).json({ status: 1, err });
    });
};
