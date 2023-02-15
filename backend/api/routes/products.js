const router=require('express').Router()
const Product=require('../models/product')
const mongoose=require('mongoose')


router.post('/newproduct',(req,res)=>{
    new Product({
        productName : req.body.productName,
        description : req.body.description,
        quantity : req.body.quantity,
        prdouctImage : req.file.path,
        price : req.body.price,

    }).save().then((newproduct)=>{
        res.status(200).json(newproduct)
    }).catch(err=>{
        console.log(err);
    })
})





module.exports=router;