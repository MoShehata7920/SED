import "./Profile.css";
import "./Profile";
import React, { useEffect, useState } from "react";
import Navebar from "../../../Component/navebar/navbar";
import { MdAddShoppingCart, MdVerified } from "react-icons/md";
import {
  BsListCheck,
  BsPerson,
  BsHeart,
  BsGearWideConnected,
  BsFillBellFill,
} from "react-icons/bs";
import { FaLock } from "react-icons/fa";
import { Link, Outlet } from "react-router-dom";
import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
function Profile() {
  const GetApi = `/users/get`;
  const { data, isPending, error } = UseAxiosGet(GetApi);
  let datauser = data ? data.user : "";
  useEffect(() => {}, [datauser]);
  return (
    <>
      <section>
        <Navebar />
      </section>
      <section>
        <div className="container-fluid bg-light ">
          <div className="row">
            <div className="col-2 vh-100  bg-light   profile-sidebar d-flex flex-column  justify-content-center">
              <ul className=" text-center">
                <div className=" d-flex align-items-center">
                  <img
                    src={datauser.userImage}
                    className="w-100 rounded-circle me-4"
                    alt=""
                  />
                </div>
                <li className="sidebar-item ">
                  <Link to={"/Profile/userinfo"}>
                    <i className="text-black">{<BsPerson />}</i>
                    <span className="ms-1 d-none d-sm-inline text-black">
                      User info
                    </span>
                  </Link>
                </li>
                <li className="sidebar-item ">
                  <Link to={`/profile/myProduct/${datauser._id}`}>
                    <i className="text-black ">{<BsListCheck />}</i>
                    <span className="ms-1 d-none d-sm-inline text-black">
                      Product
                    </span>
                  </Link>
                </li>
                <li className="sidebar-item ">
                  <Link to={"/profile/favourit"}>
                    <i className="text-black">{<BsHeart />}</i>
                    <span className="ms-1 d-none d-sm-inline text-black">
                      Favourit
                    </span>
                  </Link>
                </li>
                <li className="sidebar-item ">
                  <Link
                    className="text-decoration-none position-relative"
                    to={"/Profile/settings/notification"}
                  >
                    <i className="text-black">{<BsFillBellFill />}</i>
                    <span class="position-absolute top-0 start-0 translate-middle badge   text-black">
                      10+
                    </span>
                    <span className="ms-1 d-none d-sm-inline text-black">
                      Notification
                    </span>
                  </Link>
                </li>
                <li className="sidebar-item mb-3">
                  <Link to={`/Profile/ChangePassword/${datauser._id}`}>
                    <i className="text-black">{<FaLock />}</i>
                    <span className="ms-1 d-none d-sm-inline text-black">
                      ChangePassword
                    </span>
                  </Link>
                </li>
                <li className="sidebar-item mb-3">
                  <Link to={"/addItems"}>
                    <i className="text-black">{<MdAddShoppingCart />}</i>
                    <span className="ms-1 d-none d-sm-inline text-black">
                      Add Product
                    </span>
                  </Link>
                </li>
                <li className="sidebar-item mb-3">
                  <Link to={"/addItems"}>
                    <i className="text-black">{<MdVerified />}</i>
                    <span className="ms-1 d-none d-sm-inline text-black">
                      Verifie Email
                    </span>
                  </Link>
                </li>
              </ul>
            </div>
            <div className="col">
              <Outlet></Outlet>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}

export default Profile;
