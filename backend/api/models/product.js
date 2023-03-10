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
        enum:['Electronics','Fashion','Phones&Tablets','Books','Furniture','Supermarket','Body&HealthCare','Others','Sports','Vehicles']
    },
    purpose:{
        type:String,
        required:true,
        enum:['sell','exchange','donate']
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

    seller: {
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },

    createdAt:{
        type:Date,
        default:Date.now()
    }
})


module.exports=mongoose.model('Product',productSchema)