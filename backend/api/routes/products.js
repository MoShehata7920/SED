const router=require('express').Router()
const Product=require('../models/product')
const mongoose=require('mongoose')
const multer=require('multer')
const { verifyTokenAndAdmin } = require('../middleware/check-auth')
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


//getting all products
router.get('/getallproducts',(req,res)=>{
    Product.find().exec().then((docs)=>{
        res.status(200).json(docs)
    }).catch(err=>{
        res.status(500).json(err)
    })
})

//finding single product by it's id
router.get('/product/:prodId',(req,res)=>{
    Product.findById(req.params.prodId).exec().then(doc=>{
        res.status(200).json(doc)
    }).catch(err=>{
        res.status(500).json(err)
    })
})

//updating product
router.patch('/product/:prodId',upload.single('productImage'),(req,res)=>{
    
    if(req.file){       // if condition to check if there an update for the image      
        Product.findByIdAndUpdate(req.params.prodId,{$set:req.body , productImage : req.file.path},{new:true}).exec().then(doc=>{
            res.status(200).json(doc)
        }).catch(err=>{
            res.status(500).json(err)
        })
    }else{
        Product.findByIdAndUpdate( req.params.prodId , { $set : req.body} , { new : true }).exec().then(doc=>{
            res.status(200).json(doc)
        }).catch(err=>{
            res.status(500).json(err)
        })
    }
    
})

//deleting a product by it's Id
router.delete('/product/:prodId',verifyTokenAndAdmin,(req,res)=>{
    Product.findById(req.params.prodId).exec().then(doc=>{
        if(doc){
            Product.deleteOne({ _id : req.params.prodId}).exec().then(()=>{
                res.status(200).json('Product has been deleted successfully')
            }) 
        } else{
            res.status(404).json('There is no product with this id')
        }   
    }).catch(err=>{
        res.status(500).json(err)
    })
})

module.exports=router;