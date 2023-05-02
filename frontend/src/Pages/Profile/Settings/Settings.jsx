import { Link } from "react-router-dom";
import "./Settings.css";
import React from "react";

export default function Settings() {
  return (
    <>
      <div className="container py-3 text-center">
        <div className="row justify-content-center text-center mt-3">
          <div className="setting-container col-lg-8 col-sm-12 d-flex  rounded-5   justify-content-center">
            <div className=" list-group col-4 py-5 m-5 setting-list ">
              <button type="button" className=" w-75  p-1 rounded-0">
                <Link
                  className="text-decoration-none"
                  to={"/Profile/settings/myadds"}
                >
                  My Adds
                </Link>{" "}
              </button>
              <button type="button" className="w-75 mt-5 p-1 rounded-0">
                <Link
                  className="text-decoration-none"
                  to={"/Profile/settings/themes"}
                >
                  Themes
                </Link>
              </button>
            </div>
            <div class="list-group col-4  py-5 m-5 setting-list ">
              <button type="button" className="w-75  p-1 rounded-0 ">
                <Link
                  className="text-decoration-none"
                  to={"/Profile/settings/notification"}
                >
                  Notification
                </Link>
              </button>
              <button type="button" className="w-75 mt-5 p-1 rounded-0">
                <Link
                  className="text-decoration-none"
                  to={"/Profile/settings/share"}
                >
                  Share
                </Link>
              </button>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
