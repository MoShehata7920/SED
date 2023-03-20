const express = require('express');
const router = express.Router();
const Conversation = require('../models/conversation');
const Message = require('../models/messages');
const User=require('../models/User');

router.get('/:conversationId/:user/:receive', async (req, res) => {
  const  conversationId  = req.params.conversationId;
  const currentUserId = req.params.user;
  const reciverId=req.params.receive;

  const currentUser=await User.findById(currentUserId);

  try {
    const conversation = await Conversation.findById(conversationId).populate('users', '_id name');
    if (!conversation) {new Conversation({
        users:[currentUserId,reciverId]
    }).save()};
    const messages = await Message.find({ conversation: conversationId }).populate('sender','userName');
    res.render('chatPage', { conversation, currentUser, messages });
  } catch (err) {
    console.error(err);
    res.status(500).json({message:err});
  }
});

module.exports = router;