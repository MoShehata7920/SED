import React, {  useState } from "react";
import "./Signin.css";
import { Link} from "react-router-dom";
import axios from "axios";


  
function Signin(){
 
 
  const[user,setuser]=useState({
    
    password:"",
    email:""
})

function getuserinfo(e){

    let myuser={...user};
    myuser[e.target.name]=e.target.value;
    setuser(myuser)
}

async function usersubmit(e){
    e.preventDefault()
    let request = await axios.post('http://103.48.193.225:9000/customers/login',user);
    localStorage.getItem("usertoken",request.data.token)
   
}

  
    return (

      <>
      <div className="login-box">
      <h2>Welcom Back!</h2>
      <form onSubmit={usersubmit}>
        <div className="user-box">
          <input type="text" name="email" onChange={getuserinfo}/>
          <label>Email</label>
        </div>
        <div className="user-box">
          <input type="password" name="password" onChange={getuserinfo}/>
          <label>Password</label>
          
        </div>
     
        <div className="login">
        <button type="submit">login </button>
        </div>
        <div className="signup">
          <p>Don't Have Account? <Link to={'/'}><a href="{}"> Signup </a></Link></p>
        </div>
        <div className="forgetpass">
          <p> <Link to={'/forgetpassword'}><a href="{}"> Forget Password?  </a></Link></p>
        </div>
  
      </form>
      </div>
     
   
      </>
    )
}
export default Signin;

