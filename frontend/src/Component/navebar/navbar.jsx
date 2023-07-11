import "./navbar.css";
import { CiUser } from "react-icons/ci";
import { BiLogIn } from "react-icons/bi";
import { BiLogOut } from "react-icons/bi";
import { Link, NavLink, useNavigate } from "react-router-dom";
import { useEffect, useState } from "react";
import { BsChatTextFill } from "react-icons/bs";

function Navebar() {
  let [SearchData, setSearchData] = useState("");
  const [error, setError] = useState(null);
  const storedToken = localStorage.getItem("encryptedToken");
  function logout() {
    localStorage.removeItem("encryptedToken");
    localStorage.removeItem("UserData");
    localStorage.removeItem("Productdata");
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
              className="navbar-toggler"
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
            <ul className="navbar-nav me-auto mb-2 mb-lg-0 ">
              <li className="nav-item dropdown me-2 ">
                <Link
                  className="nav-Link dropdown-toggle text-white fs-4 "
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  Categories
                </Link>
                <ul className="dropdown-menu ">
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
                    <Link
                      className="dropdown-item "
                      to={"/Categories/Furniture"}
                    >
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
                    <Link
                      className="dropdown-item "
                      to={"/Categories/Vehicles"}
                    >
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
                </ul>
              </li>
              <li className="nav-item dropdown me-2">
                <Link
                  className="nav-Link dropdown-toggle text-white fs-4 ms-2 me-2"
                  to={"a"}
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  Services
                </Link>
                <ul className="dropdown-menu">
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
                </ul>
              </li>
              <li className="nav-item">
                <Link className="nav-Link text-white fs-4" to={"a"}>
                  Brand Stores
                </Link>
              </li>
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
            {storedToken ? (
              <ul className="navbar-nav  pb-3">
                <li className="nav-item ">
                  <Link
                    to={"/Profile/userinfo"}
                    className="text-white nav-Link fs-1 me-4 "
                  >
                    <CiUser />
                  </Link>
                  <Link
                    onClick={() => {
                      logout();
                      window.location.reload();
                    }}
                    to={"/"}
                    className="text-white nav-Link fs-1   "
                  >
                    <BiLogOut />
                  </Link>
                </li>
                <li className="nav-item">
                  <Link
                    to={"/Chat"}
                    className="text-white chat-icon  nav-Link fs-2 d-flex align-items-center justify-content-center mx-3 mt-1 "
                  >
                    <BsChatTextFill />
                  </Link>
                </li>
              </ul>
            ) : (
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
