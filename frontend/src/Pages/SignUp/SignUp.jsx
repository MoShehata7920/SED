import React, { useState } from "react";
import "./SignUp.css";
import axios from "axios";
import { Link, useNavigate } from "react-router-dom";
import { FcGoogle } from "react-icons/fc";
import Navebar from "../../Component/navebar/navbar";

function Register() {
  const navigate = useNavigate();
  const [user, setuser] = useState({
    fullName: "",
    password: "",
    confirmPassword: "",
    email: "",
    phone: "",
  });

  function getuserinfo(e) {
    let myuser = { ...user };
    myuser[e.target.name] = e.target.value;
    setuser(myuser);
  }

  async function usersubmit(e) {
    e.preventDefault();
    let request = await axios.post(
      "http://103.48.193.225:3000/auth/register ",
      user
    );
    localStorage.setItem("usertoken", request.data.token);
    navigate("/");
  }

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
