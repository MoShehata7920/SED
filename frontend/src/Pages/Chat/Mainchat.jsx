import React, { useEffect, useState } from "react";
import"./Mainchat.css";
import ScrollToBottom from 'react-scroll-to-bottom';


function Mainchat({socket,username,room}){

        const[currentmessage,setcurrentmessage]=useState("");
        const[messageList,setmessageList]=useState([]);
        
        const sendMessage= async ()=>{
            if(currentmessage !=="" ){
                const messageData= {
                    room:room,
                    author:username,
                    message:currentmessage,
                    time:new Date(Date.now()).getHours() +":"+ new Date(Date.now()).getMinutes,
                };
        await socket.emit("send_message", messageData) }
        setmessageList((list)=>[...list,messageData])}

        useEffect(()=>{
            
            socket.on("receive_message",(data)=>{
               setmessageList((list)=>[...list,data])})
                 
        },[socket])



    return(
        <>
        <div className="d-flex justify-content-center">
            <div className="chat-window col-lg-6 border border-dark d-block m-2  ">
                    <div className="chat-header text-center"> <p>Live Chat</p> </div>

                    <div className="chat-boady">
                         <ScrollToBottom className="message-container">
                            {messageList.map((messageContenet)=>{
                             return (
                                <div className="message" id={username===messageContenet.author?"you":"other"}>                      
                                    <div>
                                        <div className="message-content"><p>{messageContenet.message}</p></div>
                                        <div className="message-meta">
                                            <p>{messageContenet.time}</p>
                                            <p>{messageContenet.author}</p>
                                        </div>
                                    </div>          
                                </div>
                                 )})}
                         </ScrollToBottom>        
                     </div>

                    <div className="chat-footer text-center m-2"> 
                        <input type="text" placeholder="Hey.." value={currentmessage} onChange={(event=>{setcurrentmessage(event.target.value);})}> </input>
                        <button onClick={sendMessage}>&#9658;</button>
                    </div>
                    
            </div>
        </div>
       
        </>
    )
}

export default Mainchat;
