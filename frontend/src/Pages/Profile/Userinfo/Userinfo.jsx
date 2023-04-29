import "./Userinfo.css";
import React from "react";
import "./user.png";


export default function Userinfo() {
  return <>
<div className="container-lg py-3">
  <div className="row justify-content-center">
    <div className="col-lg-8">
      <div className="row  ">
        <div className="col-md-6  py-1  ">
          <div className="d-flex-row text-center justify-content-around ">
            <div className="col">
               <img src={require('./user.png')}  className="rounded  w-50 p-5" alt="user img" ></img>
            </div>
           
          </div>
        </div>
      </div>
 
    <div className="profile-user-info row py-1 d-flex  justify-content-center " >
              <div className="user-info row py-1">
                <h5 className="py-1 "> User Name </h5>
                <h6 className="w-75 row-sm-w-75"> </h6> 
              </div>
              <div className="user-info row py-1">
                <h5 className="py-1 ">Email </h5>
                <h6 className="w-75"> </h6> 
              </div>

              <div className=" user-info row py-1">
                <h5 className="py-1">Mobile Number </h5>
                <h6 className="w-75 "> </h6>   
              </div>

              <div className=" user-info row py-1">
                <h5 className="py-1">Location </h5>
                <h6 className="w-75"> </h6> 
              </div>

              <div className=" user-info row py-1">
                  <h5 className="py-1">Gender</h5>
                  <h6 className="w-75">  </h6>  
              </div>

              <div className=" user-info  row py-1">
                  <h5 className="py-1">Date Of Birth</h5>
                  <h6 className="w-75">  </h6>     
              </div>
    </div>
 
    </div>
  </div>


</div>
 
        
      
   </>;
}
