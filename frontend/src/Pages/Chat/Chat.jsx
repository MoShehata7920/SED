import React, { useState, useEffect, useRef } from "react";
import io from "socket.io-client";
import "./Chat.css";
import axios from "axios";
import { getTokendeta } from "../../Component/axios/tokendata/Token_Data";
import moment from "moment";

const Chat = () => {
  const Tokendata = getTokendeta();
  const [socket, setSocket] = useState(null);
  const [conversationId, setConversationId] = useState(null);
  const [messages, setMessages] = useState([]);
  const [text, setText] = useState("");
  
  const senderId = Tokendata.id;
  const user = Tokendata;
  
  const messagesEndRef = useRef(null);
  const [userConversations, setUserConversations] = useState([]);

  const instance = axios.create({
    baseURL: "http://localhost:3000",
  });

  useEffect(() => {
    instance
      .get(`/chat/user-convs/${senderId}`)
      .then((res) => {
        res.data.conversations
          ? setUserConversations(res.data.conversations)
          : setUserConversations([]);
       
      })
      .catch((err) => {
        console.log(err);
      });
  }, []);

  useEffect(() => {
    console.log("Connecting to socket server...");
    const newSocket = io.connect("http://localhost:3000", {
      transports: ["websocket"],
    }); 
    setSocket(newSocket);
    return () => newSocket.close();
  }, []);

  useEffect(() => {
    if (socket) {
      console.log("socket true");
      socket.on("previousMessages", (messages) => {
        setMessages(messages);
      
      });

      socket.on("messageReceived", (message) => {
        console.log(" received  should be here");

        setMessages((prevMessages) => [...prevMessages, message]);
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
    setConversationId(conversationId);
    socket.emit("joinConversation", conversationId);
  };

  const handleSendMessage = () => {
    console.log(text);
    console.log(conversationId);
    console.log(senderId);

    if (text.trim().length > 0) {
      socket.emit("sendMessage", { conversationId, senderId, text });
      setText("");
    }
  };

  return (
    <section className="chat  ">
      <div class="container py-5 my-5 chat-container">
        <div class="row">
          <div class="col-md-12">
            <div className="card" id="chat3" style={{ borderradius: "15px" }}>
              <div class="card-body">
                <div class="row">
                  <div class="col-md-6 col-lg-5 col-xl-4 mb-4 mb-md-0  ">
                    <div className="chat-head">
                      <h3>Chats</h3>
                    </div>
                    <div class="p-3">
                      {userConversations.map((conversation) => {
                        // Check if the first user ID in the conversation is the sender's ID
                        const receiverUser =
                          conversation.users[0]._id === senderId
                            ? conversation.users[1] // Choose the second user ID as the conversation name
                            : conversation.users[0]; // Choose the first user ID as the conversation name
                        // console.log(receiverUser)
                        return (
                          <div className=" chatslist"
                            data-mdb-perfect-scrollbar="true"
                            style={{ position: "relative", height: "auto" }}
                          >
                            <ul className="list-unstyled mb-0">
                              <li
                                className="p-2 border-bottom "
                                key={conversation.id}
                              >
                                <a
                                  href="#!"
                                  className="d-flex justify-content-between"
                                  onClick={() =>
                                    handleJoinConversation(conversation._id)
                                  }
                                >
                                  <div className="d-flex flex-row">
                                    <div>
                                      {receiverUser.userImage ? (
                                        <img
                                          src={receiverUser.userImage}
                                          alt="avatar"
                                          style={{ borderRadius: "50%" }}
                                          className="d-flex align-self-center me-3  "
                                          width="60"
                                        />
                                      ) : (
                                        <img
                                          src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava1-bg.webp"
                                          alt="avatar"
                                          className="d-flex align-self-center me-3"
                                          width="60"
                                        />
                                      )}
                                      <span className="badge bg-success badge-dot"></span>
                                    </div>
                                    <div className="pt-1 reciever-info">
                                      <p className="fw-bold mb-0 ">
                                        {receiverUser.fullName}
                                      </p>
                                      <p className="small text-muted">
                                        {conversation.lastMessage}
                                      </p>
                                    </div>
                                  </div>
                                </a>
                              </li>
                            </ul>
                          </div>
                        );
                      })}
                    </div>
                  </div>

                  <div class="col-md-6 col-lg-7 col-xl-8  chatbody">
                    <div
                      class="pt-3 pe-3"
                      data-mdb-perfect-scrollbar="true"
                      style={{ position: "relative", height: " 400px" }}
                    >
                      {conversationId ? (
                        <div className="chat-scroll">
                          <ul className="">
                            {messages.map((message) => (
                              <li key={message._id}>
                                {message.sender._id === senderId ? (
                                  <div class="d-flex flex-row justify-content-end">
                                    <div>
                                      {/* <h5>{message.sender.fullName}</h5> */}
                                      <p class="small p-2 me-3 mb-1 text-white rounded-3 bg-danger mw-75">
                                        {message.text}
                                      </p>
                                      <p class="small me-3 mb-3 rounded-3 text-muted text-end">
                                        {moment(message.createdAt).format(
                                          "h:mm A"
                                        )}
                                      </p>
                                    </div>
                                  </div>
                                ) : (
                                  <div class="d-flex flex-row justify-content-start">
                                    <img
                                      src={message.sender.userImage}
                                      alt="avatar "
                                      style={{ width: "45px", height: "100%" }}
                                    ></img>
                                    <div>
                                      {/* <h5>{message.sender.fullName}</h5> */}
                                      <p class="small p-2 me-1 mb-1 text-white rounded-3 bg-primary mx-3 mw-75">
                                        {message.text}
                                      </p>
                                      <p class="small ms-3 mb-3 rounded-3 text-muted text-start">
                                        {moment(message.createdAt).format(
                                          "h:mm A"
                                        )}
                                      </p>
                                    </div>
                                  </div>
                                )}
                              </li>
                            ))}
                            {}
                            <div ref={messagesEndRef} />
                          </ul>
                        </div>
                      ) : (
                        ""
                      )}
                    </div>
                  </div>
                  <div class="text-muted d-flex justify-content-center align-items-center pt-1 mt-2  sendbox ">
                    <img
                      src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-chat/ava6-bg.webp"
                      alt="avatar 3"
                      style={{
                        width: "40px",
                        height: "100%",
                        marginLeft: "20px",
                      }}
                    ></img>
                    <input
                      type="text"
                      class="form-control form-control-lg"
                      value={text}
                      onChange={(e) => setText(e.target.value)}
                      id="exampleFormControlInput2"
                      placeholder="Type message"
                    ></input>
                    <button
                      className="btn btn-primary rounded-2 "
                      onClick={handleSendMessage}
                    >
                      send
                    </button>
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

