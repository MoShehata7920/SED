const User = require("../models/user");
const Product = require("../models/product");
const bcrypt = require("bcrypt");
const { body, validationResult } = require("express-validator");

exports.addToWishList = async (req, res) => {
  const { id } = req.user;
  const prodId = req.body.prodId;
  try {
    const user = await User.findById(id);
    const alreadyExisted = user.wishList.includes(prodId); // Check if the product already exists in the user's wishlist
    let updatedUser;

    if (alreadyExisted) {
      updatedUser = await User.findByIdAndUpdate(
        id,
        { $pull: { wishList: prodId } },
        { new: true }
      );
    } else {
      updatedUser = await User.findByIdAndUpdate(
        id,
        { $push: { wishList: prodId } },
        { new: true }
      );
    }

    res.status(200).json({ status: 0, user: updatedUser.wishList });
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
    const items = favProductsInfo.map((el) => ({
      ...el.toObject(),
      isSaved: true,
    }));

    res.status(200).json({ status: 0, items });
  } catch (err) {
    console.log(err);
    res.status(500).json({ status: 1, err });
  }
};

exports.getAllUsers = (req, res) => {
  User.find()
    .select("-password")
    .exec()
    .then((docs) => {
      res.status(200).json({ status: 0, users: docs });
    })
    .catch((err) => {
      res.status(500).json({ status: 1, err });
    });
};

exports.getSingleUser = async (req, res) => {
  try {
    const user = await User.findById(req.user.id).select(
      "-password -verify_account_otp -verify_otp_expires -__v"
    );
    if (!user) {
      res.status(200).json({ status: 0, message: "User not found" });
    }
    res.status(200).json({ status: 0, user });
  } catch (error) {
    res.status(500).json({ status: 1, error });
  }
};

exports.updateUser = async (req, res) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      const errorMessages = errors.array().map((error) => error.msg);
      return res.status(400).json({ status: 0, message: errorMessages });
    }

    if (req.file) {
      req.body.userImage = `http://47.243.7.214:3000/${req.file.path}`;
    }

    const updateFields = {
      fullName: req.body.fullName,
      userImage: req.body.userImage,
      phone: req.body.phone,
      address: req.body.address,
      government: req.body.government,
    };

    if (req.user.isAdmin) {
      updateFields.isAdmin = req.body.isAdmin;
    }

    const updatedUser = await User.findByIdAndUpdate(
      req.params.userId,
      { $set: updateFields },
      { new: true }
    );

    res.status(200).json({
      status: 0,
      message: "User information has been updated successfully",
      updated: updatedUser,
    });
  } catch (err) {
    console.log(err);
    res.status(500).json({ status: 1, err });
  }
};

exports.passwordChange = async (req, res) => {
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const errorMessages = errors.array().map((error) => error.msg);
    return res.status(400).json({ status: 0, message: errorMessages });
  }

  try {
    const user = await User.findById(req.params.userId);
    const match = await bcrypt.compare(req.body.oldPassword, user.password);

    if (match) {
      const hashedPassword = await bcrypt.hash(req.body.password, 10);
      const updatedUser = await User.findByIdAndUpdate(
        req.params.userId,
        {
          $set: {
            password: hashedPassword,
          },
        },
        { new: true }
      );

      res.status(200).json({
        status: 0,
        message: "Password has been updated successfully",
        updated: updatedUser,
      });
    } else {
      return res.status(200).json({ message: "Old password is incorrect" });
    }
  } catch (err) {
    res.status(400).json({ message: err.message, err });
  }
};

exports.userPostedProducts = async (req, res, next) => {
  try {
    const userId = req.user.id;
    const result = await Product.find({ seller: userId });
    res.status(200).json({ status: 0, result });
  } catch (error) {
    res.status(500).json({ status: 1, error });
  }
};

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
              message: "User has been deleted successfully",
            });
          });
      } else {
        res
          .status(404)
          .json({ status: 0, message: "User not found" });
      }
    })
    .catch((err) => {
      res.status(500).json({ status: 1, err });
    });
};

exports.singleUserByHisId = async (req, res) => {
  try {
    const user = await User.findById(req.params.userId);
    if (!user) {
      return res.status(404).json({ message: "User not found" });
    }
    res.status(200).json({ user });
  } catch (error) {
    return res.status(500).json({ message: error.message });
  }
};

