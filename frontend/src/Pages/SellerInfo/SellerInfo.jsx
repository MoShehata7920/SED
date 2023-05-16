import "./SellerInfo.css";
import React from "react";
import { Link, useParams } from "react-router-dom";
import { GiToggles } from "react-icons/gi";
import Axios from "axios";
import { useEffect, useState } from "react";
import Paginate from "../../Component/pagination/Paginate";
import Navebar from "../../Component/navebar/navbar";
import { encrypt, decrypt, compare } from "n-krypta";

export default function SellerInfo() {
  let { SellerId, ProductID } = useParams();
  const secret = "@#$%abdo@#@$$ezzatQ1234lalls&^";
  const storedEncryptedData = localStorage.getItem("encryptedToken");
  const decryptedData = decrypt(storedEncryptedData, secret);
  let [UserData, setUserData] = useState([]);
  const [totalpageNum, settotalpageNum] = useState(1);
  const [currentpageNum, setcurrentpageNum] = useState(1);
  const paginate = (pageNumber) => setcurrentpageNum(pageNumber);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState(null);
  let [UserInfo, setUserInfo] = useState([]);
  console.log(UserData);
  console.log(UserInfo);
  const UserProduct = async () => {
    setError(null);
    setIsPending(true);

    try {
      let UserData = await Axios.get(
        `http://47.243.7.214:3000/products/seller/${SellerId}`,
        {
          headers: {
            Authentication: `Bearer ${decryptedData}`,
          },
        }
      );
      setUserData(UserData.data.products);
      setIsPending(false);
    } catch (err) {
      setIsPending(false);
      setError("could not fetch the data");
      console.log(err.message);
    }
  };
  async function GetUserInfo() {
    let { data } = await Axios.get(
      `http://47.243.7.214:3000/products/product/${ProductID}`
    );
    setUserInfo(data.product.seller);
  }

  useEffect(() => {
    UserProduct();
    GetUserInfo();
  }, []);
  return (
    <>
      <section>
        <Navebar />
      </section>
      <section>
        <div className="container-fluid SellInfo_bg    ">
          <div className="row ">
            <div className=" col-8 border-bottom-0  SellInfo_bg pt-4 ">
              <div className="row mb-4 justify-content-center  ">
                <div className="col-2 ">
                  <div className=" Sellerinfo_Img_hight">
                    <img
                      src={UserInfo.userImage}
                      alt=""
                      className=" w-100 h-100  rounded-circle"
                    />
                  </div>
                </div>
                <div className="col-10 mt-3">
                  <div className="row">
                    <div className="col-6">
                      <h5>Fullname:- {UserInfo.fullName}</h5>
                      <h5>Email:- {UserInfo.email}</h5>
                    </div>
                    <div className="col-6">
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
          <div className="row">
            <div
              id="style-7"
              className="  col-12   scrollbar  vh-100 pt-4 ps-4 "
            >
              <div className="row  ">
                <div className="col-xxl-8 col-xl-8 col-lg-8 col-md-8 col-sm-12 w-100 ">
                  <div className="row justify-content-center">
                    {UserData.map((categ, index) => (
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
                <div className=" d-flex justify-content-center pb-5 ">
                  <Paginate paginate={paginate} totalpageNum={totalpageNum} />
                </div>
              </div>
            </div>
          </div>
        </div>
      </section>
    </>
  );
}
