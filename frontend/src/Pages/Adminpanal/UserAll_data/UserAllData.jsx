import "./UserAllData.css";
import { useEffect, useState } from "react";
import { Link, useNavigate, useParams } from "react-router-dom";
import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
import AdminInfo from "../../../Component/AdminInfo/AdminInfo";
import { UseAxiosDelete } from "../../../Component/axios/DeleteApi/DeleteApi";
import { UseAxiosPache } from "../../../Component/axios/PachApi/PatchApi";
import { ToastContainer, toast } from "react-toastify";

export default function UserAllData() {
  const navigate = useNavigate();
  let { UserID } = useParams();
  const GetApiData = `/products/seller/${UserID}`;
  const GetUserData = `/users/singleuser/${UserID}`;
  const DeletApi = `/users/delete/${UserID}`;
  const [UserAdmin, setUserAdmin] = useState({
    isAdmin: "",
  });
  const {
    data: dataProduct,
    isPending: isPendingData,
    error: errorData,
  } = UseAxiosGet(GetApiData);
  let UserProduct = dataProduct ? dataProduct.products : [];
  const { data, isPending, error } = UseAxiosGet(GetUserData);
  let UserData = data ? data.user : "";
  console.log(UserData);
  const patchAPi = `/users/update/${UserID}`;
  const { response, ErrorMessage, HandelPachApi } = UseAxiosPache(
    patchAPi,
    UserAdmin
  );

  async function AdminSubmit(e) {
    e.preventDefault();
    HandelPachApi();
  }
  const {
    response: responseDelete,
    ErrorMessage: ErrorMessageDelete,
    HandelDeleteApi,
  } = UseAxiosDelete(DeletApi);
  const DeletSubmit = (e) => {
    e.preventDefault();
    HandelDeleteApi();
  };
  useEffect(() => {
    if (UserData && UserData.isAdmin) {
      setUserAdmin({
        ...UserAdmin,
        isAdmin: false,
      });
    } else {
      setUserAdmin({
        ...UserAdmin,
        isAdmin: true,
      });
    }
    if (responseDelete) {
      toast(`✔️ ${responseDelete}`);
      setTimeout(() => {
        navigate("/Admin/UsersInfo");
      }, 3000);
    }
    if (ErrorMessageDelete && responseDelete == "") {
      toast(`❌ ${ErrorMessageDelete} `);
    }
    if (response) {
      toast(`✔️ ${response}`);
      setTimeout(() => {
        navigate("/Admin/UsersInfo");
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [
    UserData.isAdmin,
    response,
    ErrorMessage,
    ErrorMessageDelete,
    responseDelete,
  ]);
  return (
    <>
      <section>
        <AdminInfo />
      </section>
      <section>
        <div className="infocardContainer">
          <div id="main">
            <img src={UserData.userImage} />
          </div>
          <div id="textbois">
            <h2> {UserData.fullName}</h2>
            <h4>{UserData.phone}</h4>
            <h4>
              {UserData.government}/{UserData.address}
            </h4>
            <h4>{UserData.email}</h4>
          </div>
        </div>

        <div className="container-fluid SellInfo_bg    ">
          <div className="row justify-content-center ms-5 ">
            <div className="  col-xxl-1 col-xl-1 col-lg-1 col-md-12 col-12 ">
              <form onSubmit={DeletSubmit}>
                <button type="submit" className="btn btn-danger mt-5">
                  Remove
                </button>
              </form>
            </div>
            {UserData.isAdmin == true ? (
              <div className=" col-xxl-2 col-xl-2 col-lg-1 col-md-12 col-12 ">
                <form onSubmit={AdminSubmit}>
                  <button type="submit" className="btn btn-primary mt-5">
                    Remove Admin
                  </button>
                </form>
              </div>
            ) : (
              <div className=" col-xxl-2 col-xl-2 col-lg-1 col-md-12 col-12 ">
                <form onSubmit={AdminSubmit}>
                  <button type="submit" className="btn btn-primary mt-5">
                    Make Admin
                  </button>
                </form>
              </div>
            )}
          </div>

          <div className="row">
            <div id="style-7" className="  col-12   scrollbar  pt-4 ps-4 ">
              <div className="row  ">
                <div className="col-xxl-8 col-xl-8 col-lg-8 col-md-8 col-sm-12 w-100 ">
                  <div className="row justify-content-center">
                    {UserProduct.map((categ, index) => (
                      <div className="col-xxl-3  col-xl-3  col-lg-4 col-sm-6 col-6  ">
                        <Link
                          key={index}
                          to={`/Admin/User_Product/${categ._id}`}
                          className="text-decoration-none "
                        >
                          <div className="item slider-style2 mb-3 ">
                            <div className="slider-service-div  text-center seeAll_bg_item w-100 ">
                              <div className="slider-service-img ">
                                <img
                                  src={categ.productImage}
                                  className="card-img-top w-100 h-100  "
                                  alt="..."
                                />
                              </div>

                              <div className="slider-service-title">
                                <h5 className="card-title text-black mb-3 mt-3">
                                  {categ.productName}
                                </h5>
                              </div>

                              <div className="slider-service-price ">
                                <p className=" text-black mb-3 h-100 w-100">
                                  {categ.price}
                                </p>
                              </div>

                              <div className="slider-service-btn">
                                <button className="btn btn-primary mt-2 mb-3">
                                  <Link
                                    to={`/Admin/User_Product/${categ._id}`}
                                    className="text-decoration-none text-white"
                                  >
                                    Show More
                                  </Link>
                                </button>
                              </div>
                            </div>
                          </div>
                        </Link>
                      </div>
                    ))}
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
      <ToastContainer />
    </>
  );
}
