import"./Profile.css";
import"./Profile"
import React from "react";
import { } from "react-icons/ci";
import "./user.png"

import {BsBookmarkHeart  ,BsListCheck,BsPerson,BsHeart,BsGearWideConnected,BsBoxArrowLeft} from "react-icons/bs";


import { Link, Outlet } from "react-router-dom";



function Profile() {




  return (
    <>

    <div className="content">
            <div className="Sidebar-items" style={{height:"100vh"}}>
              <ul className="list">  
                    <li className="side-img"> <img src={require('./user.png')} alt="" /> </li>              
                    <li className="sidebar-item" > <a href="{}"><button><Link to={'/userinfo'}> <i>{<BsPerson/>}</i> <span> user info </span></Link></button> </a></li>
                    <li className="sidebar-item"> <a href="{}"> <button><Link to={'/favourit'}> <i>{<BsHeart/>}</i> <span> favourit </span> </Link></button></a></li>
                    <li className="sidebar-item"><a href="{}"> <button><Link to={'/watchlist'}> <i>{<BsBookmarkHeart/>} </i><span> watchlist </span></Link></button></a></li>
                    <li className="sidebar-item"> <a href="{}"><button><Link to={'/myorders'}><i>{<BsListCheck/>}</i> <span> My Orders</span></Link></button> </a></li>
                    <li className="sidebar-item"><a href="{}"> <button><Link to={'/settings'}> <i>{<BsGearWideConnected/>}</i> <span> Settings </span></Link></button></a></li>
                    <li className="sidebar-item"> <a href="{}"> <button><Link to={'/logout'}> <i>{<BsBoxArrowLeft/>} </i><span> Logout </span> </Link></button></a></li>
               </ul>
            </div>
  
            <div className="page-content">
                <Outlet>
                    
                </Outlet> 
            </div>
    </div>
    </>
  );
}

export default Profile;
