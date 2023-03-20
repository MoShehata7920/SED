const mongoose = require('mongoose');

const conversationSchema = mongoose.Schema({
  users: [{ type: mongoose.Schema.Types.ObjectId, ref: 'User', required: true }],
  messages: [{ type: mongoose.Schema.Types.ObjectId, ref: 'Message' }],
  createdAt: { type: Date, default: Date.now() },
});

module.exports = mongoose.model('conversation', conversationSchema);