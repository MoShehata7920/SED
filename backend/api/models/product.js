const mongoose=require('mongoose')


const productSchema = mongoose.Schema({
    productName: {
        type:String,
        required:true
    },

    description: {
        type:String
    },

    category: {
        type:String,
        // required:true,
        enum:['Electronics','Fashion','Furniture','Books','Games','Health Care','example1','ex2']
    },

    quantity: {
        type : Number,
        default : 1
    },

    productImage: {
        type : String,
        required : true
    },

    price: {
        type : Number,
        required : true
    },
    createdAt:{
        type:Date,
        default:Date.now()
    }
})


module.exports=mongoose.model('Product',productSchema)