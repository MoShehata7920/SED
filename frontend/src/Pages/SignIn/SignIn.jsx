import "./SignIn.css";
import { Fragment, useState } from "react";

function SignIn() {
  const [Email, setEmail] = useState("");
  const handleEmailChange = (event) => {
    setEmail(event.target.value);
    console.log("", event.target.value);
  };

  const [Password, setPassword] = useState("");
  const handlePassChange = (event) => {
    setPassword(event.target.value);
    console.log("", event.target.value);
  };
  const handleisClick = () => {
    console.log("valu is:", Password);
    console.log("valu is:", Email);
  };
  return (
    <div className="container">
      <div className="content">
        <h1>Log In</h1>
        <div className="inputbox">
          <input onChange={handleEmailChange} type="text" />
          <span>Email</span>
        </div>
        <div className="inputbox">
          <input onChange={handlePassChange} type="text" required="required" />
          <span>Password</span>
        </div>
        <button
          onClick={() => {
            handleisClick();
          }}
          className="button1"
        >
          Login
        </button>
      </div>
      <div className="image">
        <img
          src="https://images.pexels.com/photos/4482900/pexels-photo-4482900.jpeg?auto=compress&cs=tinysrgb&w=600"
          alt=""
        />
      </div>
    </div>
  );
}

export default SignIn;
