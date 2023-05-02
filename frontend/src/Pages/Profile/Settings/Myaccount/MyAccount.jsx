import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { Link } from "react-router-dom";
import "./MyAccount.css";

function MyAccount() {
  const [userInfoEdit, setuserInfoEdit] = useState({
    username: "",
    email: "",
    password: "",
    location: "",
    dateofbirth: "",
    mobilenumber: "",
  });
  const [UserID, setUserID] = useState("");
  console.log(UserID);
  const [UserToken, setUserToken] = useState("");
  console.log(UserToken);
  console.log(userInfoEdit);
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
  formData.append("productImage", selectedFile);
  formData.append("username", userInfoEdit.username);
  formData.append("email", userInfoEdit.email);
  formData.append("password", userInfoEdit.password);
  formData.append("mobilenumber", userInfoEdit.mobilenumber);
  formData.append("location", userInfoEdit.location);
  formData.append("dateofbirth", userInfoEdit.dateofbirth);
  formData.append("seller", UserID);

  for (var pair of formData.entries()) {
    console.log(pair[1] + ", " + pair[0]);
  }

  useEffect(() => {
    setUserToken(window.localStorage.getItem("usertoken"));
    const storedUserData = window.localStorage.getItem("UserData");
    const parsedUserData = JSON.parse(storedUserData);
    setUserID(parsedUserData.user._id);

    // if (response) {
    //   toast(`✔️ ${response}`);
    //   setTimeout(() => {
    //     window.location.reload();
    //   }, 5000);
    // }
    // if (ErrorMessage && response == "") {
    //   toast(`❌ ${ErrorMessage} please fill all input field`);
    // }
  }, []);
  return (
    <>
      <div className="container  ">
        <div className="row vh-100  flex-column align-items-center justify-content-center   ">
          <div className=" col-8 rounded-3 border border-dark  pt-3 pb-3">
            <form className="row mt-3 ">
              <div className=" offset-1 col-4 ">
                <div class="mb-3">
                  <label class="form-label">user name </label>
                  <input
                    name="username"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                    aria-describedby="emailHelp"
                  ></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">Email </label>
                  <input
                    name="email"
                    onChange={getUserinfo}
                    type="email"
                    class="form-control"
                  ></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">Password</label>
                  <input
                    name="password"
                    onChange={getUserinfo}
                    type="password"
                    class="form-control"
                  ></input>
                </div>
              </div>
              <div className=" offset-2 col-4">
                <div class="mb-3">
                  <label class="form-label">Location </label>
                  <input
                    name="location"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                  ></input>
                </div>

                <div class="mb-3 "></div>

                <div class="mb-3">
                  <label class="form-label">date of birth </label>
                  <input
                    name="dateofbirth"
                    onChange={getUserinfo}
                    type="date"
                    class="form-control"
                  ></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">mobile number </label>
                  <input
                    name="mobilephone"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                  ></input>
                </div>
              </div>
              <div className="mb-3 mt-3 d-flex justify-content-center ">
                <button type="submit" class="btn btn-primary me-4 ">
                  Save Changes
                </button>
                <Link to={"/Profile/userinfo"}>
                  <button type="button" class="btn btn-primary  ">
                    Cancel
                  </button>
                </Link>
              </div>
            </form>
          </div>
        </div>
      </div>
    </>
  );
}
export default MyAccount;
