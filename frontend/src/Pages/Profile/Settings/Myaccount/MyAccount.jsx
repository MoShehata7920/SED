import React from "react";
import "./MyAccount.css";
import "./user.png";


function MyAccount() {
  return (
    <>
    <div className="container d-flex justify-content-center ">
      <div className="row justify-content-center mt-5   border border-dark w-75 ">
        <div className="col-10">
          <div className="row">

          </div>
          <div className="row d-flex ">
            <div className="col-5 m-3">
        
            <div class="mb-3">
                <label  class="form-label">user name </label>
                <input type="text" class="form-control"  aria-describedby="emailHelp"></input>
              </div>

              <div class="mb-3">
                <label class="form-label">Email </label>
                <input type="email" class="form-control" ></input>
              </div>

              <div class="mb-3">
                <label class="form-label">Password</label>
                <input type="password" class="form-control" ></input>
              </div>
            </div>
            <div className="col-5 m-3">

              
            <div class="mb-3">
                <label  class="form-label">Location </label>
                <input type="text" class="form-control" ></input>
              </div>

              <div class="mb-3 ">
              
                
              </div>

              <div class="mb-3">
                <label  class="form-label">date of birth </label>
                <input type="date" class="form-control" ></input>
              </div>

              <div class="mb-3">
                <label  class="form-label">mobile number  </label>
                <input type="text" class="form-control" ></input>
              </div>
              <div className="mb-3 d-flex justify-content-around ">
                <button type="button" class="btn btn-primary btn-sm ">Save Changes </button>
                <button type="button" class="btn btn-secondary btn-sm ">Cancel </button>
              </div>

            </div>
        
          </div>

        </div>

      </div>

    </div>
    
    </>
  );
}
export default MyAccount;
