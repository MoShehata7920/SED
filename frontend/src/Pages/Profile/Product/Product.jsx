import "./Product.css";
import React from "react";
import { Link, useParams } from "react-router-dom";
import { useEffect, useState } from "react";
import Paginate from "../../../Component/pagination/Paginate";
import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
export default function Product() {
  let { UserID } = useParams();
  // const [totalpageNum, settotalpageNum] = useState(1);
  // const [currentpageNum, setcurrentpageNum] = useState(1);
  // const paginate = (pageNumber) => setcurrentpageNum(pageNumber);
  const GetApi = `/products/seller/${UserID}`;
  const { data, isPending, error } = UseAxiosGet(GetApi);
  let UserData = data ? data.products : [];
  return (
    <>
      <div className="container-fluid Productpage  ">
        <div className=" row ">
          <div id="style-7" className="  col-12  scrollbar   h-100 pt-4 ps-4 ">
            <div className="row  w-100 h-100 align-items-center justify-content-center ">
              <div className="col-xxl-9 col-xl-9 col-lg-9 col-md-9 col-sm-12 w-100 ">
                <div className="row justify-content-center">
                  {UserData.map((categ, index) => (
                    <div className="col-xxl-4  col-xl-4  col-lg-6 col-sm-6 col-6  ">
                      <Link
                        key={index}
                        to={`/Profile/myadds/${categ._id}`}
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
                                title and make up the bulk of the card's content
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
              {/* <div className=" d-flex justify-content-center pb-5 ">
                <Paginate paginate={paginate} totalpageNum={totalpageNum} />
              </div> */}
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
