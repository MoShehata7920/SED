import "./navbar.css";
import { CiUser } from "react-icons/ci";
import { NavLink } from "react-router-dom";
function Navebar() {
  return (
    <>
      <nav className="navbar navbar-expand-lg  pt-4 pb-4 bg-nav">
        <div className="container">
          <div className="col-xl-2 col-lg-1 col-xxl-3 col-md-2 col-sm-10 col-10">
            <NavLink className="navbar-brand text-white fs-3" to={"/"}>
              SED
            </NavLink>
          </div>
          <div className="  col-">
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
            className="collapse navbar-collapse col-5"
            id="navbarSupportedContent"
          >
            <ul className="navbar-nav me-auto mb-2 mb-lg-0 ">
              <li className="nav-item dropdown ">
                <NavLink
                  className="nav-NavLink dropdown-toggle text-white fs-4 "
                  to={"a"}
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  Categories
                </NavLink>
                <ul className="dropdown-menu ">
                  <li>
                    <NavLink className="dropdown-item " to={"a"}>
                      Action
                    </NavLink>
                  </li>
                  <li>
                    <NavLink className="dropdown-item " to={"a"}>
                      Another action
                    </NavLink>
                  </li>
                  <li>
                    <NavLink className="dropdown-item " to={"a"}>
                      Something else here
                    </NavLink>
                  </li>
                </ul>
              </li>
              <li className="nav-item dropdown">
                <NavLink
                  className="nav-NavLink dropdown-toggle text-white fs-4 ms-2 me-2"
                  to={"a"}
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  Services
                </NavLink>
                <ul className="dropdown-menu">
                  <li>
                    <NavLink className="dropdown-item text-black" to={"a"}>
                      SELL
                    </NavLink>
                  </li>
                  <li>
                    <NavLink className="dropdown-item text-black" to={"a"}>
                      EXCHANGE
                    </NavLink>
                  </li>
                  <li>
                    <NavLink className="dropdown-item text-black" to={"a"}>
                      DONAT
                    </NavLink>
                  </li>
                </ul>
              </li>
              <li className="nav-item">
                <NavLink className="nav-NavLink text-white fs-4" to={"a"}>
                  Brand Stores
                </NavLink>
              </li>
            </ul>
            <form className="d-flex" role="search">
              <div className="input-group me-5">
                <input
                  type="text"
                  aria-label="First name"
                  className="form-control"
                  placeholder="Search . . ."
                />
                <button
                  className="btn btn-outline-success text-white"
                  type="submit"
                >
                  Search
                </button>
              </div>
            </form>
            <ul className="navbar-nav ">
              <li className="nav-item">
                <NavLink
                  to={"SignIn"}
                  className="text-white nav-NavLink fs-1 d-flex align-items-center justify-content-center "
                >
                  <CiUser />
                </NavLink>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </>
  );
}
export default Navebar;
