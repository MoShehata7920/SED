import { Link, useParams } from "react-router-dom";
import Axios from "axios";
import { useEffect, useState } from "react";
import Navebar from "../../Component/navebar/navbar";
import "./dataitems.css";
import Footer from "../../Component/footer/Footer";
import { BiHeart } from "react-icons/bi";
import { FaHeart } from "react-icons/fa";
import { encrypt, decrypt, compare } from "n-krypta";
export default function Dataitems() {
  let { id } = useParams();
  let [Dataitems, setDataitems] = useState([]);
  let [SellerData, setSellerData] = useState([]);
  let [Wishlist, setWishlist] = useState(false);
  let [response, setResponse] = useState("");
  let [ID, setID] = useState({
    prodId: id,
  });
  let [ErrorMessage, setErrorMessage] = useState("");
  const secret = "@#$%abdo@#@$$ezzatQ1234lalls&^";
  const storedEncryptedData = localStorage.getItem("encryptedToken");
  const decryptedData = decrypt(storedEncryptedData, secret);
  async function Getitems(callback) {
    let { data } = await Axios.get(
      `http://47.243.7.214:3000/products/product/${id}`
    );
    callback(data.product);
    setSellerData(data.product.seller);
  }

  async function SetWichlist() {
    let request = await Axios.patch(
      `http://47.243.7.214:3000/users/addToWishlist`,
      ID,
      {
        headers: {
          Authentication: `Bearer ${decryptedData}`,
        },
      }
    )
      .then((response) => {
        setResponse(response.data.user);
      })
      .catch((error) => {
        // check for the response property of the error object
        if (error.response) {
          // set the error message state variable with the error message
          setErrorMessage(error.response.data.message);
        }
      });
  }

  useEffect(() => {
    Getitems(setDataitems);
  }, []);
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
                <div className="col-xxl-6 col-xl-6 col-lg-4 col-md-12 col-sm-12 col-12 ">
                  <div className="photo-div bg-light w-100   rounded-3">
                    <img
                      src={Dataitems.productImage}
                      className=" w-100 "
                      alt="..."
                    />
                  </div>
                </div>
                <div className="product-info col-xxl-6 col-xl-6 col-lg-8 col-md-12 col-sm-12 col-12 mt-3">
                  {Wishlist & (response.length !== 0) ? (
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
                    <h3 className="">{Dataitems.productName}</h3>
                    <h6 className="mt-5">Price: {Dataitems.price}</h6>
                    <h4 className="mt-3">Product Details</h4>
                    <p className=" mt-3   ">{Dataitems.description}</p>
                  </div>
                  <div className="row mt-5">
                    <div className=" offset-2 col-12">
                      <h6>Uploaded By:- {SellerData.fullName} </h6>
                    </div>
                    <div className=" offset-2 col-3 ">
                      <img
                        src={SellerData.userImage}
                        alt=""
                        className="w-100  rounded-circle"
                      />
                    </div>
                    <div className="col-6 mt-4">
                      <Link to={`/SellerInfo/${SellerData._id}/${id}`}>
                        <button className="btn btn-primary">show more</button>
                      </Link>
                    </div>
                  </div>
                  <div className="mt-2 text-center">
                    <button className=" btn-items">contact</button>
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
