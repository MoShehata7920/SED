import React, { useEffect, useState } from "react";
import "./SignUp.css";
import {
  MDBContainer,
  MDBCol,
  MDBRow,
  MDBBtn,
  MDBIcon,
  MDBInput,
} from "mdb-react-ui-kit";
import { Icon } from "react-icons-kit";
import { eyeOff } from "react-icons-kit/feather/eyeOff";
import { eye } from "react-icons-kit/feather/eye";
import { ToastContainer, toast } from "react-toastify";
import { Link, useNavigate } from "react-router-dom";
import Navebar from "../../Component/navebar/navbar";
import { encrypt } from "n-krypta";
import { UseAxiosPost } from "../../Component/axios/PostApi/PostApi";
function Register() {
  const navigate = useNavigate();
  const secret = process.env.REACT_APP_SECRET_KEY;
  const postAPi = "/auth/register";
  const [user, setuser] = useState({
    fullName: "",
    password: "",
    confirmPassword: "",
    email: "",
    phone: "",
  });
  const [type, setType] = useState("password");
  const [icon, setIcon] = useState(eyeOff);
  const { response, data, ErrorMessage, HandelPostApi } = UseAxiosPost(
    postAPi,
    user
  );
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
  useEffect(() => {
    if (data) {
      const encryptedData = encrypt(data, secret);
      localStorage.setItem("encryptedToken", encryptedData);
      navigate("/Email_verfication_code");
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [data, ErrorMessage]);
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
              <div className="d-flex flex-row align-items-center justify-content-center mb-4">
                <p className="lead fw-bold mb-0 me-3">Sign Up </p>
              </div>
              <form onSubmit={usersubmit}>
                <MDBInput
                  wrapperClass="mb-4"
                  onChange={getuserinfo}
                  label="full Name"
                  id="formControlLg"
                  type="text"
                  name="fullName"
                  size="lg"
                />
                <MDBInput
                  wrapperClass="mb-4"
                  onChange={getuserinfo}
                  label="Email address"
                  id="formControlLg"
                  type="email"
                  name="email"
                  size="lg"
                />
                <MDBInput
                  wrapperClass="mb-4"
                  onChange={getuserinfo}
                  label="Phone Number"
                  id="formControlLg"
                  type="text"
                  name="phone"
                  size="lg"
                />
                <div className=" position-relative ">
                  <MDBInput
                    wrapperClass="mb-4"
                    onChange={getuserinfo}
                    label="Password"
                    id="formControlLg"
                    type={type}
                    name="password"
                    size="lg"
                  />
                  <span className=" icon-container " onClick={handleToggle}>
                    <Icon icon={icon} size={25} />
                  </span>
                </div>
                <div className=" position-relative ">
                  <MDBInput
                    wrapperClass="mb-4"
                    onChange={getuserinfo}
                    label="Confirm Password"
                    id="formControlLg"
                    type={type}
                    name="confirmPassword"
                    size="lg"
                  />
                  <span className=" icon-container " onClick={handleToggle}>
                    <Icon icon={icon} size={25} />
                  </span>
                </div>

                <div className="text-center text-md-start mt-4 pt-2">
                  <div>
                    <MDBBtn type="submit" className="  mb-0 px-5" size="lg">
                      Sign Up
                    </MDBBtn>
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
                    have an account?{" "}
                    <Link to={"/SignIn"} className="link-danger">
                      Log In
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
export default Register;
