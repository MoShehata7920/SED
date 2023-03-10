const mongoose=require('mongoose')

const imageSchema=mongoose.Schema({
    imageLocation:{
        type:String,
        required:true,
        enum:['carousel','sections']
    },

    image:{
        type:String,
        required:true,
    },

    sectionId:{
        type:Number,
        default:0
    },
    createdAt:{
        type : Date ,
        default: Date.now()
    }
})


module.exports=mongoose.model('appImages',imageSchema)