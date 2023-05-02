import "./Userinfo.css";
import React, { useEffect, useState } from "react";
import { Link } from "react-router-dom";

export default function Userinfo() {
  const [username, setusername] = useState("");
  const [email, setemail] = useState("");
  const [mobilenumber, setmobilenumber] = useState("");
  const [location, setlocation] = useState("");
  const [dateofbirth, setdateofbirth] = useState("");
  const [gender, setgender] = useState("");
  const [Userimg, setUserimg] = useState(null);

  const [UserID, setUserID] = useState("");
  console.log(UserID);
  const [UserToken, setUserToken] = useState("");
  console.log(UserToken);

  useEffect(() => {
    setUserToken(window.localStorage.getItem("usertoken"));
    const storedUserData = window.localStorage.getItem("UserData");
    const parsedUserData = JSON.parse(storedUserData);
    setUserID(parsedUserData.user._id);
    setusername(parsedUserData.user.fullName);
    setemail(parsedUserData.user.email);
    setmobilenumber(parsedUserData.user.phone);
    setUserimg(parsedUserData.user.userImage);
  }, []);
  return (
    <>
      <div className="container  ">
        <div className="row vh-100 flex-column align-items-center justify-content-center   ">
          <div className=" col-8 rounded-4 border border-dark  pt-4 ">
            <div className="row   align-items-center justify-content-center ">
              <div className="col-2  ">
                <img src={Userimg} alt="" className="w-100 userinfo_img" />
              </div>
              <div className=" offset-7 col-2   ">
                <Link to={"/Profile/settings/myaccount"}>
                  <button className="btn btn-primary">Edditing</button>
                </Link>
              </div>
            </div>
            <div className="row  mb-3  ">
              <div className="profile-user-info offset-1 col-4  justify-content-center ">
                <div className="user-info mt-4  ">
                  <h5 className=" "> User Name </h5>
                  <h6 className="w-100 "> {username} </h6>
                </div>
                <div className="user-info mt-5  ">
                  <h5 className=" ">Email </h5>
                  <h6 className="w-100"> {email}</h6>
                </div>

                <div className=" user-info mt-5  pb-4 ">
                  <h5 className="">Mobile Number </h5>
                  <h6 className="w-100  ">{mobilenumber}</h6>
                </div>
              </div>
              <div className="profile-user-info offset-1 col-4   ">
                <div className=" user-info mt-4  ">
                  <h5 className="">Location </h5>
                  <h6 className="w-100  ">tanta </h6>
                </div>

                <div className=" user-info mt-5  ">
                  <h5 className="">Gender</h5>
                  <h6 className="w-100  ">male </h6>
                </div>

                <div className=" user-info mt-5 pb-4">
                  <h5 className="">Date Of Birth</h5>
                  <h6 className="w-100  "> 17/6/1999</h6>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
