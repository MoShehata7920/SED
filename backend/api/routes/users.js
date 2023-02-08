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


module.exports=router;