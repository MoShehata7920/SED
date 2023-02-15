const router=require('express').Router()
const Product=require('../models/product')
const mongoose=require('mongoose')
const multer=require('multer')
const storage=multer.diskStorage({
    destination:(req,file,cb)=>{
        cb(null,'./uploads/')
    },
    filename:(req,file,cb)=>{
        cb(null,file.originalname)
    }
})
const upload=multer({storage:storage})


//router for creating new product
router.post('/newproduct',upload.single('productImage'),(req,res)=>{
    new Product({
        productName : req.body.productName,
        description : req.body.description,
        quantity : req.body.quantity,
        productImage : req.file.path,
        price : req.body.price,

    }).save().then((newproduct)=>{
        res.status(200).json(newproduct)
    }).catch(err=>{
        console.log(err);
    })
})





module.exports=router;