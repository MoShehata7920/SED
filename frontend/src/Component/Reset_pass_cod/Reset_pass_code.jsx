import React, { useEffect, useState } from "react";
import Navebar from "../../Component/navebar/navbar";
import { UseAxiosPost } from "../../Component/axios/PostApi/PostApi";
import { ToastContainer, toast } from "react-toastify";
import { encrypt } from "n-krypta";
import {
  MDBContainer,
  MDBCol,
  MDBRow,
  MDBBtn,
  MDBIcon,
  MDBInput,
} from "mdb-react-ui-kit";
function Reset_pass_code() {
  const secret = process.env.REACT_APP_SECRET_KEY;
  const [Reset_code, setReset_codel] = useState({
    code: "",
  });
  const postAPi = "/auth/resetOTP";

  console.log(Reset_code);
  function getiteminfo(e) {
    let myuser = { ...Reset_code };
    myuser[e.target.name] = e.target.value;
    setReset_codel(myuser);
  }
  const { response, data, ErrorMessage, HandelPostApi } = UseAxiosPost(
    postAPi,
    Reset_code
  );
  let token = data ? data.token : null;
  const itemsubmit = (e) => {
    e.preventDefault();
    HandelPostApi();
  };
  useEffect(() => {
    if (data) {
      const encryptedData = encrypt(token, secret);
      localStorage.setItem("encryptedToken", encryptedData);
    }
    if (response) {
      toast(`✔️ ${response} `);
      setTimeout(() => {
        window.location.href = `/Reset_Password`;
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [data, response, ErrorMessage]);
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
                  label=" RESET_CODE"
                  id="formControlLg"
                  type="text"
                  name="code"
                  size="lg"
                />
                <div className="text-center text-md-start mt-4 pt-2">
                  <div>
                    <MDBBtn type="submit" className="  mb-0 px-5" size="lg">
                      RESET
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
export default Reset_pass_code;
