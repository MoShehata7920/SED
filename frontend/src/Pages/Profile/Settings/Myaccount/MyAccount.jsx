import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { Link } from "react-router-dom";
import "./MyAccount.css";
import Axios from "axios";

function MyAccount() {
  const [userInfoEdit, setuserInfoEdit] = useState({
    fullName: "",
    email: "",
    government: "",
    address: "",
    phone: "",
  });
  const [UserID, setUserID] = useState("");
  const [UserToken, setUserToken] = useState("");
  console.log(userInfoEdit);
  const [selectedFile, setSelectedFile] = useState(null);
  const [response, setResponse] = useState("");
  const [ErrorMessage, setErrorMessage] = useState("");
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
  async function itemsubmit(e) {
    e.preventDefault();

    let request = await Axios.patch(
      `http://47.243.7.214:3000/users/update/${UserID}`,
      formData,
      {
        headers: {
          Authentication: `Bearer ${UserToken}`,
        },
      }
    )
      .then((response) => {
        setResponse(response.data.message);
      })
      .catch((error) => {
        // check for the response property of the error object
        if (error.response) {
          // set the error message state variable with the error message
          setErrorMessage(error.response.data.message);
        }
      });
  }

  useEffect(() => {
    setUserToken(window.localStorage.getItem("usertoken"));
    const storedUserData = window.localStorage.getItem("UserData");
    const parsedUserData = JSON.parse(storedUserData);
    setUserID(parsedUserData._id);

    if (response) {
      toast(`✔️ ${response}`);
      setTimeout(() => {
        window.location.href = "/Profile/userinfo";
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [response, ErrorMessage]);
  return (
    <>
      <div className="container  ">
        <div className="row vh-100  flex-column align-items-center justify-content-center   ">
          <div className=" col-xxl-8 col-xl-8 col-lg-10 col-md-10 col-sm-12 col-12 rounded-3 border border-dark  pt-3 pb-3">
            <form onSubmit={itemsubmit} className="row mt-3 ">
              <div className=" ms-4 col-5">
                <div class="mb-3">
                  <label class="form-label">user name </label>
                  <input
                    placeholder={userInfoEdit.fullName}
                    name="fullName"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                    aria-describedby="emailHelp"
                  ></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">Email </label>
                  <input
                    placeholder={userInfoEdit.email}
                    name="email"
                    onChange={getUserinfo}
                    type="email"
                    class="form-control"
                  ></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">Government</label>
                  <input
                    placeholder={userInfoEdit.government}
                    name="government"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                  ></input>
                </div>
              </div>
              <div className=" offset-1 col-5">
                <div class="mb-3">
                  <label class="form-label">Address </label>
                  <input
                    placeholder={userInfoEdit.address}
                    name="address"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                  ></input>
                </div>

                <div class="mb-3 "></div>

                <div class="mb-3">
                  <label class="form-label">Your IMG </label>
                  <input
                    onChange={handleImageChange}
                    class="form-control"
                    type="file"
                    id="formFile"
                  />
                </div>

                <div class="mb-3">
                  <label class="form-label">mobile number </label>
                  <input
                    placeholder={userInfoEdit.phone}
                    name="phone"
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
              <ToastContainer />
            </form>
          </div>
        </div>
      </div>
    </>
  );
}
export default MyAccount;
