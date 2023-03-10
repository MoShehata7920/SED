const mongoose=require('mongoose')

const categorySchema=mongoose.Schema({
    _id : {
        type:Number,
        required:true
    } ,

    name:{
        type:String,
        required:true
    } , 

    image:{
        type:String,
        required:true
    }
})

module.exports=mongoose.model('Category',categorySchema)