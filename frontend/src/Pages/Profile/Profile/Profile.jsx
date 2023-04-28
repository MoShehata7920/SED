import "./Profile.css";
import "./Profile";
import React from "react";
import {} from "react-icons/ci";
import "./user.png";

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
      <div className="profile_content profile">
        <div className="Sidebar-items" style={{ height: "auto" }}>
          <ul className="list">
            <li className="side-img">
              <img src={require("./user.png")} alt="" />
            </li>
            <li className="sidebar-item">
              <button>
                <Link to={"/Profile/userinfo"}>
                  <i>{<BsPerson />}</i> <span> user info </span>
                </Link>
              </button>
            </li>
            <li className="sidebar-item">
              <button>
                <Link to={"/Profile/favourit"}>
                  <i>{<BsHeart />}</i> <span> favourit </span>
                </Link>
              </button>
            </li>
            <li className="sidebar-item">
              <button>
                <Link to={"/Profile/watchlist"}>
                  <i>{<BsBookmarkHeart />} </i>
                  <span> watchlist </span>
                </Link>
              </button>
            </li>
            <li className="sidebar-item">
              <button>
                <Link to={"/Profile/myorders"}>
                  <i>{<BsListCheck />}</i> <span> My Orders</span>
                </Link>
              </button>
            </li>
            <li className="sidebar-item">
              <button>
                <Link to={"/Profile/settings"}>
                  <i>{<BsGearWideConnected />}</i> <span> Settings </span>
                </Link>
              </button>
            </li>
            <li className="sidebar-item">
              <button>
                <Link to={"/logout"}>
                  <i>{<BsBoxArrowLeft />} </i>
                  <span> Logout </span>
                </Link>
              </button>
            </li>
          </ul>
        </div>
        <div className="page-content">
          <Outlet></Outlet>
        </div>
      </div>
    </>
  );
}

export default Profile;
