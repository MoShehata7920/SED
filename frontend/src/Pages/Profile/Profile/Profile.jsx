import "./Profile.css";
import "./Profile";
import React, { useEffect, useRef, useState } from "react";
import Navebar from "../../../Component/navebar/navbar";
import { MdAddShoppingCart, MdVerified } from "react-icons/md";
import { AiOutlineReddit } from "react-icons/ai";
import { BsListCheck, BsHeart, BsFillBellFill } from "react-icons/bs";
import { FaLock } from "react-icons/fa";
import { Link, Outlet } from "react-router-dom";
import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
import Footer from "../../../Component/footer/Footer";
import Userinfo from "../Userinfo/Userinfo";
function Profile() {
  // const GetApi = `/users/get`;
  // const { data, isPending, error } = UseAxiosGet(GetApi);
  // let datauser = data ? data.user : "";
  return (
    <>
      <section>
        <div>
          <Outlet></Outlet>
        </div>
      </section>
      <section>
        <Footer />
      </section>
    </>
  );
}

export default Profile;
