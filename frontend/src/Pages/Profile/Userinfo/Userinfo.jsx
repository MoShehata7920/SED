import "./Userinfo.css";
import React from "react";
import "./user.png";


export default function Userinfo() {
  return <>
<div className="container px-1">
  <div className="row justify-content-center col-xs-12">
    <div className="col-lg-8   border border-dark rounded bg-primary rounded-3 mt-5  ">
      
      <div className="row  ">
       
      </div>
     <div className="d-flex py-3 ">
          <div className="profile-user-info row py-3  px-1 justify-content-center " >
                    <div className="user-info row py-3">
                      <h5 className="py-1 "> User Name  </h5>
                      <h6 className="w-75 bg-primary"> mohamed adel </h6> 
                    </div>
                    <div className="user-info row py-3">
                      <h5 className="py-1 ">Email </h5>
                      <h6 className="w-75 bg-primary"> ahmen1999@gami.com</h6> 
                    </div>

                    <div className=" user-info row py-3">
                      <h5 className="py-1">Mobile Number </h5>
                      <h6 className="w-75 bg-primary ">01115572758</h6>   
                    </div>
          </div>
          <div className="profile-user-info row py-3  px-1 justify-content-center " >
                    <div className=" user-info row py-3">
                      <h5 className="py-1">Location </h5>
                      <h6 className="w-100  bg-primary">tanta </h6> 
                    </div>

                    <div className=" user-info row py-3">
                        <h5 className="py-1">Gender</h5>
                        <h6 className="w-100  bg-primary">male </h6>  
                    </div>

                    <div className=" user-info  row py-3">
                        <h5 className="py-1">Date Of Birth</h5>
                        <h6 className="w-100  bg-primary"> 17/6/1999</h6>     
                    </div>
          </div>
     </div>
    </div>
  </div>
</div>
 
        
      
   </>;
}
