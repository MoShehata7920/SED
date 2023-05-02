import "./Userinfo.css";
import React, { useState } from "react";
import "./user.png";
import MyAccount from "../Settings/Myaccount/MyAccount";

export default function Userinfo() {
  let [Editing, setEditing] = useState(false);
  const handelEditing = () => {
    setEditing(true);
  };
  return (
    <>
    {Editing?
    <MyAccount  Editing={Editing} />
    :
      <div className="container px-1">
        <div className="row justify-content-center ">
          <div className="col-lg-8   border border-dark rounded  rounded-3 mt-5  ">
            <div className=" offset-10">
              <button onClick={handelEditing} className="btn">Edditing</button>
            </div>
            <div className="d-flex py-3 ">
              <div className="profile-user-info row py-3  px-1 justify-content-center ">
                <div className="user-info row py-3">
                  <h5 className="py-1 "> User Name </h5>
                  <h6 className="w-75 "> mohamed adel </h6>
                </div>
                <div className="user-info row py-3">
                  <h5 className="py-1 ">Email </h5>
                  <h6 className="w-75 "> ahmen1999@gami.com</h6>
                </div>

                <div className=" user-info row py-3">
                  <h5 className="py-1">Mobile Number </h5>
                  <h6 className="w-75  ">01115572758</h6>
                </div>
              </div>
              <div className="profile-user-info row py-3  px-1 justify-content-center ">
                <div className=" user-info row py-3">
                  <h5 className="py-1">Location </h5>
                  <h6 className="w-100  ">tanta </h6>
                </div>

                <div className=" user-info row py-3">
                  <h5 className="py-1">Gender</h5>
                  <h6 className="w-100  ">male </h6>
                </div>

                <div className=" user-info  row py-3">
                  <h5 className="py-1">Date Of Birth</h5>
                  <h6 className="w-100  "> 17/6/1999</h6>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    }
    </>
  );
}
