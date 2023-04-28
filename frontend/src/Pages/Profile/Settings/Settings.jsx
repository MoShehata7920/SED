import "./Settings.css";
import React from "react";
import {
  BiBell,
  BiPalette,
  BiWorld,
  BiSupport,
  BiUserCircle,
  BiShareAlt,
  BiCloset,
} from "react-icons/bi";
import { FiInfo } from "react-icons/fi";
import { Link } from "react-router-dom";
export default function Settings() {
  return (
    <>
      <section className=" bg-dark ">
        <div className=" container">
          <div className="row">
            <div className="col-xl-6 col-lg-12 settings">
              {" "}
              <ul>
                <li>
                  <button>
                    <Link to={"/Profile/settings/myaccount"}>
                      <i>{<BiUserCircle />}</i> My Account{" "}
                    </Link>{" "}
                  </button>
                </li>
                <li>
                  <button>
                    <Link to={""}>
                      <i>{<BiCloset />}</i> My Adds{" "}
                    </Link>
                  </button>
                </li>
                <li>
                  <button>
                    <Link>
                      <i>{<BiWorld />}</i> Languages
                    </Link>{" "}
                  </button>
                </li>
                <li>
                  <button>
                    <Link to={""}>
                      {" "}
                      <i>{<BiPalette />}</i>Themes
                    </Link>{" "}
                  </button>
                </li>
              </ul>
            </div>
            <div className="col-xl-6 col-lg-12 settings">
              <ul>
                <li>
                  <button>
                    {" "}
                    <Link to={""}>
                      {" "}
                      <i>{<BiBell />}</i> Notification
                    </Link>{" "}
                  </button>
                </li>
                <li>
                  <button>
                    <Link to={""}>
                      {" "}
                      <i>{<BiShareAlt />}</i> Share
                    </Link>
                  </button>
                </li>
                <li>
                  <button>
                    <Link to={""}>
                      {" "}
                      <i>{<BiSupport />}</i>Help
                    </Link>{" "}
                  </button>
                </li>
                <li>
                  <button>
                    {" "}
                    <Link to={""}>
                      {" "}
                      <i>{<FiInfo />}</i>About us{" "}
                    </Link>
                  </button>
                </li>
              </ul>
            </div>
          </div>
        </div>
      </section>
      {/* <div className="settings-cointener">
        <div className="settings">
          <div>
            <ul>
              <li>
                <button>
                  <Link to={"/Profile/settings/myaccount"}>
                    <i>{<BiUserCircle />}</i> My Account{" "}
                  </Link>{" "}
                </button>
              </li>
              <li>
                <button>
                  <Link to={""}>
                    <i>{<BiCloset />}</i> My Adds{" "}
                  </Link>
                </button>
              </li>
              <li>
                <button>
                  <Link>
                    <i>{<BiWorld />}</i> Languages
                  </Link>{" "}
                </button>
              </li>
              <li>
                <button>
                  <Link to={""}>
                    {" "}
                    <i>{<BiPalette />}</i>Themes
                  </Link>{" "}
                </button>
              </li>
            </ul>
          </div>
          <div>
            <ul>
              <li>
                <button>
                  {" "}
                  <Link to={""}>
                    {" "}
                    <i>{<BiBell />}</i> Notification
                  </Link>{" "}
                </button>
              </li>
              <li>
                <button>
                  <Link to={""}>
                    {" "}
                    <i>{<BiShareAlt />}</i> Share
                  </Link>
                </button>
              </li>
              <li>
                <button>
                  <Link to={""}>
                    {" "}
                    <i>{<BiSupport />}</i>Help
                  </Link>{" "}
                </button>
              </li>
              <li>
                <button>
                  {" "}
                  <Link to={""}>
                    {" "}
                    <i>{<FiInfo />}</i>About us{" "}
                  </Link>
                </button>
              </li>
            </ul>
          </div>
        </div>
      </div> */}
    </>
  );
}
