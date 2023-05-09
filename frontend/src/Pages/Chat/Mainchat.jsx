import React, { useEffect, useState } from "react";
import"./Mainchat.css"



function Mainchat({socket,username,room}){

        const[currentmessage,setcurrentmessage]=useState("");
        const sendMessage= async ()=>{
            if(currentmessage !==""){
                const messagData= {
                    room:room,
                    author:username,
                    message:currentmessage,
                    time:new Date(Date.now()).getHours() +":"+ new Date(Date.now()).getMinutes,
                };
        await socket.emit("send_message",messagData) }}

        useEffect(()=>{
            

            socket.on("receive_message",(data)=>{
console.log(data)
            })
          
        },[socket])

    return(
        <>
        <div className="d-flex justify-content-center">
            <div className="col-lg-6 border border-dark d-block m-2  ">
                    <div className="chat-header text-center">

                        <p>Live Chat</p>
                    </div>
                    <div className="chat-boady"></div>
                    <div className="chat-footer text-center m-2"> 
                     <input type="text" placeholder="Hey.." onChange={(event=>{setcurrentmessage(event.target.value);})} ></input>
                     <button onClick={sendMessage}>&#9658;</button>
                    </div>
                    
            </div>
        </div>
       
        </>
    )
}

export default Mainchat;
