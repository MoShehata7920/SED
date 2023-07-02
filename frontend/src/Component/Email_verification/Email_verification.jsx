import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { Link, useParams } from "react-router-dom";
import { UseAxiosPost } from "../axios/PostApi/PostApi";
import Navebar from "../navebar/navbar";
export default function Email_verfication() {
  const [Code, setCode] = useState("");
  console.log(Code);
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
      toast(`✔️ ${response} `);
      setTimeout(() => {
        window.location.href = "/";
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [response, ErrorMessage]);
  return (
    <>
      <section>
        <Navebar />
      </section>
      <section>
        <div className="container  ">
          <div className="row vh-100  flex-column align-items-center justify-content-center   ">
            <div className=" col-xxl-8 col-xl-8 col-lg-10 col-md-10 col-sm-12 col-12 rounded-3 border border-dark  pt-3 pb-3">
              <form
                onSubmit={itemsubmit}
                className="row mt-3 justify-content-center "
              >
                <div className=" col-4">
                  <div class="mb-3">
                    <label class="form-label">OTTP Code</label>
                    <input
                      name="Code"
                      onChange={getUserinfo}
                      type="text"
                      class="form-control"
                      aria-describedby="emailHelp"
                    ></input>
                  </div>
                </div>
                <div className=" mb-3 mt-3 ms-4 d-flex justify-content-center  ">
                  <button type="submit" class="btn btn-primary me-4 ">
                    Verified
                  </button>
                </div>
                <ToastContainer />
              </form>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}
