const User = require('../models/User');
const product = require('../models/Product');
const bcrypt = require('bcrypt');
const dataCryption = require('../helpers/dataprotector');
const { body, validationResult } = require('express-validator');

exports.updateProfile = async (req, res, next) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            const errorMessages = errors.array().map(error => error.msg);
            res.status(400).json({ message: errorMessages });
            return;
        }
        const { firstName, lastName, userName, email, oldPassword, newPassword, phone, address, city, country } = req.body;
        const user = await User.findById(req.userData._id).select('password');
        if (user.password) {
            if (!oldPassword) {
                res.status(404).json({ message: "you must confirm your password" });
                return;
            }
            const match = await bcrypt.compare(oldPassword, user.password);
            if (!match) {
                res.status(404).json({ message: "Wrong password" });
                return;
            }
        }
        const newUserData = {};
        if (firstName) {
            newUserData.firstName = dataCryption.encryptData(firstName);
        } else {
            newUserData.firstName = user.firstName;
        }
        if (lastName) {
            newUserData.lastName = dataCryption.encryptData(lastName);
        } else {
            newUserData.lastName = user.lastName;
        }
        if (userName) {
            newUserData.userName = userName;
        } else {
            newUserData.userName = user.userName;
        }
        if (email) {
            newUserData.email = email;
        } else {
            newUserData.email = user.email;
        }
        if (phone) {
            newUserData.phone = phone;
        } else {
            newUserData.phone = user.phone;
        }
        if (address) {
            newUserData.address = dataCryption.encryptData(address);
        } else {
            newUserData.address = user.address;
        }
        if (city) {
            newUserData.city = dataCryption.encryptData(city);
        } else {
            newUserData.city = user.city;
        }
        if (country) {
            newUserData.country = dataCryption.encryptData(country);
        } else {
            newUserData.country = user.country;
        }
        if (newPassword) {
            const hashedPassword = await bcrypt.hash(newPassword, 10);
            newUserData.password = hashedPassword;
        } else {
            if (!user.password) {
                res.status(500).json({ message: "you must add a password" });
                return
            }
        }
        const ackg = await User.updateOne({ _id: req.userData._id }, { $set: newUserData });
        res.status(202).json({ message: ackg });
    } catch (err) {
        res.status(500).json({ message: err });
    }
};

exports.postWishList = async (req, res) => {
    const productId = req.body.productId;
    const userId = req.userData._id;
    try {
        // find the user by their ID
        const user = await User.findById(userId)

        if (!user.wishlist) {
            let user = await User.findByIdAndUpdate(userId, { $push: { wishlist: productId } }, { new: true })
            return res.status(200).json({ message: 'Product added to wishlist.' });
        }
        // check if the product is already in the wishlist
        const alreadyExist = user.wishlist.find((product) => product.toString() === (productId));
        if (!alreadyExist) {
            // product is not in the wishlist, so add it
            let user = await User.findByIdAndUpdate(userId, { $push: { wishlist: productId } }, { new: true })
            res.status(200).json({ message: 'Product added to wishlist.' });
        } else {
            // product is already in the wishlist, so remove it
            let user = await User.findByIdAndUpdate(userId, { $pull: { wishlist: productId } }, { new: true })
            res.status(200).json({ message: 'Product removed from wishlist.' });
        }
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: 'An error occurred.' });
    }
};

exports.getWishlist = async (req, res, next) => {
    try {
        const userId = req.userData._id;
        const user = await User.findById(userId);
        if (!user) {
            return res.status(404).json({ message: 'User not found' });
        }
        const favProducts = user.wishlist;
        const favProductsInfo = await product.find({ _id: { $in: favProducts } }, '-__v');
        res.status(200).json(favProductsInfo);
    } catch (error) {
        console.log(error);
        res.status(500).json({ error: error });
    }
};

