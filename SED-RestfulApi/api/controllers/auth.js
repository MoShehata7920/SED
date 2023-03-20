const User = require('../models/User');
const bcrypt = require('bcrypt');
const dataCryption = require('../helpers/dataprotector');
const mailHelper=require('../helpers/mail');
const { body, validationResult } = require('express-validator');
const crypto = require('crypto');
const nodemailer = require('nodemailer');
const jwt = require('jsonwebtoken');


exports.registerController = async (req, res, next) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      const errorMessages = errors.array().map(error => error.msg);
      res.status(400).json({ message: errorMessages });
      return;
    }

    const { firstname, lastname, username, email, password, phone, address, city, country } = req.body;

    const userExists = await User.exists({ email });
    if (userExists) {
      res.status(409).json({ message: 'Email address is already registered' });
      return;
    }

    const hashedPassword = await bcrypt.hash(password, 10);
    const newUser = new User({
      firstName: dataCryption.encryptData(firstname),
      lastName: dataCryption.encryptData(lastname),
      userName: username,
      email,
      password: hashedPassword,
      phone,
      address: dataCryption.encryptData(address),
      city: dataCryption.encryptData(city),
      country: dataCryption.encryptData(country),
    });

    const doc = await newUser.save();
    res.status(201).json({ message: 'Registration successful', user: doc });
  } catch (error) {
    res.status(500).json({ message: 'Internal server error', Errors: error });
  }
};

exports.loginController = async (req, res, next) => {
  const { loginOption, password } = req.body;
  const errors = validationResult(req);
  if (!errors.isEmpty()) {
    const errorMessages = errors.array().map(error => error.msg);
    res.status(500).json({ message: errorMessages });
    return;
  }
  try {
    const user = await User.findOne({ $or: [{ email: loginOption }, { phone: loginOption }] });
    if (!user) {
      res.status(404).json({ message: "User doesn't exist" });
      return;
    }
    const match = await bcrypt.compare(password, user.password);
    if (!match) {
      res.status(404).json({ message: "Wrong password" });
      return;
    }
    const decryptedData = {
      _id: user._id,
      fullname: dataCryption.decryptdData(user.firstName) + ' ' + dataCryption.decryptdData(user.lastName),
      username: user.userName,
      email: user.email,
      created: user.created
    };
    const expiresIn = "10h";
    const token = jwt.sign(decryptedData, process.env.SECRET_KEY, { expiresIn });
    res.status(200).json({ message: 'Logged in successfully', token, User: decryptedData });
  } catch (error) {
    console.log(error)
    res.status(500).json({ message: error.message });
  }
};

exports.googleLogin = async (req, res, next) => {
  try {
    const user = await User.findById(req.session.passport.user);
    if (!user) {
      res.status(404).json({ message: "User doesn't exist" });
      return;
    }
    const decryptedData = {
      _id: user._id,
      fullname: dataCryption.decryptdData(user.firstName) + ' ' + dataCryption.decryptdData(user.lastName),
      username: user.userName,
      email: user.email,
      created: user.created
    };
    const expiresIn = "10h";
    const token = jwt.sign(decryptedData, process.env.SECRET_KEY, { expiresIn });
    res.status(200).json({ message: 'Logged in successfully', token, User: decryptedData });
  } catch (error) {
    res.status(500).json({ message: error.message });
  }
};

exports.forgetPassword = async (req, res, next) => {
  try {
    const searchOption = req.body.resetOption;

    if (!searchOption) {
      return res.status(400).json({ message: 'Email or Phone-Number is required' });
    }

    const user = await User.findOne({ $or: [{ email: searchOption }, { phone: searchOption }] });
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    const token = crypto.randomBytes(20).toString('hex');
    const expires = Date.now() + 3600000; // 1 hour

    user.resetPasswordToken = token;
    user.resetPasswordExpires = expires;

    await user.save();

    const link = `http://${req.headers.host}/auth/reset/${token}`;

    const mailOptions = {
      to: user.email,
      from: process.env.MYMAIL,
      subject: 'Password Reset Request',
      html: mailHelper.generateForgotPasswordTemplate(link)
    };
    mailHelper.mailTransport().sendMail(mailOptions);
    res.status(200).json({ message: 'Email sent' });
  } catch (err) {
    console.log(err)
    res.status(500).json({ message: 'Server Error' });
  }
};

exports.resetPassword = async (req, res, next) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      const errorMessages = errors.array().map(error => error.msg);
      return res.status(400).json({ message: errorMessages });
    }

    const password = req.body.password;
    const hashedPassword = await bcrypt.hash(password, 10);

    const user = await User.findOne({
      resetPasswordToken: req.params.token,
      resetPasswordExpires: { $gt: Date.now() },
    });

    if (!user) {
      return res.status(404).json({ message: 'Invalid or expired token' });
    }

    user.password = hashedPassword;
    user.resetPasswordToken = undefined;
    user.resetPasswordExpires = undefined;

    await user.save();

    const transporter = nodemailer.createTransport({
      service: "hotmail",
      auth: {
        user: process.env.MYMAIL,
        pass: process.env.MAILPASSWORD
      }
    });

    const mailOptions = {
      to: user.email,
      from: process.env.MYMAIL,
      subject: 'Your new password has been confirmed',
      html: mailHelper.generateResetedPasswordTemplate(user.email)
    };

    mailHelper.mailTransport().sendMail(mailOptions);

    return res.status(200).json({ message: 'Password changed' });
  } catch (err) {
    return res.status(500).json({ message: 'Server Error' });
  }
};

exports.verifyEmail = async (req, res, next) => {
  try {
    const userEmail = req.userData.email;

    if (!userEmail) {
      return res.status(400).json({ message: 'Error auth' });
    }

    const user = await User.findOne({ email: userEmail });
    if (!user) {
      return res.status(404).json({ message: 'User not found' });
    }

    const otp = mailHelper.generateOTP()
    const expires = Date.now() + 3600000; // 1 hour

    user.verifyAccountOtp = otp;
    user.verifyOtpExpires = expires;

    await user.save();

    const transporter = nodemailer.createTransport({
      service: "hotmail",
      auth: {
        user: process.env.MYMAIL,
        pass: process.env.MAILPASSWORD
      }
    });

    const mailOptions = {
      to: user.email,
      from: process.env.MYMAIL,
      subject: 'Account Verification',
      html:mailHelper.generateVerifyEmailTemplate(otp)
    };
    mailHelper.mailTransport().sendMail(mailOptions);

    res.status(200).json({ message: 'Email sent' });
  } catch (err) {
    console.log(err)
    res.status(500).json({ message: 'Server Error' });
  }
};

exports.otpVerification = async (req, res, next) => {
  try {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      const errorMessages = errors.array().map(error => error.msg);
      return res.status(400).json({ message: errorMessages });
    }

    const otb = req.body.code;

    const user = await User.findOne({
      verifyAccountOtp: otb,
      verifyOtpExpires: { $gt: Date.now() },
    });

    if (!user) {
      return res.status(404).json({ message: 'Invalid or expired Code' });
    }

    user.isVerified = true;
    user.verifyAccountOtp = undefined;
    user.verifyOtpExpires = undefined;

    await user.save();
    const username= dataCryption.decryptdData(user.firstName)
    const transporter = nodemailer.createTransport({
      service: "hotmail",
      auth: {
        user: process.env.MYMAIL,
        pass: process.env.MAILPASSWORD
      }
    });

    const mailOptions = {
      to: user.email,
      from: process.env.MYMAIL,
      subject: 'Account Verification Successful',
      html: mailHelper.generateOtpVerifiedEmailTemplate(username)
    };

    mailHelper.mailTransport().sendMail(mailOptions);

    return res.status(200).json({ message: 'Account Verified' });
  } catch (err) {
    return res.status(500).json({ message: 'Server Error' });
  }
};

