import "./footer.css";
import { NavLink } from "react-router-dom";

export default function Footer() {
  return (
    <footer className=" h-auto bg_footer ">
      <div className="container ">
        <div className="row">
          <div className="col-6 ">
            <div className="app-div mt-5 rounded-3 footer-div">
              <h5 className="ms-3 pt-2 pb-1 text-white">Download Our App</h5>
              <div className="app-content d-flex justify-content-center ">
                <div className="app-img me-2 ">
                  <NavLink to={"a"} className="w-100">
                    <img
                      className="w-100"
                      src="https://cdn.media.amplience.net/i/xcite/Download_on_the_App_Store_Badge2?img404=default&w=384&qlt=75&fmt=auto"
                      alt=""
                    />
                  </NavLink>
                </div>
                <div className="app-img">
                  <NavLink to={"a"} className="w-100">
                    <img
                      className="w-100"
                      src="https://cdn.media.amplience.net/i/xcite/Google_Play_Store_badge_EN2?img404=default&w=384&qlt=75&fmt=auto"
                      alt=""
                    />
                  </NavLink>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
      <div className="line-footer mt-5"></div>
      <div className="container mt-5 ">
        <div className="row">
          <div className="col-3">
            <div className=" text-white">
              <h1 className="mb-3">SED</h1>
              <p className=" fs-7 ">
                SED: The Ultimate Online Shopping Destination in Egypt | Buy
                100% genuine consumer and home appliances from SED, the largest
                online store in Egypt.
              </p>
            </div>
          </div>
          <div className="col-3 mt-2">
            <div className="footer-text2 text-white ">
              <h5 className="mb-4">General Information</h5>
              <NavLink to={"a"} className=" d-block mb-3">
                Help
              </NavLink>
              <NavLink to={"a"} className=" d-block mb-3">
                About X-cite
              </NavLink>
              <NavLink to={"a"} className=" d-block mb-3">
                Privacy Policy
              </NavLink>
              <NavLink to={"a"} className=" d-block mb-3">
                Frequently Asked Questions
              </NavLink>
              <NavLink to={"a"} className=" d-block">
                Terms & Conditions
              </NavLink>
            </div>
          </div>
          <div className="col-3 mt-2">
            <div className="footer-text2  text-white ">
              <h5 className="mb-4">Our Services</h5>
              <NavLink to={"a"} className=" d-block mb-3">
                Pay Monthly Installments
              </NavLink>
              <NavLink to={"a"} className=" d-block mb-3">
                Service Centers
              </NavLink>
              <NavLink to={"a"} className=" d-block mb-3">
                Contact Us
              </NavLink>
              <NavLink to={"a"} className=" d-block mb-3">
                Quick Delivery & Installation
              </NavLink>
              <NavLink to={"a"} className=" d-block mb-3">
                Buyer Protection
              </NavLink>
              <NavLink to={"a"} className=" d-block mb-3">
                X-cite Secure Shopping
              </NavLink>
              <NavLink to={"a"} className=" d-block mb-3">
                B2B - Corporate Sales
              </NavLink>
            </div>
          </div>
          <div className="col-3 mt-2">
            <div className="footer-text2 text-white ">
              <h5 className="mb-4">Highlights</h5>
              <NavLink to={"a"} className=" d-block mb-3">
                flyer
              </NavLink>
              <NavLink to={"a"} className=" d-block mb-3">
                X-cite Mobile App
              </NavLink>
            </div>
          </div>
        </div>
      </div>
      <div className="line-footer mt-5"></div>
      <div>
        <h5 className="text-white mt-4 pb-4 ms-5 mb-0">
          © 2023 X-cite General Trading Co. S.A.K. (C)
        </h5>
      </div>
    </footer>
  );
}
