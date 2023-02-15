const mongoose=require('mongoose')


const productSchema = mongoose.Schema({
    productName:{
        type:String,
        required:true
    },

    description:{
        type:String
    },

    quantity:{
        type:Number,
        default:1
    },

    prdouctImage:{
        type:String
    },

    price:{
        type:Number,
        required:true
    }
}, {timestamps:true})


module.exports=mongoose.model('Product',productSchema)