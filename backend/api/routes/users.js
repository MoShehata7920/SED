const router=require('express').Router()
const mongoose=require('mongoose')
const User=require('../models/user')
const bcrypt=require('bcrypt')

router.post('/register',(req,res)=>{
    User.find({email:req.body.email}).exec().then((user)=>{
        if(user.length>=1){
            return res.status(406).json('This is an email that already exists')
        }else{
            if(req.body.password===req.body.pwConfirmation){
                bcrypt.hash(req.body.password,10,(err,hashedPassword)=>{
                    if(err){
                        res.status(500).json(err)
                    }else{
                        const newUser=new User({
                            _id:new mongoose.Types.ObjectId,
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

router.post('/login',(req,res)=>{
    User.find({email:req.body.email}).exec().then((user)=>{
        if(user.length>=1){                                                                                     // email found
            bcrypt.compare(req.body.password,user[0].password,(err,result)=>{
                if(err){                                                                                        // server error
                    res.status(500).json(err)
                }else if(result) {                                                                              // true password
                    res.status(200).json(`welcome back ${user[0].fullName}!`)
                }
                else{                                                                                           // wrong password
                    res.status(401).json('Wrong password. Try again or click Forgot password to reset it.')
                }
            })
        }else{                                                                                                  //email not found 
            return res.status(406).json('There is no account registered with this email')
        }
    })
})


module.exports=router;