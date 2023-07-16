import "./SellerInfo.css";
import React from "react";
import { Link, useParams } from "react-router-dom";
import Navebar from "../../Component/navebar/navbar";
import { UseAxiosGet } from "../../Component/axios/GetApi/GetApi";
import Footer from "../../Component/footer/Footer";

export default function SellerInfo() {
  let { SellerId, ProductID } = useParams();
  const GetApiData = `/products/seller/${SellerId}`;
  const {
    data: dataProduct,
    isPending: isPendingData,
    error: errorData,
  } = UseAxiosGet(GetApiData);
  const GetApiUser = `/products/product/${ProductID}`;
  const {
    data: dataUser,
    isPending: isPendingUser,
    error: errorUser,
  } = UseAxiosGet(GetApiUser);
  let UserInfo = dataUser ? dataUser.product.seller : "";
  let UserProduct = dataProduct ? dataProduct.products : [];

  return (
    <>
      <section>
        <Navebar />
      </section>

      <div className="infocardContainer">
        <div id="main">
          <img src={UserInfo.userImage} />
        </div>
        <div id="textbois">
          <h2> {UserInfo.fullName}</h2>
          <h4>{UserInfo.phone}</h4>
          <h4>
            {UserInfo.government}/{UserInfo.address}
          </h4>
          <h4>{UserInfo.email}</h4>
        </div>
      </div>

      <section>
        <div className="container-fluid SellInfo_bg  ">
          <div className="row">
            <div id="style-7" className="  col-12   scrollbar  pt-4 ps-4 ">
              <div className="row  ">
                <div className="col-xxl-8 col-xl-8 col-lg-8 col-md-8 col-sm-12 w-100 ">
                  <div className="row justify-content-center">
                    {UserProduct.map((categ, index) => (
                      <div className="col-xxl-3  col-xl-3  col-lg-4 col-sm-6 col-6  ">
                        <Link
                          key={index}
                          to={`/items/${categ._id}`}
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
                                <p className=" text-black  h-100 w-100">
                                  {categ.price}
                                </p>
                              </div>

                              <div className="slider-service-btn">
                                <button className="btn btn-primary mt-2 mb-3">
                                  <Link
                                    to={"n"}
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

      <section>
        <Footer />
      </section>
    </>
  );
}
