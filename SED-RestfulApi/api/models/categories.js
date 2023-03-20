const mongoose = require('mongoose');

const categoriesSchema = mongoose.Schema({
    _id:{
        type:Number,
        required:true
    },
    Name:{
        type:String,
        required:true
    },
    Image:{
        type:String,
        required:true
    }
});


module.exports = mongoose.model('categories', categoriesSchema);