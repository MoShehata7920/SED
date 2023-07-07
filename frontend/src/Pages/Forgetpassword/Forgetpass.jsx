import React, { useEffect, useState } from "react";
import "./Forgetpass.css";
import {
  MDBContainer,
  MDBCol,
  MDBRow,
  MDBBtn,
  MDBIcon,
  MDBInput,
} from "mdb-react-ui-kit";
import Navebar from "../../Component/navebar/navbar";
import { UseAxiosPost } from "../../Component/axios/PostApi/PostApi";
import { ToastContainer, toast } from "react-toastify";
import { Link } from "react-router-dom";

function Forgetpass() {
  const [Email, setEmail] = useState({
    searchOption: "",
  });
  const postAPi = "/auth/forgotOTP";
  console.log(Email);
  function getiteminfo(e) {
    let myuser = { ...Email };
    myuser[e.target.name] = e.target.value;
    setEmail(myuser);
  }
  const { response, data, ErrorMessage, HandelPostApi } = UseAxiosPost(
    postAPi,
    Email
  );
  const itemsubmit = (e) => {
    e.preventDefault();
    HandelPostApi();
  };
  useEffect(() => {
    if (response) {
      toast(`✔️ ${response} `);
      setTimeout(() => {
        window.location.href = "/Reset_pass_code";
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [response, ErrorMessage]);
  return (
    <>
      <section className="mb-5">
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
                  onChange={getiteminfo}
                  label="Email address"
                  id="formControlLg"
                  type="email"
                  name="searchOption"
                  size="lg"
                />
                <div className="text-center text-md-start mt-4 pt-2">
                  <div>
                    <MDBBtn type="submit" className="  mb-0 px-5" size="lg">
                      Send Code
                    </MDBBtn>
                  </div>
                </div>
              </form>
            </MDBCol>
            <ToastContainer />
          </MDBRow>
        </MDBContainer>
      </section>
    </>
  );
}
export default Forgetpass;
