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
            res.status(400).json({status:0, message: errorMessages });
            return;
        }

        const { fullName, email, password, phone} = req.body;

        const userExists = await User.exists({ email });
        if (userExists) {
            res.status(200).json({ status:0, message: 'Email address is already registered' });
            return;
        }
        // const personalInfo = {
        //     phone,
        // }
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
            email:doc.email,
            id: doc._id.toString(),
            fullName: doc.fullName,
            isAdmin: doc.isAdmin,
            isVerified : doc.isVerified
        },
            process.env.SECRET_KEY
            // , {
            //     expiresIn: '10h'
            // }
        )
        res.status(200).json({ status:0,message: 'Registration successful', token });
        mailHelper.mailTransport().sendMail({
            from: "sedteam@outlook.com",
            to: newUser.email,
            subject: "Verify your email address",
            html: mailHelper.generateVerifyEmailTemplate(OTP),
        })
    } catch (error) {
        console.log(error)
        res.status(500).json({ status:1,message: 'Internal server error', Errors: error });
    }
};

exports.loginController = (req, res) => {
    const { loginOption, password } = req.body;
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        const errorMessages = errors.array().map(error => error.msg);
        res.status(200).json({ message: errorMessages });
        return;
    }
    User.findOne({ $or: [{ email: loginOption }, { phone: loginOption }] }).exec().then(user => {
        if (!user) {                                                                                             //if email not found 
            return res.status(500).json({ status: 0, message: 'This Email Not exist , Please Register First' })
        }
        bcrypt.compare(req.body.password, user.password, (err, result) => {                                           //if found 
            if (err) {                                                                                                    // if server crashed
                return res.status(509).json({ status: 1, message: 'server error', error: err })
            }
            if (result) {                                                                                                 //true password
                const token = jwt.sign({
                    email: user.email,
                    id: user._id.toString(),
                    fullName: user.fullName,
                    isAdmin: user.isAdmin ,
                    isVerified : user.isVerified
                },
                    process.env.SECRET_KEY
                    // , {
                    //     expiresIn: '10h'
                    // }
                )
                return res.status(200).json({ status: 0, message: `welcome back ${user.fullName}!`, token: token })
            }
            res.status(500).json({status:0, message:'Wrong password. Try again or click Forgot password to reset it.'})                     //wrong password
        })
    }).catch(err => {
        console.log(err);
        res.status(500).json({ status:1, message: err })
    })
};

exports.googleLogin = async (req, res, next) => {
    try {
        const user = await User.findById(req.session.passport.user);
        if (!user) {
            res.status(200).json({status: 0, message: "User doesn't exist" });
            return;
        }
        const decryptedData = {
            _id: user._id,
            fullName: user.fullName,
            email: user.email,
            createdAt: user.createdAt,
            isAdmin:user.isAdmin ,
            isVerified : user.isVerified

        };
        // const expiresIn = "10h";
        // const token = jwt.sign(decryptedData, process.env.SECRET_KEY, { expiresIn });
        const token = jwt.sign(decryptedData, process.env.SECRET_KEY);
        res.status(200).json({ message: 'Logged in successfully', token, User: decryptedData });
    } catch (error) {
        console.log(error)
        res.status(500).json({ message: error.message });
    }
};

exports.forgotPassword = async (req, res) => {
    const errors = validationResult(req);           //validating email field with express-validator
    if (!errors.isEmpty()) {
        return res.status(200).json({ errors: errors.array() });
    }
    const searchOption = req.body.searchOption;
    const user = await User.findOne({ $or: [{ email: searchOption }, {phone: searchOption }] });           // finding user
    if (!user) return res.status(200).json({ status: 0, message: ' can\'t find any user with this email address' })    // if user not found

    const token = await mailHelper.creatResetToken()                 // creating token
    const newUser = await User.findByIdAndUpdate(user._id, { reset_password_token: token, reset_password_expires: Date.now() + 60 * 60 * 1000 * 6 }, { upsert: true, new: true }) //updating user document , token expires after 6 hours
    res.status(200).json({ status: 0,user: newUser, message: 'Reset password email has been sent successfuly to your email address' })
    mailHelper.mailTransport().sendMail({
        from: "sedteam@outlook.com",
        to: user.email,
        subject: "SED Support team , Reset Your Account Password",
        html: mailHelper.generateForgotPasswordTemplate(`http://${req.headers.host}/auth/reset?token=${token}`)
    })
};

exports.resetPassword = async (req, res) => {

    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            const errorMessages = errors.array().map(error => error.msg);
            return res.status(200).json({ message: errorMessages });
        }
        const user = await User.findOne({ _id: req.user._id });
        user.password = bcrypt.hashSync(req.body.password, 10);
        user.reset_password_token = undefined;
        user.reset_password_expires = undefined;
        await user.save()
        console.log(user)
        res.status(200).json(user)
        mailHelper.mailTransport().sendMail({
            from: process.env.MYMAIL,
            to: user.email,
            subject: 'Your new password has been confirmed',
            html: mailHelper.generateResetedPasswordTemplate(user.email)
        });
    } catch (error) {
        console.log(error)
        res.status(404).json(error)
    }
};

exports.sendOtpVerifyEmail = async (req, res, next) => {
    try {
        const userEmail = req.user.email;

        if (!userEmail) {
            return res.status(200).json({ status: 0, message: 'Error auth' });
        }

        const user = await User.findOne({ email: userEmail });
        if (!user) {
            return res.status(200).json({ status: 0, message: 'User not found' });
        }

        const otp = mailHelper.generateOTP()
        const expires = Date.now() + 3600000; // 1 hour

        user.verify_account_otp = otp;
        user.verify_otp_expires = expires;

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
            html: mailHelper.generateVerifyEmailTemplate(otp)
        };
        mailHelper.mailTransport().sendMail(mailOptions);

        res.status(200).json({ status: 0, message: 'Email sent' });
    } catch (err) {
        console.log(err)
        res.status(500).json({ status: 1, message: 'Server Error' });
    }
};

exports.verifyEmailByOtp = async (req, res, next) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            const errorMessages = errors.array().map(error => error.msg);
            return res.status(200).json({status:1, message: errorMessages });
        }

        const otb = req.body.code;

        const user = await User.findOne({
            verify_account_otp: otb,
            verify_otp_expires: { $gt: Date.now() },
        });

        if (!user) {
            return res.status(200).json({ status:0,message: 'Invalid or expired Code' });
        }

        user.isVerified = true;
        user.verify_account_otp = undefined;
        user.verify_otp_expires = undefined;

        await user.save();
        const token = jwt.sign({
            email: user.email,
            id: user._id.toString(),
            fullName: user.fullName,
            isAdmin: user.isAdmin ,
            isVerified : user.isVerified
        },
            process.env.SECRET_KEY
            // , {
            //     expiresIn: '10h'
            // }
        )
        res.status(200).json({ status:0,message: 'Account Verified', token:token});
        const username = user.fullName


        const mailOptions = {
            to: user.email,
            from: process.env.MYMAIL,
            subject: 'Account Verification Successful',
            html: mailHelper.generateOtpVerifiedEmailTemplate(username)
        };
        
        const transporter = nodemailer.createTransport({
            service: "hotmail",
            auth: {
                user: process.env.MYMAIL,
                pass: process.env.MAILPASSWORD
            }
        });

        mailHelper.mailTransport().sendMail(mailOptions);
    } catch (err) {
        return res.status(500).json({ status:1,message: 'Server Error' });
    }
};


exports.resendVerifyEmail=async(req,res)=>{
    try {
        const userEmail = req.user.email;

        if (!userEmail) {
            return res.status(200).json({status: 0, message: 'Error auth' });
        }

        const user = await User.findOne({ email: userEmail });
        if (!user) {
            return res.status(200).json({ status: 0,message: 'User not found' });
        }

        const otp = mailHelper.generateOTP()
        const expires = Date.now() + 3600000; // 1 hour

        // user.verify_account_otp = otp;
        // user.verify_otp_expires = expires;
        await User.findByIdAndUpdate(req.user._id,{$set:{verify_account_otp:otp , verify_otp_expires:expires}} , {new:true})


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
            subject: 'Account Verification Resend request',
            html: mailHelper.generateVerifyEmailTemplate(otp)
        };
        mailHelper.mailTransport().sendMail(mailOptions);

        res.status(200).json({status:0, message: 'Email sent' });
    } catch (err) {
        console.log(err)
        res.status(500).json({status:1, message: 'Server Error' });
    }
}

// forgot password endpoint that takes email to send an otp to it     ' it takes email ' 
exports.forgotPasswordByOTP = async (req, res) => {
    //changes to impelemt if works
    // (1) reset_password_token >>>>>>> reset_password_otp 
    // (2) generateVerifyEmailTemplate >>>>>>> to change content of email
    const errors = validationResult(req);           //validating email field with express-validator
    if (!errors.isEmpty()) {
        return res.status(200).json({ errors: errors.array() });
    }
    const searchOption = req.body.searchOption;
    const user = await User.findOne({ $or: [{ email: searchOption }, {phone: searchOption }] });           // finding user
    if (!user) return res.status(200).json({ status: 0, message: ' can\'t find any user with this email address' })    // if user not found

    const otp = mailHelper.generateOTP()                 // creating otp
    const newUser = await User.findByIdAndUpdate(user._id, { reset_password_token: otp, reset_password_expires: Date.now() + 60 * 60 * 1000 * 6 }, { upsert: true, new: true }) //updating user document , otp expires after 6 hours
    res.status(200).json({ status: 0,user: newUser, message: 'Reset password email has been sent successfuly to your email address' })
    mailHelper.mailTransport().sendMail({
        from: "sedteam@outlook.com",
        to: user.email,
        subject: "SED Support team , Reset Your Account Password",
        html: mailHelper.generateForgotPasswordTemplateByOTP(otp) 
    })
};

// verifying otp  ' it takes code '
exports.VerifyresetPasswordOTP = async (req, res) => {
    try {
        const errors = validationResult(req);
        if (!errors.isEmpty()) {
            const errorMessages = errors.array().map(error => error.msg);
            return res.status(200).json({status:1, message: errorMessages });
        }

        const otb = req.body.code;

        const user = await User.findOne({
            reset_password_token: otb,
            reset_password_expires: { $gt: Date.now() },
        });

        if (!user) {
            return res.status(200).json({ status:0,message: 'Invalid or expired Code' });
        }

        user.reset_password_token = undefined;
        user.reset_password_expires = undefined;

        await user.save();
        res.status(200).json({ status:0,message: 'Go To Reset Page', user:user._id});

    } catch (err) {
        return res.status(500).json({ status:1,message:err });
    }
};


// this endpoint is last step on reset after veryifing otp to write the new password  ' it takes password , confirmPassword ' 
exports.verifiedPwChange=async(req,res)=>{
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
        const errorMessages = errors.array().map(error=>error.msg);
        return res.status(400).json({ status: 0, message: errorMessages });
    }
    try {
    const user=await User.findById(req.body.user)
    const hashedPassword=await bcrypt.hash(req.body.password,10)
    const token = jwt.sign({
        email: user.email,
        id: user._id.toString(),
        fullName: user.fullName,
        isAdmin: user.isAdmin ,
        isVerified : user.isVerified
    },
        process.env.SECRET_KEY , {expiresIn: '10h'}
    )
    user.password=hashedPassword
    await user.save()

    mailHelper.mailTransport().sendMail({
        from: process.env.MYMAIL,
        to: user.email,
        subject: 'Your new password has been Changed Successfully',
        html: mailHelper.generateResetedPasswordTemplate(user.email)
    });

    res.status(200).json({
        status: 0,
        message: "Password has been updated successfully",
        token
    });
    } catch (err) {
        res.status(400).json({message:err.message , err})
    }
}