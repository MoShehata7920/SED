import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { UseAxiosPost } from "../axios/PostApi/PostApi";
import {
  MDBContainer,
  MDBCol,
  MDBRow,
  MDBBtn,
  MDBInput,
} from "mdb-react-ui-kit";
import Navebar from "../navebar/navbar";
import { useNavigate } from "react-router-dom";
export default function Email_verfication() {
  const navigate = useNavigate();
  const [Email, setEmail] = useState({
    email: "",
  });
  const postAPi = `/auth/resendVerifyEmail`;
  function getUserinfo(e) {
    let myuser = { ...Email };
    myuser[e.target.name] = e.target.value;
    setEmail(myuser);
  }

  const { response, ErrorMessage, HandelPostApi } = UseAxiosPost(
    postAPi,
    Email
  );
  async function itemsubmit(e) {
    e.preventDefault();
    HandelPostApi();
  }

  useEffect(() => {
    if (response) {
      toast(`✔️ ${response} `);
      setTimeout(() => {
        navigate("/Email_verfication_code");
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
                  label=" Email"
                  id="email"
                  type="email"
                  name="email"
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
