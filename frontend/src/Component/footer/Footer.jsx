import "./footer.css";
import { NavLink } from "react-router-dom";

export default function Footer() {
  return (
    <footer className=" h-auto bg_footer ">
      {/* <div className="container ">
        <div className="row">
          <div className="col-6 ">
            <div className="app-div mt-2 rounded-3 footer-div">
              <h5 className="ms-3 pt-2 pb-1 text-white">Download Our App</h5>
              <div className="app-content d-flex justify-content-center ">
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
      </div> */}
      <div className="line-footer mt-2"></div>
      <div className="container mt-2 ">
        <div className="row">
          <div className="col-3">
            <div className="app-div mt-2 rounded-3 footer-div ">
              <h5 className="ms-3 pt-2 pb-1 text-white">Download Our App</h5>
              <div className="app-content d-flex justify-content-center ">
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
          <div className="col-7">
            <div className=" text-white ms-0 mt-4">
              <p className=" fs-7 ">
                SED: The Ultimate Online Shopping Destination in Egypt Buy 100%
                genuine consumer and home appliances from SED, the largest
                online store in Egypt.
              </p>
            </div>
          </div>
        </div>
      </div>
      <div className="line-footer mt-2"></div>

      <div>
        <h5 className="text-white mt-2 pb-2 ms-5 mb-0">
          © 2023 X-cite General Trading Co. S.A.K. (C)
        </h5>
      </div>
    </footer>
  );
}
