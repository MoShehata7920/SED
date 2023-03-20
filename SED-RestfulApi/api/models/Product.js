const mongoose = require('mongoose');

const ProductSchema = new mongoose.Schema({
  name: {
    type: String,
    required: true,
  },
  description: {
    type: String,
  },
  price: {
    type: String,
    required: true,
  },
  category: {
    type: String,
    enum: ["Electronics","Fashion","Phones&Tablets","Books","Furniture","Supermarket","Body&HealthCare","Others","Sports","Vehicles"],
    required: true,
  },
  productFor: {
    type: String,
    enum: ['sale', 'exchange', 'donation'],
    required: true,
  },
  image: {
    type: String,
    required: true,
  },
  seller: {
    type: mongoose.Schema.Types.ObjectId,
    ref: 'User',
    required: true,
  },
  createdAt: {
    type: Date,
    default: Date.now,
  },
  updatedAt: {
    type: Date,
    default: Date.now,
  }
});

ProductSchema.index({ productFor: 1 });

ProductSchema.index({category:1});


module.exports =  mongoose.model('Product', ProductSchema);
