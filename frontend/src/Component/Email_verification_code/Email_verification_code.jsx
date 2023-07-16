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
import { encrypt } from "n-krypta";
export default function Email_verfication_code() {
  const secret = process.env.REACT_APP_SECRET_KEY;
  const navigate = useNavigate();
  const [VerifyCode, setVerifyCode] = useState({
    code: "",
  });
  console.log(VerifyCode);
  const postAPi = `/auth/verifyemail`;
  async function getUserinfo(e) {
    let myuser = { ...VerifyCode };
    myuser[e.target.name] = e.target.value;
    setVerifyCode(myuser);
  }

  const { response, data, ErrorMessage, HandelPostApi } = UseAxiosPost(
    postAPi,
    VerifyCode
  );
  let Datatoken = data ? data.token : "";

  async function itemsubmit(e) {
    e.preventDefault();
    HandelPostApi();
  }

  useEffect(() => {
    if (response) {
      toast(`✔️ ${response} `);
      setTimeout(() => {
        const encryptedData = encrypt(Datatoken, secret);
        localStorage.setItem("encryptedToken", encryptedData);
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
    </>
  );
}
