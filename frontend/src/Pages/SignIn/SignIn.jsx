import "./SignIn.css";
import { FcGoogle } from "react-icons/fc";
import {
  MDBContainer,
  MDBCol,
  MDBRow,
  MDBBtn,
  MDBInput,
} from "mdb-react-ui-kit";
import { Icon } from "react-icons-kit";
import { eyeOff } from "react-icons-kit/feather/eyeOff";
import { eye } from "react-icons-kit/feather/eye";
import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import Navebar from "../../Component/navebar/navbar";
import { ToastContainer, toast } from "react-toastify";
import { encrypt } from "n-krypta";
import { UseAxiosPost } from "../../Component/axios/PostApi/PostApi";
// import { GoogleLogin } from "@react-oauth/google";
function SignIn() {
  const navigate = useNavigate();
  const [tokengoogle, settokengoogle] = useState("");
  console.log("this is token", tokengoogle);

  const secret = process.env.REACT_APP_SECRET_KEY;
  const postAPi = "/auth/login";
  const [user, setuser] = useState({
    password: "",
    loginOption: "",
  });
  const [type, setType] = useState("password");
  const [icon, setIcon] = useState(eyeOff);
  const { response, data, ErrorMessage, HandelPostApi } = UseAxiosPost(
    postAPi,
    user
  );
  let Token = data ? data.token : null;
  function getuserinfo(e) {
    let myuser = { ...user };
    myuser[e.target.name] = e.target.value;
    setuser(myuser);
  }
  const handleToggle = () => {
    if (type === "password") {
      setIcon(eye);
      setType("text");
    } else {
      setIcon(eyeOff);
      setType("password");
    }
  };
  const usersubmit = (e) => {
    e.preventDefault();
    HandelPostApi();
  };
  const google = () => {
    window.open("http://sednow.site:3000/auth/google", "_self");
  };

  useEffect(() => {
    const urlParams = new URLSearchParams(window.location.search);
    const token = urlParams.get("token");
    settokengoogle(token);
    if (tokengoogle) {
      const encryptedData = encrypt(tokengoogle, secret);
      localStorage.setItem("encryptedToken", encryptedData);
      navigate("/");
    }
    if (data) {
      const encryptedData = encrypt(Token, secret);
      localStorage.setItem("encryptedToken", encryptedData);
      navigate("/");
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [response, data, ErrorMessage, tokengoogle]);

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

            <MDBCol col="4" md="6">
              <div className="d-flex flex-row align-items-center justify-content-center">
                <p className="lead fw-normal mb-0 me-3">Sign in with</p>
                <div>
                  <Link onClick={google} className="bg-white fs-4">
                    <FcGoogle />
                  </Link>
                </div>
              </div>

              <div className="divider d-flex align-items-center my-4">
                <p className="text-center fw-bold mx-3 mb-0">Or</p>
              </div>
              <form onSubmit={usersubmit}>
                <MDBInput
                  wrapperClass="mb-4"
                  onChange={getuserinfo}
                  label="Email address"
                  id="email"
                  type="email"
                  name="loginOption"
                  size="lg"
                />
                <div className=" position-relative ">
                  <MDBInput
                    wrapperClass="mb-4"
                    onChange={getuserinfo}
                    label="Password"
                    id="Password"
                    type={type}
                    name="password"
                    size="lg"
                  />
                  <span className=" icon-container " onClick={handleToggle}>
                    <Icon icon={icon} size={25} />
                  </span>
                </div>
                <div className="text-center text-md-start mt-4 pt-2">
                  <div>
                    <button
                      type="submit"
                      className="  btn btn-primary  py-2 px-5"
                      size="lg"
                    >
                      Login
                    </button>
                  </div>
                  <div className="d-flex justify-content-between mb-4 mt-4">
                    <Link
                      className=" text-decoration-none"
                      to={"/forgetpassword"}
                    >
                      Forgot password?
                    </Link>
                  </div>
                  <p className="small fw-bold mt-2  mb-2">
                    Don't have an account?{" "}
                    <Link to={"/SignUp"} className="link-danger">
                      Register
                    </Link>
                  </p>
                </div>
                <ToastContainer />
              </form>
            </MDBCol>
          </MDBRow>
        </MDBContainer>
      </section>
    </>
  );
}

export default SignIn;
