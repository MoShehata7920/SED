import "./AdminInfo.css";
import { UseAxiosGet } from "../../Component/axios/GetApi/GetApi";
import Navebar from "../../Component/navebar/navbar";
import { MdAddShoppingCart, MdVerified } from "react-icons/md";
import { AiOutlineReddit } from "react-icons/ai";
import { CiUser } from "react-icons/ci";
import { BiImageAdd } from "react-icons/bi";
import { BsFillImageFill } from "react-icons/bs";
import { FaLock } from "react-icons/fa";
import { Link } from "react-router-dom";

export default function AdminInfo() {
  const GetApi = `/users/get`;
  const { data, isPending, error } = UseAxiosGet(GetApi);
  let datauser = data ? data.user : "";

  return (
    <>
      <section>
        <Navebar />
      </section>
      <div className="row ">
        <div className="col-12 Admininfo-bg  profile-sidebar d-flex flex-column  justify-content-center">
          <div className="  border-bottom-0  d-flex  justify-content-center  pt-4 mb-2 ">
            <div className="   Admininfo_Img_hight  ">
              <img
                src={datauser.userImage}
                alt=""
                className=" w-100 h-100 circle-frame rounded-circle  "
              />
            </div>
          </div>
          <h5 className=" text-center">Hello {datauser.fullName}</h5>
          <div className="w-100 border border-1 border-black"></div>

          <ul className=" text-center d-flex justify-content-around">
            <li>
              <Link to={`/Admin/UsersInfo`}>
                <label class="btn btn-outline-primary me-4 ">
                  <i className="text-black">{<CiUser />}</i>
                  <span className=" ms-1 d-none d-sm-inline text-black">
                    All User
                  </span>
                </label>
              </Link>
              <Link to={"/Admin/Website_img"}>
                <label class="btn btn-outline-primary me-4 ">
                  <i className="text-black ">{<BsFillImageFill />}</i>
                  <span className="ms-1 d-none d-sm-inline text-black">
                    Website Image
                  </span>
                </label>
              </Link>

              <label class="btn btn-outline-primary me-4 " for="btnradio1">
                <Link
                  className="text-decoration-none position-relative"
                  to={"/Admin/Carousel_ADD"}
                >
                  <i className="text-black">{<BiImageAdd />}</i>
                  <span className="ms-1 d-none d-sm-inline text-black">
                    Add Image
                  </span>
                </Link>
              </label>

              <label class="btn btn-outline-primary me-4 " for="btnradio1">
                <Link
                  className="text-decoration-none "
                  to={`/Admin/Admin_Account_Editing/${datauser._id}`}
                >
                  <i className="text-black">{<AiOutlineReddit />}</i>
                  <span className="ms-1 d-none d-sm-inline text-black">
                    Account Eddit
                  </span>
                </Link>
              </label>

              <label class="btn btn-outline-primary me-4 " for="btnradio1">
                <Link
                  className="text-decoration-none "
                  to={`/Admin/Change_Admin_Password/${datauser._id}`}
                >
                  <i className="text-black">{<FaLock />}</i>
                  <span className="ms-1 d-none d-sm-inline text-black">
                    Change Password
                  </span>
                </Link>
              </label>
            </li>
          </ul>
        </div>
      </div>
    </>
  );
}
