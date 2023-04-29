import "./Profile.css";
import "./Profile";
import React, { useEffect, useState } from "react";
import {} from "react-icons/ci";
import "./user.png";
import {BsBookmarkHeart  ,BsListCheck,BsPerson,BsHeart,BsGearWideConnected,BsBoxArrowLeft} from "react-icons/bs";
import {  Link, Outlet } from "react-router-dom";



function Profile() {
  return (
    <>
<<<<<<< Updated upstream
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
=======
    <div className="container-fluid" >
      <div className="row">
        <div className="col-auto min-vh-100 bg-dark   profile-sidebar">
        <ul className="">

                    <li className="sidebar-item" >
                      <a href="{}"><i>{<BsPerson/>}</i> <span className="ms-1 d-none d-sm-inline"> img </span></a>
                    </li>
                    <li className="sidebar-item" >
                      <a href="{}"><Link to={'/Profile/userinfo'}><i>{<BsPerson/>}</i> <span className="ms-1 d-none d-sm-inline"> User info </span></Link></a>
                    </li>
                    <li className="sidebar-item" >
                      <a href="{}"><Link to={'/profile/favourit'}><i>{<BsHeart/>}</i> <span className="ms-1 d-none d-sm-inline"> Favourit </span></Link></a>
                    </li> 
                    <li className="sidebar-item" >
                      <a href="{}"><Link to={'/profile/watchlist'}><i>{<BsBookmarkHeart/>}</i> <span className="ms-1 d-none d-sm-inline"> Watchlist </span></Link></a>
                    </li> 
                    <li className="sidebar-item" >
                      <a href="{}"><Link to={'/profile/myorders'}><i>{<BsListCheck/>}</i> <span className="ms-1 d-none d-sm-inline"> My Orders </span></Link></a>
                    </li>
                     <li className="sidebar-item" >
                      <a href="{}"><Link to={'/profile/settings'}><i>{<BsGearWideConnected/>}</i> <span className="ms-1 d-none d-sm-inline"> Settings </span></Link></a>
                    </li>
                     <li className="sidebar-item" >
                      <a href="{}"><Link to={''}><i>{<BsBoxArrowLeft/>}</i> <span className="ms-1 d-none d-sm-inline"> Logout </span></Link></a>
                    </li> 
                  

                        
        </ul>
          

>>>>>>> Stashed changes
        </div>
        <div className="col">
     
          <Outlet>
          
          </Outlet>
        </div>

      </div>

    </div>
      
    </>
  );
}

export default Profile;
