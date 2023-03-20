const mongoose = require('mongoose');

const appImagesSchema = mongoose.Schema({
    imageFor: {
        type: String,
        enum: ["carousel", "sections"],
        required: true
    },
    Image: {
        type: String,
        required: true
    },
    SectionId:{
        type:Number,
        default: 0
    },
    addedAt: {
        type: Date,
        default: Date.now
    }
});


module.exports = mongoose.model('appImages', appImagesSchema);