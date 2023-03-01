import "./navbar.css";
import { CiUser } from "react-icons/ci";
import { Link } from "react-router-dom";
function Navebar() {
  return (
    <>
      <nav class="navbar navbar-expand-lg  pt-4 pb-4 bg-nav">
        <div className="container">
          <div className="col-xl-2 col-lg-1 col-xxl-3 col-md-2 col-sm-10 col-10">
            <Link class="navbar-brand text-white fs-3" to={"/"}>
              SED
            </Link>
          </div>
          <div className="  col-">
            <button
              class="navbar-toggler"
              type="button"
              data-bs-toggle="collapse"
              data-bs-target="#navbarSupportedContent"
              aria-controls="navbarSupportedContent"
              aria-expanded="false"
              aria-label="Toggle navigation"
            >
              <span class="navbar-toggler-icon"></span>
            </button>
          </div>
          <div
            class="collapse navbar-collapse col-5"
            id="navbarSupportedContent"
          >
            <ul class="navbar-nav me-auto mb-2 mb-lg-0 ">
              <li class="nav-item dropdown ">
                <Link
                  class="nav-link dropdown-toggle text-white fs-4 "
                  to={"a"}
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  Categories
                </Link>
                <ul class="dropdown-menu ">
                  <li>
                    <Link class="dropdown-item " to={"a"}>
                      Action
                    </Link>
                  </li>
                  <li>
                    <Link class="dropdown-item " to={"a"}>
                      Another action
                    </Link>
                  </li>
                  <li>
                    <Link class="dropdown-item " to={"a"}>
                      Something else here
                    </Link>
                  </li>
                </ul>
              </li>
              <li class="nav-item dropdown">
                <Link
                  class="nav-link dropdown-toggle text-white fs-4 ms-2 me-2"
                  to={"a"}
                  role="button"
                  data-bs-toggle="dropdown"
                  aria-expanded="false"
                >
                  Services
                </Link>
                <ul class="dropdown-menu">
                  <li>
                    <Link class="dropdown-item text-black" to={"a"}>
                      SELL
                    </Link>
                  </li>
                  <li>
                    <Link class="dropdown-item text-black" to={"a"}>
                      EXCHANGE
                    </Link>
                  </li>
                  <li>
                    <Link class="dropdown-item text-black" to={"a"}>
                      DONAT
                    </Link>
                  </li>
                </ul>
              </li>
              <li class="nav-item">
                <Link class="nav-link text-white fs-4" to={"a"}>
                  Brand Stores
                </Link>
              </li>
            </ul>
            <form class="d-flex" role="search">
              <div class="input-group me-5">
                <input
                  type="text"
                  aria-label="First name"
                  class="form-control"
                  placeholder="Search . . ."
                />
                <button
                  class="btn btn-outline-success text-white"
                  type="submit"
                >
                  Search
                </button>
              </div>
            </form>
            <ul className="navbar-nav ">
              <li className="nav-item">
                <Link
                  to={"SignIn"}
                  className="text-white nav-link fs-1 d-flex align-items-center justify-content-center "
                >
                  <CiUser />
                </Link>
              </li>
            </ul>
          </div>
        </div>
      </nav>
    </>
  );
}
export default Navebar;
