import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { Link, useNavigate, useParams } from "react-router-dom";
import { UseAxiosPache } from "../../../Component/axios/PachApi/PatchApi";
export default function Change_Password() {
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

  useEffect(() => {
    if (response) {
      toast(`✔️ ${response}`);
      setTimeout(() => {
        navigate("/Profile");
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
            <form
              onSubmit={itemsubmit}
              className="row mt-3 justify-content-center "
            >
              <div className=" ms-4 col-5">
                <div class="mb-3">
                  <label class="form-label">old Password </label>
                  <input
                    name="oldPassword"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                    aria-describedby="emailHelp"
                  ></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">password </label>
                  <input
                    name="password"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                  ></input>
                </div>
                <div class="mb-3">
                  <label class="form-label">confirm Password</label>
                  <input
                    name="confirmPassword"
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
