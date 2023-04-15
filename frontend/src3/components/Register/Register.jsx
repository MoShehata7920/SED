import React, { useState } from "react";
import "./Register.css";
import axios from "axios";
import { Link , useNavigate } from "react-router-dom";
import { FcGoogle } from "react-icons/fc";




function Register(){
    const navigate=useNavigate()
    const[user,setuser]=useState({
        username:"",
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
        let request = await axios.post('http://103.48.193.225:9000/customers/register',user);
        localStorage.setItem("usertoken",request.data.token)
        navigate('/home')
    }

    return(
        <>
       <div className="login-box">
       <h2> Create My Account </h2>
      <form onSubmit={usersubmit}>
      <div className="user-box">
            <input type="text" name="username" onChange={getuserinfo}/>
            <label>User Name </label>
            </div>
            <div className="user-box">
            <input type="text" name="email" onChange={getuserinfo}/>
            <label>Email</label>
            </div>

            <div className="user-box">
            <input type="password" name="password" onChange={getuserinfo}/>
            <label>Password</label>
            </div>
        
            <div className="login">
            <button type="submit"> Signup </button>
            <button type="submit"> Signup with <i>{<FcGoogle/>}</i> </button>
            </div>

            <div className="signup">
            <p>Aready Have Account? <Link to={'/signin'}><a href="{}"> Signin </a></Link> </p>
            </div>

           
      </form>
      </div>
        </>
    )
}
export default Register;
