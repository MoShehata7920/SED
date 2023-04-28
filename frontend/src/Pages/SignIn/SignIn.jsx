import "./SignIn.css";

import React, { useState } from "react";
import { Link, useNavigate } from "react-router-dom";
import axios from "axios";

function SignIn() {
  const navigate = useNavigate();
  let [userdata, setuserdata] = useState([]);
  const [user, setuser] = useState({
    password: "",
    loginOption: "",
  });

  function getuserinfo(e) {
    let myuser = { ...user };
    myuser[e.target.name] = e.target.value;
    setuser(myuser);
  }

  async function usersubmit(e) {
    e.preventDefault();
    let request = await axios.post(
      "http://103.48.193.225:3000/auth/login",
      user
    );
    localStorage.setItem("usertoken", request.data.token);
    navigate("/");
  }
  // const [token, setToken] = useState("");
  // console.log(token);
  // useEffect(() => {
  //   const storedToken = localStorage.getItem("usertoken");
  //   if (storedToken) {
  //     setToken(storedToken);
  //   }
  // }, []);

  return (
    <>
      <div className="login-box">
        <h2>Welcom Back!</h2>
        <form onSubmit={usersubmit}>
          <div className="user-box">
            <input type="text" name="loginOption" onChange={getuserinfo} />
            <label>Email</label>
          </div>
          <div className="user-box">
            <input type="password" name="password" onChange={getuserinfo} />
            <label>Password</label>
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
    </>
  );
}

export default SignIn;
