import React, { useState } from "react";
import  io from 'socket.io-client';
import Mainchat from "./Mainchat";
const socket =io.connect("http://localhost:3006");

function Chat(){

   const[username,setusername]=useState("");
   const[room,setroom]=useState("");

   const joinRoom = ()=> {
    if (username!=="" && room !==""){
        socket.emit("join_room",room)
    }}

    return(
        <>
        <div className="d-flex justify-content-center text-center">
            <div className="m-5 border border-black d-block">
                <h3> JOIN A Chat </h3>
                <input type="text" placeholder="mohamed..." onChange={(event=>{setusername(event.target.value);})} ></input>
                <input type="text" placeholder="Room Id..." onChange={(event=>{setroom(event.target.value);})}></input>
                <button onClick={joinRoom}>Join A Room</button>
            </div>

        </div>
        <Mainchat socket={socket} username={username} room={room}/>
        </>
    )
}

export default Chat;
