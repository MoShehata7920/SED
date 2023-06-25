import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { Link, useParams } from "react-router-dom";
import { UseAxiosPost } from "../axios/PostApi/PostApi";
export default function Email_verfication() {
  const [Code, setCode] = useState("");
  const postAPi = `/auth/verifyemail`;
  function getUserinfo(e) {
    const myinfo = e.target.value;
    setCode(myinfo);
  }

  const { response, ErrorMessage, HandelPostApi } = UseAxiosPost(postAPi, Code);
  async function itemsubmit(e) {
    e.preventDefault();
    HandelPostApi();
  }

  useEffect(() => {
    if (response) {
      setTimeout(() => {
        window.location.href = "/Profile/userinfo";
      }, 2000);
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
                  <label class="form-label">OTTP Code </label>
                  <input
                    name="Code"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                    aria-describedby="emailHelp"
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
