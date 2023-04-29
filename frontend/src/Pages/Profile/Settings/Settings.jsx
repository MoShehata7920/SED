import "./Settings.css";
import React from "react";

export default function Settings() {
  return (
    <>
    <div className="container py-3 text-center">
      <div className="row justify-content-center text-center ">
        <div className="col-lg-5">
            <div class="list-group py-5 mt-1 setting-list">
                  <button type="button" class="list-group-item list-group-item-action  ">  My Account </button>
                  <button type="button" class="list-group-item list-group-item-action  mt-3 ">My Adds </button>
                  <button type="button" class="list-group-item list-group-item-action  mt-3 ">Langages</button>
                  <button type="button" class="list-group-item list-group-item-action  mt-3 ">Themes</button>
                  <button type="button" class="list-group-item list-group-item-action  mt-3 " >Notification</button>
                  <button type="button" class="list-group-item list-group-item-action  mt-3 " >Share</button>
                  <button type="button" class="list-group-item list-group-item-action  mt-3 " >Help</button>
                  <button type="button" class="list-group-item list-group-item-action  mt-3 " >About us</button>
            </div>                      
        </div>
      </div>
    </div>
     
    </>
  );
}
