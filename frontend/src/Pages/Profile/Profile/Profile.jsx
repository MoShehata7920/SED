import "./Profile.css";
import "./Profile";
import React, { useEffect, useState } from "react";
import Navebar from "../../../Component/navebar/navbar";
import {} from "react-icons/ci";
import {
  BsListCheck,
  BsPerson,
  BsHeart,
  BsGearWideConnected,
  BsFillBellFill,
} from "react-icons/bs";
import { Link, Outlet } from "react-router-dom";
import axios from "axios";

function Profile() {
  const UserToken = localStorage.getItem("usertoken");
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState(null);
  const [UserData, setUserData] = useState("");
  const GetUserDeta = async () => {
    setError(null);
    setIsPending(true);
    try {
      let UserData = await axios.get(`http://103.48.193.225:3000/users/get`, {
        headers: {
          Authentication: `Bearer ${UserToken}`,
        },
      });
      setUserData(UserData.data.user);
      setIsPending(false);
    } catch (err) {
      setIsPending(false);
      setError("could not fetch the data");
      console.log(err.message);
    }
  };
  useEffect(() => {
    GetUserDeta();
  }, []);
  return (
    <>
      <section>
        <Navebar />
      </section>
      <section>
        <div className="container-fluid">
          <div className="row">
            <div className="col-2 vh-100  bg-light   profile-sidebar d-flex flex-column  justify-content-center">
              <ul className=" text-center">
                <div className=" d-flex align-items-center">
                  <img
                    src={UserData.userImage}
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
                  <Link to={"/profile/myProduct"}>
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
                  <Link to={"/profile/settings"}>
                    <i className="text-black">{<BsGearWideConnected />}</i>
                    <span className="ms-1 d-none d-sm-inline text-black">
                      Settings
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
