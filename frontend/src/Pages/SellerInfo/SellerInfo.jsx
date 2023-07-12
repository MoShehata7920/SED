import "./SellerInfo.css";
import React from "react";
import { Link, useParams } from "react-router-dom";
import { useEffect, useState } from "react";
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

      <section>
        <div className="container-fluid SellInfo_bg    ">
          {dataUser && (
            <div className="row ">
              <div className=" col-xxl-8 col-xl-8 col-lg-10 col-md-12 col-12 border-bottom-0  SellInfo_bg pt-4 ">
                <div className="row mb-4 justify-content-center  ">
                  <div className="col-xxl-2 col-xl-2 col-lg-2 col-md-2 col-3 ">
                    <div className=" Sellerinfo_Img_hight">
                      <img
                        src={UserInfo.userImage}
                        alt=""
                        className=" w-100 h-100  rounded-circle"
                      />
                    </div>
                  </div>
                  <div className="col-xxl-10 col-xl-10 col-lg-9 col-md-8 col-8  mt-3">
                    <div className="row">
                      <div className="col-xxl-6 col-xl-6 col-lg-6 col-md-12 col-12 ">
                        <h5>Fullname:- {UserInfo.fullName}</h5>
                        <h5>Email:- {UserInfo.email}</h5>
                      </div>
                      <div className="col-xxl-6 col-xl-6 col-lg-6 col-md-12 col-12 ">
                        <h5>Phone Number:- {UserInfo.phone}</h5>
                        <h5>
                          Address:-
                          {UserInfo.government}/{UserInfo.address}
                        </h5>
                      </div>
                    </div>
                  </div>
                </div>
              </div>
            </div>
          )}
          <div className="row">
            <div id="style-7" className="  col-12   scrollbar  pt-4 ps-4 ">
              <div className="row  ">
                <div className="col-xxl-8 col-xl-8 col-lg-8 col-md-8 col-sm-12 w-100 ">
                  <div className="row justify-content-center">
                    {UserProduct.map((categ, index) => (
                      <div className="col-xxl-3  col-xl-3  col-lg-4 col-sm-6 col-6  ">
                        <Link
                          key={index}
                          to={`/Profile/settings/myadds/${categ._id}`}
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
                              <div className="slider-service-detailes ">
                                <p className=" text-black  h-100 w-100 ">
                                  Some quick example text to build on the card
                                  title and make up the bulk of the card's
                                  content
                                </p>
                              </div>
                              <div className="slider-service-price ">
                                <p className=" text-black mb-3 h-100 w-100">
                                  {categ.price}
                                </p>
                              </div>

                              <div className="slider-service-btn">
                                <button className="btn btn-primary mt-2 mb-3">
                                  <Link
                                    to={"n"}
                                    className="text-decoration-none text-white"
                                  >
                                    ADD TO CARD
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
