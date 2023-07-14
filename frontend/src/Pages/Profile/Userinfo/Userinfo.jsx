import "./Userinfo.css";
import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
import React, { useEffect, useRef, useState } from "react";
import Navebar from "../../../Component/navebar/navbar";
import { MdAddShoppingCart, MdVerified } from "react-icons/md";
import { AiOutlineReddit } from "react-icons/ai";
import { BsListCheck, BsHeart, BsFillBellFill } from "react-icons/bs";
import { FaLock } from "react-icons/fa";
import { Link, Outlet } from "react-router-dom";

export default function Userinfo() {
  const GetApi = `/users/get`;
  const { data, isPending, error } = UseAxiosGet(GetApi);
  let datauser = data ? data.user : "";

  return (
    <>
      <section>
        <Navebar />
      </section>
      <div className="row ">
        <div className="col-12 userinfo-bg  profile-sidebar d-flex flex-column  justify-content-center">
          <div className=" col-12 border-bottom-0  d-flex  justify-content-center  pt-4 mb-2 ">
            <div className="  userinfo_Img_hight bg-image ">
              <img
                src={datauser.userImage}
                alt=""
                className=" w-100 h-100  rounded-circle  "
              />
            </div>
          </div>
          <h5 className=" text-center">Hello {datauser.fullName}</h5>
          <div className="w-100 border border-1 border-black"></div>

          <ul className=" text-center d-flex justify-content-around">
            <li>
              <Link to={`/profile/myProduct/${datauser._id}`}>
                <label class="btn btn-outline-primary me-4 ">
                  <i className="text-black ">{<BsListCheck />}</i>
                  <span className="ms-1 d-none d-sm-inline text-black">
                    Product
                  </span>
                </label>
              </Link>
              <Link to={"/profile/favourit"}>
                <label class="btn btn-outline-primary me-4 ">
                  <i className="text-black">{<BsHeart />}</i>
                  <span className="ms-1 d-none d-sm-inline text-black">
                    Favourit
                  </span>
                </label>
              </Link>

              <label class="btn btn-outline-primary me-4 " for="btnradio1">
                <Link
                  className="text-decoration-none position-relative"
                  to={"/Profile/notification"}
                >
                  <i className="text-black">{<BsFillBellFill />}</i>
                  <span class="position-absolute top-0 start-0 translate-middle badge   text-black">
                    10+
                  </span>
                  <span className="ms-1 d-none d-sm-inline text-black">
                    Notification
                  </span>
                </Link>
              </label>

              <label class="btn btn-outline-primary me-4 " for="btnradio1">
                <Link
                  className="text-decoration-none "
                  to={`/Profile/myaccount/${datauser._id}`}
                >
                  <i className="text-black">{<AiOutlineReddit />}</i>
                  <span className="ms-1 d-none d-sm-inline text-black">
                    Account Eddit
                  </span>
                </Link>
              </label>

              <label class="btn btn-outline-primary me-4 " for="btnradio1">
                <Link
                  className="text-decoration-none "
                  to={`/Profile/ChangePassword/${datauser._id}`}
                >
                  <i className="text-black">{<FaLock />}</i>
                  <span className="ms-1 d-none d-sm-inline text-black">
                    Change Password
                  </span>
                </Link>
              </label>
              <label class="btn btn-outline-primary me-4 " for="btnradio1">
                <Link
                  className="text-decoration-none "
                  to={"/profile/addItems"}
                >
                  <i className="text-black">{<MdAddShoppingCart />}</i>
                  <span className="ms-1 d-none d-sm-inline text-black">
                    Add Product
                  </span>
                </Link>
              </label>
              <label class="btn btn-outline-primary me-4 " for="btnradio1">
                <Link
                  className="text-decoration-none "
                  to={"/Email_verfication"}
                >
                  <i className="text-black">{<MdVerified />}</i>
                  <span className="ms-1 d-none d-sm-inline text-black">
                    Verify Email
                  </span>
                </Link>
              </label>
            </li>
          </ul>
        </div>
      </div>
    </>
  );
}
