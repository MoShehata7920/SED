import "./Profile.css";
import "./Profile";
import React, { useEffect, useState } from "react";
import {} from "react-icons/ci";
import {
  BsBookmarkHeart,
  BsListCheck,
  BsPerson,
  BsHeart,
  BsGearWideConnected,
  BsBoxArrowLeft,
} from "react-icons/bs";
import { Link, Outlet } from "react-router-dom";

function Profile() {
  return (
    <>
      <div className="container-fluid">
        <div className="row">
          <div className="col-auto min-vh-100 bg-dark   profile-sidebar">
            <ul className="py-5">
              <li className="sidebar-item py-1">
                <a href="{}">
                  <Link to={"/Profile/userinfo"}>
                    <i>{<BsPerson />}</i>{" "}
                    <span className="ms-1 d-none d-sm-inline"> User info </span>
                  </Link>
                </a>
              </li>
              <li className="sidebar-item py-1">
                <a href="{}">
                  <Link to={"/profile/favourit"}>
                    <i>{<BsHeart />}</i>{" "}
                    <span className="ms-1 d-none d-sm-inline"> Favourit </span>
                  </Link>
                </a>
              </li>
              <li className="sidebar-item py-1">
                <a href="{}">
                  <Link to={"/profile/watchlist"}>
                    <i>{<BsBookmarkHeart />}</i>{" "}
                    <span className="ms-1 d-none d-sm-inline"> Watchlist </span>
                  </Link>
                </a>
              </li>
              <li className="sidebar-item py-1">
                <a href="{}">
                  <Link to={"/profile/myorders"}>
                    <i>{<BsListCheck />}</i>{" "}
                    <span className="ms-1 d-none d-sm-inline"> My Orders </span>
                  </Link>
                </a>
              </li>
              <li className="sidebar-item py-1">
                <a href="{}">
                  <Link to={"/profile/settings"}>
                    <i>{<BsGearWideConnected />}</i>{" "}
                    <span className="ms-1 d-none d-sm-inline"> Settings </span>
                  </Link>
                </a>
              </li>
              <li className="sidebar-item py-1">
                <a href="{}">
                  <Link to={""}>
                    <i>{<BsBoxArrowLeft />}</i>{" "}
                    <span className="ms-1 d-none d-sm-inline"> Logout </span>
                  </Link>
                </a>
              </li>
            </ul>
          </div>
          <div className="col">
            <Outlet></Outlet>
          </div>
        </div>
      </div>
    </>
  );
}

export default Profile;
