import React, { useState } from "react";
import "./MyAccount.css";
import "./user.png";
import Userinfo from "../../Userinfo/Userinfo";

function MyAccount() {
  let [Editing, setEditing] = useState(false);
  const handelEditing = () => {
    setEditing(true);
  };
  return (
    <>
      <div className="container  ">
        <div className="row vh-100  flex-column align-items-center justify-content-center   ">
          <div className=" col-8 rounded-3 border border-dark  pt-3 pb-3">
            <div className="row ">
              <div className=" offset-1 col-4 ">
                <div class="mb-3">
                  <label class="form-label">user name </label>
                  <input
                    type="text"
                    class="form-control"
                    aria-describedby="emailHelp"
                  ></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">Email </label>
                  <input type="email" class="form-control"></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">Password</label>
                  <input type="password" class="form-control"></input>
                </div>
              </div>
              <div className=" offset-2 col-4">
                <div class="mb-3">
                  <label class="form-label">Location </label>
                  <input type="text" class="form-control"></input>
                </div>

                <div class="mb-3 "></div>

                <div class="mb-3">
                  <label class="form-label">date of birth </label>
                  <input type="date" class="form-control"></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">mobile number </label>
                  <input type="text" class="form-control"></input>
                </div>
                <div className="mb-3 d-flex justify-content-around ">
                  <button type="button" class="btn btn-primary btn-sm ">
                    Save Changes{" "}
                  </button>
                  <button type="button" class="btn btn-primary btn-sm ">
                    Cancel{" "}
                  </button>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
export default MyAccount;
