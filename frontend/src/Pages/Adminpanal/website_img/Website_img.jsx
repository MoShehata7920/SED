import "./Website_img.css";
import AdminInfo from "../../../Component/AdminInfo/AdminInfo";
import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
import { Link } from "react-router-dom";
export default function WebsiteImg() {
  const GetApi = `/admin/application-images`;
  const { data, isPending, error } = UseAxiosGet(GetApi);
  let datauser = data ? data.images : [];
  console.log(datauser);

  return (
    <>
      <section>
        <AdminInfo />
      </section>
      <section className=" container-fluid mt-2 mb-2">
        <div className="row">
          <div id="style-7" className="  col-12   scrollbar  pt-4 ps-4 ">
            <div className="row  ">
              <div className="col-xxl-8 col-xl-8 col-lg-8 col-md-8 col-sm-12 w-100 ">
                <div className="row justify-content-center">
                  {datauser.map((Users, index) => (
                    <div className="col-xxl-3  col-xl-3  col-lg-4 col-sm-6 col-6  ">
                      <Link
                        key={index}
                        to={`/Admin/Imgae_Edit/${Users._id}`}
                        className="text-decoration-none "
                      >
                        <div className="item slider-style2  ">
                          <div className="slider-service-div  text-center seeAll_bg_item w-100 ">
                            <div className="slider-service-img ">
                              <img
                                src={Users.image}
                                className="card-img-top w-100 h-100  "
                                alt="..."
                              />
                            </div>
                            <div className="slider-service-btn">
                              <button className="btn btn-primary mt-2 mb-3">
                                <Link
                                  to={`/Admin/Imgae_Edit/${Users._id}`}
                                  className="text-decoration-none text-white"
                                >
                                  Edit
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
      </section>
    </>
  );
}
