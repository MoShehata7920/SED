import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { Link, useNavigate, useParams } from "react-router-dom";
import "./MyAccount.css";
import { UseAxiosPache } from "../../../Component/axios/PachApi/PatchApi";
import Userinfo from "../Userinfo/Userinfo";
function MyAccount() {
  const navigate = useNavigate();
  let { UserID } = useParams();
  const [userInfoEdit, setuserInfoEdit] = useState({
    fullName: "",
    email: "",
    government: "",
    address: "",
    phone: "",
  });
  const patchAPi = `/users/update/${UserID}`;
  const [selectedFile, setSelectedFile] = useState(null);
  const handleImageChange = (e) => {
    setSelectedFile(e.target.files[0]);
  };
  console.log(selectedFile);
  function getUserinfo(e) {
    let myinfo = { ...userInfoEdit };
    myinfo[e.target.name] = e.target.value;
    setuserInfoEdit(myinfo);
  }
  const formData = new FormData();
  if (selectedFile) {
    formData.append("userImage", selectedFile);
  }
  if (userInfoEdit.fullName) {
    formData.append("fullName", userInfoEdit.fullName);
  }
  if (userInfoEdit.email) {
    formData.append("email", userInfoEdit.email);
  }
  if (userInfoEdit.phone) {
    formData.append("phone", userInfoEdit.phone);
  }
  if (userInfoEdit.government) {
    formData.append("government", userInfoEdit.government);
  }
  if (userInfoEdit.address) {
    formData.append("address", userInfoEdit.address);
  }
  for (var pair of formData.entries()) {
    console.log(pair[1] + ", " + pair[0]);
  }
  const { response, ErrorMessage, HandelPachApi } = UseAxiosPache(
    patchAPi,
    formData
  );
  async function itemsubmit(e) {
    e.preventDefault();
    HandelPachApi();
  }
  useEffect(() => {
    if (response) {
      toast(`✔️ ${response}`);
      setTimeout(() => {
        navigate("/Profile/notification");
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [response, ErrorMessage]);
  return (
    <>
      <Userinfo />
      <div className="">
        <div className="row      ">
          <div className="  col-12 ">
            <div className="Card_div  ">
              <form onSubmit={itemsubmit}>
                <div class="segment">
                  <h1>Account</h1>
                </div>

                <label>
                  <input
                    name="fullName"
                    onChange={getUserinfo}
                    type="text"
                    placeholder="full Name"
                  />
                </label>
                <label>
                  <input
                    name="email"
                    onChange={getUserinfo}
                    type="email"
                    placeholder="Email Address"
                  />
                </label>
                <label>
                  <input
                    name="government"
                    onChange={getUserinfo}
                    type="email"
                    placeholder="Government"
                  />
                </label>
                <label>
                  <input
                    name="address"
                    onChange={getUserinfo}
                    type="email"
                    placeholder="Address"
                  />
                </label>
                <label>
                  <input
                    name="phone"
                    onChange={getUserinfo}
                    type="email"
                    placeholder="Phone Number"
                  />
                </label>
                <label>
                  <input
                    onChange={handleImageChange}
                    type="file"
                    id="formFile"
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
      </div>
    </>
  );
}
export default MyAccount;
