import "./Change_Admin_Password.css";
import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate, useParams } from "react-router-dom";
import { Icon } from "react-icons-kit";
import { eyeOff } from "react-icons-kit/feather/eyeOff";
import { eye } from "react-icons-kit/feather/eye";
import { UseAxiosPache } from "../../../Component/axios/PachApi/PatchApi";
import AdminInfo from "../../../Component/AdminInfo/AdminInfo";
export default function ChangeAdminPassword() {
  const [type, setType] = useState("password");
  const [icon, setIcon] = useState(eyeOff);
  const navigate = useNavigate();
  let { UserID } = useParams();
  const [userInfoEdit, setuserInfoEdit] = useState({
    oldPassword: "",
    password: "",
    confirmPassword: "",
  });
  const patchAPi = `/users/change-password/${UserID}`;
  function getUserinfo(e) {
    let myinfo = { ...userInfoEdit };
    myinfo[e.target.name] = e.target.value;
    setuserInfoEdit(myinfo);
  }

  const { response, ErrorMessage, HandelPachApi } = UseAxiosPache(
    patchAPi,
    userInfoEdit
  );
  async function itemsubmit(e) {
    e.preventDefault();
    HandelPachApi();
  }
  const handleToggle = () => {
    if (type === "password") {
      setIcon(eye);
      setType("text");
    } else {
      setIcon(eyeOff);
      setType("password");
    }
  };
  useEffect(() => {
    if (response) {
      toast(`✔️ ${response}`);
      setTimeout(() => {
        navigate("/Admin/UsersInfo");
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [response, ErrorMessage]);
  return (
    <>
      <AdminInfo />
      <div className="row      ">
        <div className="  col-12 ">
          <div className="Card_div  ">
            <form onSubmit={itemsubmit}>
              <div class="segment">
                <h1>Password</h1>
              </div>

              <label className=" position-relative">
                <input
                  name="oldPassword"
                  onChange={getUserinfo}
                  type={type}
                  placeholder="Old Password"
                />
                <span className=" icon-change-pass   " onClick={handleToggle}>
                  <Icon icon={icon} size={25} />
                </span>
              </label>
              <label>
                <input
                  name="password"
                  onChange={getUserinfo}
                  type={type}
                  placeholder="New Password"
                />
              </label>
              <label>
                <input
                  name="confirmPassword"
                  onChange={getUserinfo}
                  type={type}
                  placeholder="Confirm Password"
                />
              </label>

              <button class="red mb-3" type="submit">
                <i class="icon ion-md-lock"></i> Change
              </button>
            </form>
          </div>
        </div>
      </div>
      <ToastContainer />
    </>
  );
}
