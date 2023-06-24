import React, { useEffect, useState } from "react";
import "./SignUp.css";
import { ToastContainer, toast } from "react-toastify";

import { Link, useNavigate } from "react-router-dom";
import { FcGoogle } from "react-icons/fc";
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
  const { response, data, ErrorMessage, HandelPostApi } = UseAxiosPost(
    postAPi,
    user
  );
  function getuserinfo(e) {
    let myuser = { ...user };
    myuser[e.target.name] = e.target.value;
    setuser(myuser);
  }
  const usersubmit = (e) => {
    e.preventDefault();
    HandelPostApi();
  };
  useEffect(() => {
    if (data) {
      const encryptedData = encrypt(data, secret);
      localStorage.setItem("encryptedToken", encryptedData);
      window.location.href = "/";
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
        <div className="container-fluid">
          <div className="row">
            <div className=" offset-xl-3 offset-lg-2 offset-md-1 offset-sm-0 col-xl-6 col-lg-8 col-md-10 col-sm-12 ">
              <div className=" Login_parent mt-5 mb-5">
                <h2 className=" text-center mb-0"> Create Your Account </h2>
                <form onSubmit={usersubmit}>
                  <div class="form__group field">
                    <input
                      type="input"
                      class="form__field"
                      placeholder="FullName"
                      name="fullName"
                      id="fullName"
                      required
                      onChange={getuserinfo}
                    />
                    <label for="fullName" class="form__label">
                      FullName
                    </label>
                  </div>
                  <div class="form__group field">
                    <input
                      type="email"
                      class="form__field"
                      placeholder="FullName"
                      name="email"
                      id="email"
                      required
                      onChange={getuserinfo}
                    />
                    <label for="fullName" class="form__label">
                      Email
                    </label>
                  </div>
                  <div class="form__group field">
                    <input
                      type="number"
                      class="form__field"
                      placeholder="Phone Number"
                      name="phone"
                      id="phone"
                      required
                      onChange={getuserinfo}
                    />
                    <label for="phone" class="form__label">
                      Phone Number
                    </label>
                  </div>
                  <div class="form__group field">
                    <input
                      type="password"
                      class="form__field"
                      placeholder="FullName"
                      name="password"
                      id="password"
                      required
                      onChange={getuserinfo}
                    />
                    <label for="password" class="form__label">
                      Password
                    </label>
                  </div>
                  <div class="form__group field">
                    <input
                      type="password"
                      class="form__field"
                      placeholder="FullName"
                      name="confirmPassword"
                      id="confirmPassword"
                      required
                      onChange={getuserinfo}
                    />
                    <label for="confirmPassword" class="form__label">
                      Confirm Password
                    </label>
                  </div>

                  <div className="login">
                    <button type="submit"> Signup </button>
                    <button type="submit">
                      {" "}
                      Signup with <i>{<FcGoogle />}</i>{" "}
                    </button>
                  </div>

                  <div className="signup">
                    <p>
                      Aready Have Account?{" "}
                      <Link to={"/signin"}>
                        <a href="{}"> Signin </a>
                      </Link>{" "}
                    </p>
                  </div>
                  <ToastContainer />
                </form>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}
export default Register;
