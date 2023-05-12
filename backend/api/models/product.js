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
    productImage: {
        type : String,
        required : true
    },

    condition:{
        type:String,
        enum:['Used','New']
    },

    price: {
        type : Number,
        required : true
    },

    seller: {                                                           //seller id 
        type: mongoose.Schema.Types.ObjectId,
        ref: 'User',
        required: true,
    },

    createdAt:{
        type:Date,
        default:Date.now()
    }
    ,
    updatedAt: {
        type: Date,
        default: Date.now()
    }
})

// productSchema.index({ purpose: 1 });
// productSchema.index({ productName: 'text' });
// productSchema.index({category:1});
productSchema.index({ productName: "text", description: "text", purpose: "text", category: "text" }, { default_language: "english" });


module.exports=mongoose.model('Product',productSchema)