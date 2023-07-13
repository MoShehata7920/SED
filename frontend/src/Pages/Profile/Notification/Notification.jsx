import React from "react";
import "./Notification.css";
import Userinfo from "../Userinfo/Userinfo";

function Notification() {
  return (
    <>
      <Userinfo />
      <section>
        <div className="container-fluid  vh-100 mt-4">
          <div className=" text-center">
            <h1>Notification</h1>
          </div>
          <div className="  bg-black pading_05"></div>
          <div className=""></div>
        </div>
      </section>
    </>
  );
}
export default Notification;
