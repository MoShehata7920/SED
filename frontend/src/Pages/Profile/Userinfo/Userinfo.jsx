import "./Userinfo.css";
import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";
import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
import { getUserId } from "../../../Component/axios/tokendata/Token_Data";

export default function Userinfo() {
  const GetApi = `/users/get`;
  const { data, isPending, error } = UseAxiosGet(GetApi);
  let UserData = data ? data.user : "";

  return (
    <>
      <div className="container-fluid bg-light ">
        <div className="row mt-5 flex-column align-items-center justify-content-center   ">
          <div className=" bg-white col-xxl-8 col-xl-8 col-lg-8 col-md-12 col-sm-12 col-12 rounded-4 border border-dark  pt-4 ">
            <div className="row align-items-center justify-content-center ">
              <div className=" col-xxl-2 col-xl-2 col-lg-3 col-md-3 col-sm-6 col-6  ">
                <img
                  src={UserData.userImage}
                  alt=""
                  className="w-100 rounded-5"
                />
              </div>
              <div className=" offset-7 col-2   ">
                <Link to={`/Profile/settings/myaccount/${UserData._id}`}>
                  <button className="btn btn-primary">Edditing</button>
                </Link>
              </div>
            </div>
            <div className="row  mb-3 justify-content-center text-center ">
              <div className="profile-user-info   col-xxl-4 col-xl-4  col-lg-6 col-md-6 col-sm-12 col-12  ">
                <div className="user-info mt-4  ">
                  <h5 className=" "> Full Name </h5>
                  <h6 className="w-100 "> {UserData.fullName} </h6>
                </div>
                <div className="user-info mt-5  ">
                  <h5 className=" ">Email </h5>
                  <h6 className="w-100"> {UserData.email}</h6>
                </div>
              </div>
              <div className="profile-user-info h-100  col-xxl-4 col-xl-4  col-lg-6 col-md-6 col-sm-12 col-12    ">
                <div className=" user-info mt-4  ">
                  <h5 className="">Location </h5>
                  <h6 className="w-100  ">
                    {UserData.government}/{UserData.address}
                  </h6>
                </div>
                <div className=" user-info mt-5  pb-4 ">
                  <h5 className="">Mobile Number </h5>
                  <h6 className="w-100  ">{UserData.phone}</h6>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
