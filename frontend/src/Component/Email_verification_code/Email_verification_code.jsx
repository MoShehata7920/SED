import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { UseAxiosPost } from "../axios/PostApi/PostApi";
import Navebar from "../navebar/navbar";
import {
  MDBContainer,
  MDBCol,
  MDBRow,
  MDBBtn,
  MDBInput,
} from "mdb-react-ui-kit";
import { useNavigate } from "react-router-dom";
export default function Email_verfication_code() {
  const navigate = useNavigate();
  const [Code, setCode] = useState({
    code: "",
  });
  const postAPi = `/auth/verifyemail`;
  function getUserinfo(e) {
    let myuser = { ...Code };
    myuser[e.target.name] = e.target.value;
    setCode(myuser);
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
        navigate("/");
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
        <MDBContainer fluid className="p-3 my-5 h-custom">
          <MDBRow>
            <MDBCol col="10" md="6">
              <img
                src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                class="img-fluid"
                alt="Sample image"
              />
            </MDBCol>

            <MDBCol className="mt-5" col="4" md="6">
              <form onSubmit={itemsubmit}>
                <MDBInput
                  wrapperClass="mb-4"
                  onChange={getUserinfo}
                  label=" Verified_CODE"
                  id="code"
                  type="text"
                  name="code"
                  size="lg"
                />
                <div className="text-center text-md-start mt-4 pt-2">
                  <div>
                    <button
                      type="submit"
                      className="  btn btn-primary  py-2 px-5"
                      size="lg"
                    >
                      Verified
                    </button>
                  </div>
                </div>
              </form>
            </MDBCol>
            <ToastContainer />
          </MDBRow>
        </MDBContainer>
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
                      name="code"
                      onChange={getUserinfo}
                      type="text"
                      class="form-control"
                      aria-describedby="emailHelp"
                    ></input>
                  </div>
                </div>
                <div className=" mb-3 mt-3 ms-4 d-flex justify-content-center  ">
                  <button type="submit" class="btn btn-primary  py-2 px-5 ">
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
