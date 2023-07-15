const User = require('../models/user');
const bcrypt = require('bcrypt');
const dataCryption = require('../helpers/dataprotector');
const mailHelper = require('../helpers/mail');
const { body, validationResult } = require('express-validator');
const crypto = require('crypto');
const nodemailer = require('nodemailer');
const jwt = require('jsonwebtoken');

exports.registerController = async (req, res, next) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        const errorMessages = errors.array().map(error => error.msg);
        return res.status(400).json({ status: 1, message: errorMessages });
      }
  
      const { fullName, email, password, phone } = req.body;
  
      const userExists = await User.exists({ email });
      if (userExists) {
        return res.status(409).json({ status: 1, message: 'Email address is already registered' });
      }
  
      const hashedPassword = await bcrypt.hash(password, 10);
      const OTP = mailHelper.generateOTP();
      const expires = Date.now() + 3600000;
      const newUser = new User({
        fullName,
        email,
        password: hashedPassword,
        phone,
        verify_account_otp: OTP,
        verify_otp_expires: expires,
      });
      const doc = await newUser.save();
      const token = jwt.sign({
        email: doc.email,
        id: doc._id.toString(),
        fullName: doc.fullName,
        isAdmin: doc.isAdmin,
        isVerified: doc.isVerified
      },
      process.env.SECRET_KEY);
  
      mailHelper.mailTransport().sendMail({
        from: "sedteam@outlook.com",
        to: newUser.email,
        subject: "Verify your email address",
        html: mailHelper.generateVerifyEmailTemplate(OTP),
      }, (error) => {
        if (error) {
          return res.status(500).json({ status: 1, message: 'Error sending verification email', error });
        }
        res.status(200).json({ status: 0, message: 'Registration successful', token });
      });
    } catch (error) {
      console.log(error);
      res.status(500).json({ status: 1, message: 'Internal server error', Errors: error });
    }
  };
  
  exports.loginController = (req, res) => {
    const { loginOption, password } = req.body;
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      const errorMessages = errors.array().map(error => error.msg);
      return res.status(400).json({ status: 1, message: errorMessages });
    }
  
    User.findOne({ $or: [{ email: loginOption }, { phone: loginOption }] })
      .exec()
      .then(user => {
        if (!user) {
          return res.status(404).json({ status: 0, message: 'This Email does not exist. Please register first.' });
        }
  
        bcrypt.compare(password, user.password, (err, result) => {
          if (err) {
            return res.status(500).json({ status: 1, message: 'Server error', error: err });
          }
  
          if (result) {
            const token = jwt.sign({
              email: user.email,
              id: user._id.toString(),
              fullName: user.fullName,
              isAdmin: user.isAdmin,
              isVerified: user.isVerified
            },
            process.env.SECRET_KEY);
  
            return res.status(200).json({ status: 0, message: `Welcome back ${user.fullName}!`, token });
          }
  
          res.status(401).json({ status: 0, message: 'Wrong password. Try again or click Forgot password to reset it.' });
        });
      })
      .catch(err => {
        console.log(err);
        res.status(500).json({ status: 1, message: err });
      });
  };
  

  exports.googleLogin = async (req, res, next) => {
    try {
      const user = await User.findById(req.session.passport.user);
      if (!user) {
        return res.status(404).json({ status: 0, message: "User doesn't exist" });
      }
  
      const decryptedData = {
        id: user._id,
        fullName: user.fullName,
        email: user.email,
        createdAt: user.createdAt,
        isAdmin: user.isAdmin,
        isVerified: user.isVerified
      };
  
      const token = jwt.sign(decryptedData, process.env.SECRET_KEY);
  
      if (req.headers.mobile) {
        res.status(200).json({ status: 0, message: 'Logged in successfully', token, User: decryptedData });
      } else {
        res.redirect(`http://localhost:3006/SignIn?token=${token}`);
      }
    } catch (error) {
      console.log(error);
      res.status(500).json({ status: 1, message: error.message });
    }
  };
  
  exports.forgotPassword = async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
  
    const searchOption = req.body.searchOption;
    const user = await User.findOne({ $or: [{ email: searchOption }, { phone: searchOption }] });
  
    if (!user) {
      return res.status(404).json({ status: 0, message: "Can't find any user with this email address" });
    }
  
    const token = await mailHelper.createResetToken();
    const newUser = await User.findByIdAndUpdate(
      user._id,
      { reset_password_token: token, reset_password_expires: Date.now() + 60 * 60 * 1000 * 6 },
      { upsert: true, new: true }
    );
  
    mailHelper.mailTransport().sendMail({
      from: "sedteam@outlook.com",
      to: user.email,
      subject: "SED Support team - Reset Your Account Password",
      html: mailHelper.generateForgotPasswordTemplate(`http://${req.headers.host}/auth/reset?token=${token}`)
    });
  
    res.status(200).json({
      status: 0,
      user: newUser,
      message: 'Reset password email has been sent successfully to your email address'
    });
  };
  
  exports.resetPassword = async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        const errorMessages = errors.array().map(error => error.msg);
        return res.status(400).json({ message: errorMessages });
      }
  
      const user = await User.findOne({ _id: req.user._id });
      user.password = bcrypt.hashSync(req.body.password, 10);
      user.reset_password_token = undefined;
      user.reset_password_expires = undefined;
      await user.save();
  
      mailHelper.mailTransport().sendMail({
        from: process.env.MYMAIL,
        to: user.email,
        subject: 'Your new password has been confirmed',
        html: mailHelper.generateResetedPasswordTemplate(user.email)
      });
  
      res.status(200).json(user);
    } catch (error) {
      console.log(error);
      res.status(404).json(error);
    }
  };
  

  exports.sendOtpVerifyEmail = async (req, res, next) => {
    try {
      const userEmail = req.user.email;
  
      if (!userEmail) {
        return res.status(400).json({ status: 0, message: 'Error auth' });
      }
  
      const user = await User.findOne({ email: userEmail });
      if (!user) {
        return res.status(404).json({ status: 0, message: 'User not found' });
      }
  
      const otp = mailHelper.generateOTP();
      const expires = Date.now() + 3600000; // 1 hour
  
      user.verify_account_otp = otp;
      user.verify_otp_expires = expires;
  
      await user.save();
  
      const mailOptions = {
        to: user.email,
        from: process.env.MYMAIL,
        subject: 'Account Verification',
        html: mailHelper.generateVerifyEmailTemplate(otp)
      };
  
      mailHelper.mailTransport().sendMail(mailOptions, (error) => {
        if (error) {
          console.log(error);
          return res.status(500).json({ status: 1, message: 'Error sending verification email' });
        }
        res.status(200).json({ status: 0, message: 'Email sent' });
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ status: 1, message: 'Server Error' });
    }
  };
  
  exports.verifyEmailByOtp = async (req, res, next) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        const errorMessages = errors.array().map(error => error.msg);
        return res.status(400).json({ status: 1, message: errorMessages });
      }
  
      const otp = req.body.code;
  
      const user = await User.findOne({
        verify_account_otp: otp,
        verify_otp_expires: { $gt: Date.now() }
      });
  
      if (!user) {
        return res.status(404).json({ status: 0, message: 'Invalid or expired Code' });
      }
  
      user.isVerified = true;
      user.verify_account_otp = undefined;
      user.verify_otp_expires = undefined;
  
      await user.save();
  
      const token = jwt.sign({
        email: user.email,
        id: user._id.toString(),
        fullName: user.fullName,
        isAdmin: user.isAdmin,
        isVerified: user.isVerified
      }, process.env.SECRET_KEY);
  
      const username = user.fullName;
  
      const mailOptions = {
        to: user.email,
        from: process.env.MYMAIL,
        subject: 'Account Verification Successful',
        html: mailHelper.generateOtpVerifiedEmailTemplate(username)
      };
  
      mailHelper.mailTransport().sendMail(mailOptions, (error) => {
        if (error) {
          console.log(error);
        }
      });
  
      res.status(200).json({ status: 0, message: 'Account Verified', token });
    } catch (err) {
      console.log(err);
      res.status(500).json({ status: 1, message: 'Server Error' });
    }
  };
  


  exports.resendVerifyEmail = async (req, res) => {
    try {
      const userEmail = req.user.email;
  
      if (!userEmail) {
        return res.status(400).json({ status: 0, message: 'Error auth' });
      }
  
      const user = await User.findOne({ email: userEmail });
      if (!user) {
        return res.status(404).json({ status: 0, message: 'User not found' });
      }
  
      const otp = mailHelper.generateOTP();
      const expires = Date.now() + 3600000; // 1 hour
  
      await User.findByIdAndUpdate(req.user._id, { $set: { verify_account_otp: otp, verify_otp_expires: expires } }, { new: true });
  
      const mailOptions = {
        to: user.email,
        from: process.env.MYMAIL,
        subject: 'Account Verification Resend request',
        html: mailHelper.generateVerifyEmailTemplate(otp)
      };
  
      mailHelper.mailTransport().sendMail(mailOptions, (error) => {
        if (error) {
          console.log(error);
          return res.status(500).json({ status: 1, message: 'Error sending verification email' });
        }
        res.status(200).json({ status: 0, message: 'Email sent' });
      });
    } catch (err) {
      console.log(err);
      res.status(500).json({ status: 1, message: 'Server Error' });
    }
  };
  
  exports.forgotPasswordByOTP = async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
  
    const searchOption = req.body.searchOption;
    const user = await User.findOne({ $or: [{ email: searchOption }, { phone: searchOption }] });
  
    if (!user) {
      return res.status(404).json({ status: 0, message: "Can't find any user with this email address" });
    }
  
    const otp = mailHelper.generateOTP();
    const newUser = await User.findByIdAndUpdate(
      user._id,
      { reset_password_token: otp, reset_password_expires: Date.now() + 60 * 60 * 1000 * 6 },
      { upsert: true, new: true }
    );
  
    mailHelper.mailTransport().sendMail({
      from: "sedteam@outlook.com",
      to: user.email,
      subject: "SED Support team - Reset Your Account Password",
      html: mailHelper.generateForgotPasswordTemplateByOTP(otp)
    });
  
    res.status(200).json({
      status: 0,
      user: newUser,
      message: 'Reset password email has been sent successfully to your email address'
    });
  };
  
  exports.VerifyresetPasswordOTP = async (req, res) => {
    try {
      const errors = validationResult(req);
      if (!errors.isEmpty()) {
        const errorMessages = errors.array().map(error => error.msg);
        return res.status(400).json({ status: 1, message: errorMessages });
      }
  
      const otp = req.body.code;
  
      const user = await User.findOne({
        reset_password_token: otp,
        reset_password_expires: { $gt: Date.now() }
      });
  
      if (!user) {
        return res.status(404).json({ status: 0, message: 'Invalid or expired Code' });
      }
  
      user.reset_password_token = undefined;
      user.reset_password_expires = undefined;
  
      await user.save();
  
      const token = jwt.sign({
        id: user._id.toString(),
      }, process.env.SECRET_KEY, { expiresIn: '1h' });
  
      res.status(200).json({ status: 0, message: 'Go To Reset Page', token });
    } catch (err) {
      console.log(err);
      res.status(500).json({ status: 1, message: err });
    }
  };
  

// this endpoint is last step on reset after veryifing otp to write the new password  ' it takes password , confirmPassword ' 
exports.verifiedPwChange = async (req, res) => {
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      const errorMessages = errors.array().map(error => error.msg);
      return res.status(400).json({ status: 0, message: errorMessages });
    }
    try {
      const user = await User.findById(req.user.id);
  
      user.password = hashedPassword;
      await user.save();
  
      mailHelper.mailTransport().sendMail({
        from: process.env.MYMAIL,
        to: user.email,
        subject: 'Your new password has been Changed Successfully',
        html: mailHelper.generateResetedPasswordTemplate(user.email)
      });
  
      res.status(200).json({
        status: 0,
        message: "Password has been updated successfully"
      });
    } catch (err) {
      res.status(500).json({ status: 1, message: 'Server Error', error: err });
    }
  };
  