import "./Profile.css";
import "./Profile";
import React, { useEffect, useState } from "react";
import Navebar from "../../../Component/navebar/navbar";
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
      <section>
        <Navebar />
      </section>
      <section>
        <div className="container-fluid">
          <div className="row  ">
            <div className="col-auto vh-100   bg-dark   profile-sidebar d-flex flex-column  justify-content-center">
              <ul className="py-5">
                <li className="sidebar-item py-1">
                  <a href="{}">
                    <Link to={"/Profile/userinfo"}>
                      <i>{<BsPerson />}</i>
                      <span className="ms-1 d-none d-sm-inline">User info</span>
                    </Link>
                  </a>
                </li>
                <li className="sidebar-item py-1">
                  <a href="{}">
                    <Link to={"/profile/favourit"}>
                      <i>{<BsHeart />}</i>
                      <span className="ms-1 d-none d-sm-inline">Favourit</span>
                    </Link>
                  </a>
                </li>
                <li className="sidebar-item py-1">
                  <a href="{}">
                    <Link to={"/profile/watchlist"}>
                      <i>{<BsBookmarkHeart />}</i>
                      <span className="ms-1 d-none d-sm-inline">Watchlist</span>
                    </Link>
                  </a>
                </li>
                <li className="sidebar-item py-1">
                  <a href="{}">
                    <Link to={"/profile/myProduct"}>
                      <i>{<BsListCheck />}</i>
                      <span className="ms-1 d-none d-sm-inline"> Product </span>
                    </Link>
                  </a>
                </li>
                <li className="sidebar-item py-1">
                  <a href="{}">
                    <Link to={"/profile/settings"}>
                      <i>{<BsGearWideConnected />}</i>
                      <span className="ms-1 d-none d-sm-inline">Settings</span>
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
      </section>
    </>
  );
}

export default Profile;
