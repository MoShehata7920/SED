const Message = require('../models/messages');
const Conversation=require('../models/conversation')
module.exports = function (io) {
    io.on('connection', (socket) => {
        console.log('user connected');
        // Join conversation room
        socket.on('joinConversation', async (conversationId) => {
            socket.join(conversationId);

            // Load previous messages
            try {
                const messages = await Message.find({ conversation: conversationId }).populate('sender', 'fullName');
                socket.emit('previousMessages', messages);
            } catch (err) {
                console.error(err);
            }
        });

        // Send message
        socket.on('sendMessage', async (data) => {
            const { conversationId, senderId, text } = data;
            const message = new Message({ conversation: conversationId, sender: senderId, text });
            try {
                // Save message to database
                const savedMessage = await message.save();
                await Conversation.findByIdAndUpdate(conversationId,{$set:{lastMessage:savedMessage.text}},{new:true})
                const messageWithSender = await Message.findById(savedMessage._id).populate('sender', 'fullName');
                io.to(conversationId).emit('messageReceived', messageWithSender);
                console.log(`message with sender is ${messageWithSender}`);
            } catch (err) {
                console.error(err);
                console.log(err);

            }
        });

        socket.on('disconnect', () => {
            console.log('user disconnected');
        });
    });
};
