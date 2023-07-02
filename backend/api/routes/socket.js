const Message = require('../models/messages');
const Conversation=require('../models/conversation')

const users = {};

module.exports = function (io) {
    io.on('connection', (socket) => {

        socket.on('saveUserData', (userData) => {
            const { id } = userData;
            users[id] = socket;
            console.log(`User with ID ${id} saved`);
          });

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

                const conversation = await Conversation.findById(conversationId);
                let receiverId = conversation.users[0];
                if (conversation.users[0].toString() === senderId) {
                    receiverId = conversation.users[1];
                }

                await Conversation.findByIdAndUpdate(conversationId,{$set:{lastMessage:savedMessage.text}},{new:true})
                const messageWithSender = await Message.findById(savedMessage._id).populate('sender', 'fullName userImage');
                emitMessageToUsers([senderId, receiverId], 'messageReceived', messageWithSender);
            } catch (err) {
                console.error(err);
                console.log(err);

            }
        });

        socket.on('disconnect', () => {
            const disconnectedUserId = Object.keys(users).find(id => users[id] === socket);
            delete users[disconnectedUserId];
            console.log(`User with ID ${disconnectedUserId} disconnected and was removed`);
        });
    });
    
};

function emitMessageToUsers(userIds, eventName, eventData) {
    userIds.forEach((userId) => {
      const socket = users[userId];
      if (socket) {
        socket.emit(eventName, eventData);
      }
    });
  }
  
