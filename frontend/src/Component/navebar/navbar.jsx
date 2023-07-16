import "./navbar.css";
import { CiUser } from "react-icons/ci";
import { BiLogIn } from "react-icons/bi";
import { BiLogOut } from "react-icons/bi";
import { Link, useNavigate } from "react-router-dom";
import { useEffect, useState } from "react";
import { BsChatTextFill } from "react-icons/bs";
import { getTokendeta } from "../axios/tokendata/Token_Data";
import NavDropdown from "react-bootstrap/NavDropdown";

function Navebar() {
  let [SearchData, setSearchData] = useState("");
  const [error, setError] = useState(null);
  const Tokendata = getTokendeta();
  const isAdmin = Tokendata ? Tokendata.isAdmin : "";
  const userID = Tokendata ? Tokendata.id : "";
  console.log(Tokendata);
  const storedToken = localStorage.getItem("encryptedToken");
  function logout() {
    localStorage.removeItem("encryptedToken");
    window.location.href("/");
  }
  const navigate = useNavigate();
  const handleSubmit = (event) => {
    event.preventDefault();
    try {
      navigate({
        pathname: "/search",
        search: `?query=${SearchData}`,
        replace: true,
      });
    } catch (error) {
      setError(error);
    }
  };
  return (
    <>
      <nav className="navbar navbar-expand-lg  pt-4 pb-4 bg-nav">
        <div className=" container-fluid">
          <div className="ms-4 col-xl-2 col-lg-1 col-xxl-3 col-md-2 col-sm-8 col-8">
            <Link className="navbar-brand text-white fs-3" to={"/"}>
              SED
            </Link>
          </div>
          <div className="">
            <button
              className="navbar-toggler bg-white"
              type="button"
              data-bs-toggle="collapse"
              data-bs-target="#navbarSupportedContent"
              aria-controls="navbarSupportedContent"
              aria-expanded="false"
              aria-label="Toggle navigation"
            >
              <span className="navbar-toggler-icon"></span>
            </button>
          </div>
          <div
            className="collapse navbar-collapse col-5 me-4"
            id="navbarSupportedContent"
          >
            <ul className="navbar-nav me-auto mb-2   mb-lg-0 ">
              <NavDropdown title="Category" id="nav-dropdown">
                <li>
                  <Link
                    className="dropdown-item "
                    to={"/Categories/Electronics"}
                  >
                    Electronics
                  </Link>
                </li>
                <li>
                  <Link to={"/Categories/Fashion"} className="dropdown-item ">
                    Fashion
                  </Link>
                </li>
                <li>
                  <Link className="dropdown-item " to={"/Categories/Furniture"}>
                    Furniture
                  </Link>
                </li>
                <li>
                  <Link className="dropdown-item " to={"/Categories/Sports"}>
                    Sports
                  </Link>
                </li>
                <li>
                  <Link
                    className="dropdown-item "
                    to={"/Categories/Supermarket"}
                  >
                    Supermarket
                  </Link>
                </li>
                <li>
                  <Link className="dropdown-item " to={"/Categories/Vehicles"}>
                    Vehicles
                  </Link>
                </li>
                <li>
                  <Link className="dropdown-item " to={"/Categories/Others"}>
                    Other
                  </Link>
                </li>
                <li>
                  <Link
                    className="dropdown-item "
                    to={"/Categories/Phones&Tablets"}
                  >
                    Phones&Tablets
                  </Link>
                </li>
                <li>
                  <Link
                    className="dropdown-item "
                    to={"/Categories/Body&HealthCare"}
                  >
                    Body&HealthCare
                  </Link>
                </li>
              </NavDropdown>
              <NavDropdown title="Services" id="nav-dropdown">
                <li>
                  <Link
                    to={"/SeeAllData/sell"}
                    className="dropdown-item text-black"
                  >
                    SELL
                  </Link>
                </li>
                <li>
                  <Link
                    to={"/SeeAllData/exchange"}
                    className="dropdown-item text-black"
                  >
                    EXCHANGE
                  </Link>
                </li>
                <li>
                  <Link
                    to={"/SeeAllData/donate"}
                    className="dropdown-item text-black"
                  >
                    DONAT
                  </Link>
                </li>
              </NavDropdown>

              <NavDropdown title="BrandStore" id="nav-dropdown"></NavDropdown>
            </ul>

            <form onSubmit={handleSubmit} className="d-flex" role="search">
              <div className="input-group me-3">
                <input
                  type="text"
                  aria-label="First name"
                  className="form-control"
                  placeholder="Search . . ."
                  value={SearchData}
                  onChange={(event) => setSearchData(event.target.value)}
                />
                <button
                  className="btn btn-outline-success text-white"
                  type="submit"
                >
                  Search
                </button>
              </div>
            </form>
            {storedToken && isAdmin == false ? (
              <ul className="navbar-nav  pb-3">
                <li className="nav-item ">
                  <Link
                    to={`/Profile/myProduct/${userID}`}
                    className="text-white nav-Link fs-2 me-4 "
                  >
                    <CiUser />
                  </Link>
                  <Link to={"/Chat"} className="text-white nav-Link fs-2 me-4">
                    <BsChatTextFill />
                  </Link>
                  <Link
                    onClick={() => {
                      logout();
                    }}
                    to={"/"}
                    className="text-white nav-Link fs-2   "
                  >
                    <BiLogOut />
                  </Link>
                </li>
              </ul>
            ) : null}
            {storedToken && isAdmin == true ? (
              <ul className="navbar-nav  pb-3">
                <li className="nav-item ">
                  <Link
                    to={`/Admin/UsersInfo`}
                    className="text-white nav-Link fs-2 me-4 "
                  >
                    <CiUser />
                  </Link>

                  <Link
                    onClick={() => {
                      logout();
                    }}
                    to={"/"}
                    className="text-white nav-Link fs-2   "
                  >
                    <BiLogOut />
                  </Link>
                </li>
              </ul>
            ) : null}
            {storedToken ? null : (
              <ul className="navbar-nav ">
                <li className="nav-item">
                  <Link
                    to={"/SignIn"}
                    className="text-white nav-Link fs-1 d-flex align-items-center justify-content-center "
                  >
                    <BiLogIn />
                  </Link>
                </li>
              </ul>
            )}
          </div>
        </div>
      </nav>
    </>
  );
}
export default Navebar;
