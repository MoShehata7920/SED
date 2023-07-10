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
import"./Chat.css";
import axios from 'axios';

const Chat = () => {
  const [socket, setSocket] = useState(null);
  const [conversationId, setConversationId] = useState(null);
  const [messages, setMessages] = useState([]);
  const [text, setText] = useState('')
//   const [senderId, setSenderId] = useState(null);
  const senderId="649845a077bf4e6af700cac5"
  const messagesEndRef = useRef(null);
  const [userConversations,setUserConversations]=useState([])

  const instance = axios.create({
    baseURL: 'http://localhost:3000',
  });

  useEffect(()=>{
    instance.get( `/chat/user-convs/649848f390185dd225beb290`).then(res=>{
      // console.log(res);
      (res.data.conversations ? setUserConversations(res.data.conversations) : setUserConversations([]) )
      // setUserConversations(res.data.conversations)
      // console.log(res.data);
      console.log(res.data.conversations)
    }).catch(err=>{
      console.log(err);
    })
  },[])

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
    <section className="chat">
  <div class="container py-5 chat-container">
    <div class="row">
      <div class="col-md-12">
        <div class="card" id="chat3" style={{ borderradius:"15px" }}>
          <div class="card-body">
            <div class="row">
              <div class="col-md-6 col-lg-5 col-xl-4 mb-4 mb-md-0">
               <div className="chat-head">
                <h3>Chats</h3>
                </div> 
                <div class="p-3">

                {userConversations.map(conversation => (
                  <div data-mdb-perfect-scrollbar="true" style={ {position:"relative" , height: "400px"}}>
                  <ul class="list-unstyled mb-0">
                    <li class="p-2 border-bottom" key={conversation.id}>
                      <a href="#!" class="d-flex justify-content-between">
                        <div class="d-flex flex-row">
                          <div>
                            <img
                              src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                              alt="avatar" class="d-flex align-self-center me-3" width="60"></img>
                            <span class="badge bg-success badge-dot"></span>
                          </div>
                          <div class="pt-1">
                            <p class="fw-bold mb-0">Marie Horwitz</p>
                            <p class="small text-muted">{conversation.lastMessage}</p>
                          </div>
                        </div>
                        <div class="pt-1">
                          <p class="small text-muted mb-1">Just now</p>
                          <span class="badge bg-danger rounded-pill float-end">3</span>
                        </div>
                      </a>
                    </li>
                    
                  </ul>
                </div>
                ))}
                   
                  

                </div>

              </div>


              <div class="col-md-6 col-lg-7 col-xl-8">
                    <div class="pt-3 pe-3" data-mdb-perfect-scrollbar="true"
                    style={{position: "relative", height:" 400px"}}>
                          { conversationId ?(
                          <div>
                                <ul>
                                      {messages.map((message) => (
                                        <div>
                                          <li key={message._id}>
                                          <div class="d-flex flex-row justify-content-start">
                                                  <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava6-bg.webp"
                                                  alt="avatar 1" style={{width: "45px", height: "100%"}}></img>
                                                  <div>
                                                  <h5>{message.sender.fullName}</h5>
                                                  <p class="small p-2 me-1 mb-1 text-white rounded-3 bg-primary mx-3 mw-75">{message.text} </p>
                                                  <p class="small ms-3 mb-3 rounded-3 text-muted float-end">12:00 PM | Aug 13</p>
                                                  </div>
                                              </div >
                                          </li>
                                          <li key={message._id}>
                                          <div class="d-flex flex-row justify-content-end">
                                                  <div>
                                                  
                                                  <h5>{message.sender.fullName}</h5>
                                                  <p class="small p-2 me-3 mb-1 text-white rounded-3 bg-danger mw-75"> hello</p>
                                                  <p class="small me-3 mb-3 rounded-3 text-muted">12:00 PM | Aug 13</p>
                                                  </div>
                                                  <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                                                  alt="avatar 1" style={{width: "45px", height:" 100%"}}></img>
                                              </div >

                                          </li>
                                        </div>
                                        
                                      ))}{}
                                      <div ref={messagesEndRef} />
                                </ul>
                          </div>
                              
                            ):(
                             ""
                            )
                          }                                                           
                </div>
                  <div class="text-muted d-flex justify-content-between align-items-center pt-1 mt-2 send-box ">
                      <img src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava6-bg.webp"
                          alt="avatar 3" style={{width: "40px", height: "100%",marginLeft:"20px"}}></img>
                      <input type="text" class="form-control form-control-lg" value={text} onChange={(e) => setText(e.target.value)} id="exampleFormControlInput2"
                          placeholder="Type message"></input>
                      <button className="btn btn-primary rounded-2 " onClick={handleSendMessage}>send</button>

                      
                  </div>
                </div>

            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
</section>
        
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

