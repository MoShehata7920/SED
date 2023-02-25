const router=require('express').Router()
const mongoose=require('mongoose')
const User=require('../models/user')
const bcrypt=require('bcrypt')
const jwt=require('jsonwebtoken')
const { body, validationResult } = require('express-validator')
const { verifyTokenAndAdmin, verifyToken } = require('../middleware/check-auth')
const { generateOTP , mailTransport , creatResetToken , generateForgotPasswordTemplate}=require('../helpers/mail')
const EmailVerification=require('../models/emailVerification')
const {resetVerification} = require('../middleware/check-reset')

// new user sign up 
router.post('/register',
[
    body('password').isLength({min:5}).withMessage('Please enter a valid password with at least 5 chars')
]   ,
(req,res)=>{
    const errors = validationResult(req);
    if (!errors.isEmpty()) {
      return res.status(400).json({ errors: errors.array() });
    }
    User.find({email:req.body.email}).exec().then((user)=>{
        if(user.length>=1){
            // return res.status(406).json('This is an email that already exists')
            return res.status(406).json({message:'This is an email that already exists'})

        }else{
            if(req.body.password===req.body.pwConfirmation){
                bcrypt.hash(req.body.password,10,(err,hashedPassword)=>{
                    if(err){
                        res.status(500).json(err)
                    }else{
                        const newUser=new User({
                            email:req.body.email,
                            fullName:req.body.fullName,
                            password:hashedPassword
                        })

                        //email Verification part 
                        const OTP=generateOTP()
                        const newEmailVerification=new EmailVerification({
                            owner:newUser._id,
                            token:OTP
                        })
                        newEmailVerification.save()
                        //email Verification end 

                        newUser
                        .save()
                        .then((user)=>{res.status(200).json(user)})
                        .catch(err=>{res.status(404).json(err)})

                        mailTransport().sendMail({
                            from : "sedfamily@gmail.com",
                            to : newUser.email,
                            subject : "Verify your email address",
                            html : `<h1>${OTP}</h1>`
                        })


                    }
                })
            }else{
                res.status(406).json('Please make sure your passwords match')
            }
        }
    })
})

// user login
router.post('/login',(req,res)=>{
    User.find({email:req.body.email}).exec().then(user=>{
        if(user.length<=0){                                                                                             //if email not found 
            return res.status(401).json({message:'This Emaiil Not exist , Please Register First'})
        }
        bcrypt.compare(req.body.password , user[0].password , (err,result)=>{                                           //if found 
            if(err){                                                                                                    // if server crashed
                console.log(err)
                return res.status(509).json({message:'server error',error : err})
            }
            if(result){                                                                                                 //true password
                const token=jwt.sign({
                    email:user[0].email,
                    id:user[0]._id.toString(),
                    fullName:user[0].fullName,
                    isAdmin:user[0].isAdmin                   
                },
                process.env.SECRET_KEY
                ,{
                    expiresIn:'10h'
                }
                )
                // console.log(user[0]._id.toString());  we did that to remove the objectId thing from id 
                // console.log(user[0].id)   // outs a undefined
                return res.status(200).json({message:`welcome back ${user[0].fullName}!`,token:token})
            }
            console.log(err)
            res.status(509).json('Wrong password. Try again or click Forgot password to reset it.')                     //wrong password
        })
    }).catch(err=>{
        console.log(err);
        res.status(409).json({error:err})
    })
})


// getting all users , must be an admin
router.get('/getallusers',verifyTokenAndAdmin,(req,res)=>{
    User.find()
    .select('-password')            // to hide user password
    .exec()
    .then(docs=>{
        res.status(200).json(docs)
    }).catch(err=>{
        res.status(500).json(err)
    })
})

// To find a Single User , must be and admin or the userhim self
router.get('/:userId',verifyToken,(req,res)=>{
    if(req.user.id===req.params.userId || req.user.isAdmin){   // to check wether the user him self who requested for his info , or an admin
        User.findById(req.params.userId).exec().then(user=>{
            if(user){
                res.status(200).json(user)
            }else{
                res.status(404).json('This User Not exist')
            }
        }).catch(err=>{
            res.status(500).json(err)
        })
    }else{
        console.log('error from single user get else condition ');
    }
})

//updating user info
router.patch("/update/:userId", verifyToken ,(req, res) => {
    if(req.user.id===req.params.userId || req.user.isAdmin){
        User.findByIdAndUpdate(req.params.userId, { $set: req.body }, { new: true })
        .then((newdoc) => {
          res.status(200).json(newdoc);
        })
        .catch((err) => {
          res.status(500).json(err);
        });
    }else{
        console.log('Error from updating user else condition');
    }
});




//deleting user by it's Id
router.delete('/delete/:userId',verifyTokenAndAdmin,(req,res)=>{
    User.findById(req.params.userId).exec().then(doc=>{
        if(doc){
            User.deleteOne({_id:req.params.userId}).exec().then(()=>{
                res.status(200).json('user has been deleted successfully')
            }) 
        } else{
            res.status(404).json('There is no user with this id')
        }   
    }).catch(err=>{
        res.status(500).json(err)
    })
})


router.post('/verify-email',async(req,res,next)=>{
    const { userId , otp } = req.body               //can get them from params method if needed
    if( !userId || !otp.trim() ) return res.status(406).json('Invalid req,missiong parameters')     // if missing parameters 

    if(!mongoose.isValidObjectId(userId)) res.status(406).json('Invalid user id ! ')                // if req came with wrong id type

    const user=await User.findById(userId)                                                           
    if( !user ) return res.status(406).json('Sorry , user not found !')                             // if user not found in database
    if( user.verified ) return res.status(406).json('This account already verified')                // if user already verified = true

    const token = await EmailVerification.findOne({ owner : user._id})                              // getting token token document to do compare token later too in isMatched condition
    if( !token )  return  res.status(406).json('Error , there is no token document ')               // if there is no token document in email verification collection  
    
    const isMatched=await token.compareToken(otp)                                                   // checking token matching or not from from emailverification schema methods   
    if( !isMatched ) return res.status(406).json('Please provide a valid token')

    user.verified = true                                                                            // if we got here so all is good and this user will be changed to verified on database

    await EmailVerification.findByIdAndDelete(token._id)                                            // deleting token doc from emailVerification schema
    await user.save()                                                                               // updating on database

    mailTransport().sendMail({
        from : "sedfamily@gmail.com",
        to :    user.email,
        subject : "Thank You For Verification",
        html : `<h1>email has been verified successfully</h1>`
    })

    res.status(200).json({success : true , message : "your email has been verified successfully ",user:user})
})


//forgot password 
router.post('/forgot-password',[body('email').notEmpty().withMessage(' invalid parameter \'email\' ').isEmail().withMessage('Please Enter A valid email address')],async (req,res)=>{
    const errors = validationResult(req);           //validating email field with express-validator
    if (!errors.isEmpty()) {
      return res.status(444).json({ errors: errors.array() });
    }

    const user=await User.findOne({email:req.body.email})             // finding user
    if(!user) return res.status(404).json({message:' can\'t find any user with this email address'})    // if user not found
    
    const token=await creatResetToken()                 // creating token
    await User.findByIdAndUpdate( user._id ,{ reset_password_token : token , reset_password_expires: Date.now() + 60*60*1000*6 },{ upsert : true , new : true }) //updating user document , token expires after 6 hours
    
    mailTransport().sendMail({
        from : "sedfamily@gmail.com",
        to :    user.email,
        subject : "SED Support team , Reset Your Account Password",
        html :  generateForgotPasswordTemplate(`http://localhost:3000/api/users/reset-password?token=${token}&id=${user._id} `)
    })

    res.status(200).json({message:'Reset password email has been sent successfuly to your email address'})
})


router.post('/reset-password', resetVerification , async (req,res) =>{
    const user=req.user
    try {
        if(req.body.newPassword === req.body.verifyPassword) {
            user.password = bcrypt.hashSync(req.body.newPassword, 10);
            user.reset_password_token = undefined;
            user.reset_password_expires = undefined;
            await user.save()
            res.status(200).json(user)
        }else{
            res.status(500).json('passwords doesn\'t match ')
        }
    } catch (error) {
        res.status(404).json(error)
    }

} )


module.exports=router;