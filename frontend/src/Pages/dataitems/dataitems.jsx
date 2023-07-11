import { Link, useParams } from "react-router-dom";
import { useEffect, useState } from "react";
import Navebar from "../../Component/navebar/navbar";
import "./dataitems.css";
import Footer from "../../Component/footer/Footer";
import { BiHeart } from "react-icons/bi";
import { FaHeart } from "react-icons/fa";
import { encrypt, decrypt, compare } from "n-krypta";
import { UseAxiosGet } from "../../Component/axios/GetApi/GetApi";
import { UseAxiosPache } from "../../Component/axios/PachApi/PatchApi";
export default function Dataitems() {
  let { id } = useParams();
  const GetApi = `/products/product/${id}`;
  const patchApi = `/users/addToWishlist`;
  let [ID, setID] = useState({
    prodId: id,
  });
  const { data, isPending, error } = UseAxiosGet(GetApi);
  console.log(data);
  let dataproduct = data ? data.product : "";
  let datauser = data ? data.product.seller : "";
  const { response, ErrorMessage, HandelPachApi } = UseAxiosPache(patchApi, ID);
  let response_lenth = response ? response.user.length : null;
  let [Wishlist, setWishlist] = useState(false);
  async function SetWichlist() {
    HandelPachApi();
  }
  return (
    <>
      <section>
        <Navebar />
      </section>
      <section>
        <div className="container">
          <div className="row  align-items-center justify-content-center mt-5 mb-5 ">
            <div className=" col-8   rounded-5 bg-light  ">
              <div className="row">
                <div className="col-xxl-6 col-xl-6 col-lg-4 col-md-12 col-sm-12 col-12 mb-1">
                  <div className="photo-div bg-light   rounded-3">
                    <img
                      src={dataproduct.productImage}
                      className=" w-100 "
                      alt="..."
                    />
                  </div>
                </div>
                <div className="product-info col-xxl-6 col-xl-6 col-lg-8 col-md-12 col-sm-12 col-12 mt-3">
                  {Wishlist & (response_lenth > 1) ? (
                    <div className="  text-end me-2 mt-5 ">
                      <Link
                        onClick={() => {
                          SetWichlist();
                          setWishlist(false);
                        }}
                      >
                        <ul className=" text-decoration-none">
                          <i className=" fs-1 whichlist_bg ">
                            <FaHeart />
                          </i>
                        </ul>
                      </Link>
                    </div>
                  ) : (
                    <div className="  text-end me-2 mt-5 ">
                      <Link
                        onClick={() => {
                          SetWichlist();
                          setWishlist(true);
                        }}
                      >
                        <ul className="text-decoration-none">
                          <i className=" fs-1 text-dark  ">
                            <BiHeart />
                          </i>
                        </ul>
                      </Link>
                    </div>
                  )}
                  <div className="text-center">
                    <h3 className="">{dataproduct.productName}</h3>
                    <h6 className="mt-5">Price: {dataproduct.price}</h6>
                    <h4 className="mt-3">Product Details</h4>
                    <p className=" mt-3   ">{dataproduct.description}</p>
                  </div>
                  <div className="row mt-5">
                    <div className=" offset-2 col-12">
                      <h6>Uploaded By:- {datauser.fullName} </h6>
                    </div>
                    <div className=" offset-2 col-3  ">
                      <img
                        src={datauser.userImage}
                        alt=""
                        className="w-100 dataitem_img  rounded-circle"
                      />
                    </div>
                    <div className="col-6 mt-2">
                      <Link to={`/SellerInfo/${datauser._id}/${id}`}>
                        <button className="btn btn-primary">show more</button>
                      </Link>
                    </div>
                  </div>
                  <div className="mt-2 text-center">
                    <Link to={"/chat"}>
                      <button
                        onClick={localStorage.setItem(
                          "Reciver_id",
                          datauser._id
                        )}
                        className=" btn-items"
                      >
                        contact
                      </button>
                    </Link>
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
