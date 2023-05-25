import "./SignIn.css";
import React, { useEffect, useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import Navebar from "../../Component/navebar/navbar";
import { encrypt } from "n-krypta";
import { UseAxiosPost } from "../../Component/axios/PostApi/PostApi";
function SignIn() {
  const navigate = useNavigate();
  const secret = process.env.REACT_APP_SECRET_KEY;
  const postAPi = "/auth/login";
  const [user, setuser] = useState({
    password: "",
    loginOption: "",
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
  }, [data]);

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
                <h2 className=" text-center">Welcom To SED</h2>
                <form onSubmit={usersubmit}>
                  <div class="form__group field">
                    <input
                      type="input"
                      class="form__field"
                      placeholder="Name"
                      name="loginOption"
                      id="loginOption"
                      required
                      onChange={getuserinfo}
                    />
                    <label for="loginOption" class="form__label">
                      Email
                    </label>
                  </div>
                  <div class="form__group field">
                    <input
                      type="input"
                      class="form__field"
                      placeholder="Password"
                      name="password"
                      onChange={getuserinfo}
                      id="password"
                      required
                    />
                    <label for="loginOption" class="form__label">
                      Password
                    </label>
                  </div>

                  <div className="login">
                    <button type="submit">login </button>
                  </div>
                  <div className="signup">
                    <p>
                      Don't Have Account?{" "}
                      <Link to={"/SignUp"}>
                        <a href="{}"> Signup </a>
                      </Link>
                    </p>
                  </div>
                  <div className="forgetpass">
                    <p>
                      {" "}
                      <Link to={"/forgetpassword"}>
                        <a href="{}"> Forget Password? </a>
                      </Link>
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

export default SignIn;
