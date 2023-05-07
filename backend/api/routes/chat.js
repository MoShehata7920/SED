const express = require('express');
const router = express.Router();
const Conversation = require('../models/conversation');
const Message = require('../models/messages');
const User = require('../models/user');


//creating new message
router.post("/", async (req, res) => {
  const newMessage = new Message(req.body);
  try {
    const savedMessage = await newMessage.save();
    res.status(200).json({status:0 , savedMessage });
  } catch (err) {
    res.status(500).json({status:1 , message:err.message ,err});
  }
});

//getting conversation messages by conversation Id
router.get("/:conversationId", async (req, res) => {
  try {
    const messages = await Message.find({
      conversation: req.params.conversationId,      //  conversation >> 'conversation id'
    });
    if(messages.length===0){
      res.status(200).json({status:0 , message : "No messages yet",conversations})
    }
    res.status(200).json({status:0 , messages});
  } catch (err) {
    res.status(500).json({status:1 , message:err.message , err});
  }
});




//getting user conversations by his Id
router.get("/:userId", async (req, res) => {
  try {
    const conversations = await Conversation.find({
      // users: { $in: [req.params.userId] },
      users: { $in: [mongoose.Types.ObjectId(req.params.userId)] }, // for better security 'preventing injection attacks' 
    });
    if(conversations.length===0){
      res.status(200).json({status:0 , message : "There are no conversations , start One !",conversations})
    }
    res.status(200).json({ status:0 , conversations });
  } catch (err) {
    res.status(500).json({status:1 , message:err.message , err});
  }
});


router.get('/:conversationId/:user/:receive', async (req, res) => {
  const conversationId = req.params.conversationId;
  const currentUserId = req.params.user;
  const reciverId = req.params.receive;

  try {
    const currentUser = await User.findById(currentUserId);
    const conversation = await Conversation.findById(conversationId).populate('users', '_id name')
    if (!conversation) {
      await new Conversation({
        users: [currentUserId, reciverId]
      }).save()
    };
    const messages = await Message.find({ conversation: conversationId }).populate('sender', 'fullName');
    res.render('chatPage', { conversation, currentUser, messages });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: err });
  }
});

router.get('/:conversationId/:user/:receive', async (req, res) => {
  const conversationId = req.params.conversationId;
  const currentUserId = req.params.user;
  const reciverId = req.params.receive;

  try {
    const currentUser = await User.findById(currentUserId);

    // if messages are on conversation so why we don't get it directly
    const conversation = await Conversation.findById(conversationId).populate({path: 'users',select: '_id name'})
  .populate({
    path: 'messages',
    populate: {
      path: 'sender',
      model: 'User',
      select: 'fullName'
    },
    select:'text'
  });

    if (!conversation) {
      await new Conversation({
        users: [currentUserId, reciverId]
      }).save()
    };
    const messages=conversation.messages
    // const messages = await Message.find({ conversation: conversationId }).populate('sender', 'fullName');
    res.render('chatPage', { conversation, currentUser, messages });
  } catch (err) {
    console.error(err);
    res.status(500).json({ message: err });
  }
});

module.exports = router;