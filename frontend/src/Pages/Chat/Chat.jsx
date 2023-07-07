// // 
// import React, { useState, useEffect, useRef } from 'react';
// import io from 'socket.io-client';

// const Chat = ({ conversationId, senderId }) => {
//   const [messages, setMessages] = useState([]);
//   const [text, setText] = useState('');
//   const socketRef = useRef();

//   useEffect(() => {
//     socketRef.current = io();
//     socketRef.current.emit('saveUserData', { id: senderId });
//     socketRef.current.on('previousMessages', (messages) => {
//       setMessages(messages);
//     });
//     socketRef.current.on('messageReceived', (message) => {
//       setMessages((messages) => [...messages, message]);
//     });
//     socketRef.current.emit('joinConversation', conversationId);

//     return () => {
//       socketRef.current.disconnect();
//     };
//   }, [conversationId, senderId]);

//   const sendMessage = () => {
//     if (text.trim() === '') {
//       return;
//     }
//     socketRef.current.emit('sendMessage', { conversationId, senderId, text });
//     setText('');
//   };

//   return (
//     <>
//       <div>
//         {messages.map((message) => (
//           <div key={message._id}>
//             <p>{message.sender.fullName}</p>
//             <p>{message.text}</p>
//           </div>
//         ))}
//       </div>
//       <div>
//         <input type="text" value={text} onChange={(e) => setText(e.target.value)} />
//         <button onClick={sendMessage}>Send</button>
//       </div>
//     </>
//   );
// };

// export default Chat;

////////////////////////////////////////////////////////////////////////////////////////////////

import React, { useState, useEffect, useRef } from 'react';
import io from 'socket.io-client';

const Chat = () => {
  const [socket, setSocket] = useState(null);
  const [conversationId, setConversationId] = useState(null);
  const [messages, setMessages] = useState([]);
  const [text, setText] = useState('')
//   const [senderId, setSenderId] = useState(null);
  const senderId="649845a077bf4e6af700cac5"
  const messagesEndRef = useRef(null);

  useEffect(() => {
    console.log('Connecting to socket server...');
    const newSocket = io.connect('http://localhost:3000',{transports: ['websocket']}); // Replace with your server URL
    setSocket(newSocket);
    return () => newSocket.close();
  }, []);

  useEffect(() => {
    if (socket) {
        console.log('socket true');
        socket.on('previousMessages', (messages) => {
            setMessages(messages);
            console.log(' messages should be here');
      });

      socket.on('messageReceived', (message) => {
        console.log(' received  should be here');

        setMessages(prevMessages => [...prevMessages, message]);
      });
    }
  }, [socket]);

  useEffect(() => {
    scrollToBottom();
  }, [messages]);

const scrollToBottom = () => {
    if (messagesEndRef.current) {
      const container = messagesEndRef.current.parentElement;
      container.scrollTop = container.scrollHeight - container.clientHeight;
    }
  };

  const handleJoinConversation = async (conversationId) => {
    setConversationId("64984e216bf1cc9ec20ded1d");
    socket.emit('joinConversation', conversationId);
  };

  const handleSendMessage = () => {
     console.log(text)
     console.log(conversationId)
     console.log(senderId)

    if (text.trim().length > 0) {
      socket.emit('sendMessage', { conversationId , senderId , text });
      setText('');
    }
  };

  return (
    <div>
      {conversationId ? (
        <div>
          <ul>
            {messages.map((message) => (
              <li key={message._id}>
                <strong>{message.sender.fullName}</strong>: {message.text}
              </li>
            ))}
            <div ref={messagesEndRef} />
          </ul>
          <input type="text" value={text} onChange={(e) => setText(e.target.value)} />
          <button onClick={handleSendMessage}>Send</button>
        </div>
      ) : (
        <div>
          <p>Select a conversation to join</p>
          <ul>
            <li onClick={() => handleJoinConversation('64984e216bf1cc9ec20ded1d')}>Conversation 1</li>
            <li onClick={() => handleJoinConversation('conversation2')}>Conversation 2</li>
          </ul>
        </div>
      )}
    </div>
  );
};

export default Chat;

//-----------------------------------------------------------------------------

// import io from 'socket.io-client';

// const socket = io.connect('http://localhost:3000', {
//   transports: ['websocket']
// }); // Replace with your server URL

// socket.on('connect', () => {
//   console.log('Socket connected to server');
// });

// socket.on('message', (data) => {
//   console.log('Received message:', data);
// });

// socket.on('connect_error', (error) => {
//   console.error('Socket connection error:', error);
// });

// function Chat(){


//     return(
//         <>
//         </>
//     )
// }
// export default Chat;

