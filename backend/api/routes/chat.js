const express = require('express');
const router = express.Router();
const Conversation = require('../models/conversation');
const Message = require('../models/messages');
const User = require('../models/user');
const mongoose=require('mongoose')


//creating new message
router.post("/new-message", async (req, res) => {
  const newMessage = new Message(req.body);
  try {
    const savedMessage = await newMessage.save();
    // updating last message on conversation
    await Conversation.findByIdAndUpdate(req.body.conversation,{$set:{lastMessage:savedMessage.text}},{new:true}) // to add message to conversation document
    res.status(200).json({status:0 , savedMessage });
  } catch (err) {
    res.status(500).json({status:1 , message:err.message ,err});
  }
});

//getting conversation messages by conversation Id
router.get("/messages/:conversationId", async (req, res) => {
  try {
    const messages = await Message.find({
      conversation: req.params.conversationId,      //  conversation >> 'conversation id'
    });
    if(messages.length===0){
      return res.status(200).json({status:0 , message : "No messages yet", messages })
    }
    res.status(200).json({status:0 , messages});
  } catch (err) {
    res.status(500).json({status:1 , message:err.message , err});
  }
});




//getting user conversations by his Id

router.get("/user-convs/:userId", async (req, res) => {
  try {
    const conversations = await Conversation.find({
      // users: { $in: [req.params.userId] },
      users: { $in: [mongoose.Types.ObjectId(req.params.userId)] }, // for better security 'preventing injection attacks' 
    }).populate('users','fullName email userImage ')
    // .populate({
    //   path:'messages',
    //   select:'text createdAt',
    //   options:{
    //     sort:{createdAt:-1},                       // selecting the first item of messages array is the last message on the conversation,
    //     perDocumentLimit:1              // only the last message to show from outside view    
    //   },
    if(conversations.length===0){
      res.status(200).json({status:0 , message : "There are no conversations , start One !", conversations })
    }
    res.status(200).json({ status:0 , conversations });
  } catch (err) {
    res.status(500).json({status:1 , message:err.message , err});
  }
});



//creating new conversation
router.post("/new-conversation", async (req, res) => {
  const newConversation = new Conversation({
    users: [req.body.senderId, req.body.receiverId],
  });
  try {
    const savedConversation = await newConversation.save();
    res.status(200).json({status:0,savedConversation});
  } catch (err) {
    res.status(500).json({status:1 , message:err.message , err});
  }
});

// getting conversation with its messages between two users by conv id and user id and reciever id
router.get('/get/:conversationId/:user/:receive', async (req, res) => {
  const conversationId = req.params.conversationId;
  const currentUserId = req.params.user;
  const reciverId = req.params.receive;

  try {
    const currentUser = await User.findById(currentUserId).select('_id email fullName userImage')
    const conversation = await Conversation.findById(conversationId).populate('users', '_id name').select('-messages -__V')
    // if (!conversation) {
    //   await new Conversation({
    //     users: [currentUserId, reciverId]
    //   }).save()
    // };
    const messages = await Message.find({ conversation: conversationId }).populate('sender', 'fullName');
    // res.render('chatPage', { conversation, currentUser, messages });
    res.status(200).json({status:0 ,currentUser, conversation ,  messages })
  } catch (err) {
    console.error(err);
    res.status(500).json({status:1 , message:err.message , err });
  }
});


module.exports = router;