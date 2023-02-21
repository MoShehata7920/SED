const router=require('express').Router()
const mongoose=require('mongoose')
const User=require('../models/user')
const bcrypt=require('bcrypt')
const jwt=require('jsonwebtoken')
const { body, validationResult } = require('express-validator')
const { verifyTokenAndAdmin, verifyToken } = require('../middleware/check-auth')


// new user sign up 
router.post('/register',[
    body('password').isLength({min:5}).withMessage('Please enter a valid password with at least 5 chars')
],(req,res)=>{
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
                        newUser
                        .save()
                        .then((user)=>{res.status(200).json(user)})
                        .catch(err=>{res.status(404).json(err)})
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





//forgot password route to be set
// router.patch('/resetPassword/:id',(req,res)=>{
//     const userId=req.params.id
//     User.findByIdAndUpdate(userId,{$set : req.body},{new:true}).then((doc)=>{
//         res.status(200).json(doc)
//     }).catch(err=>{
//         console.log('Wrong id');
//         res.status(500).json({error : {message : 'wrong id '} , err})
//     })  
// })

module.exports=router;