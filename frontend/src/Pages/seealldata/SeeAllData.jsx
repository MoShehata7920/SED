import Footer from "../../Component/footer/Footer";
import Navebar from "../../Component/navebar/navbar";
import { Link, useParams } from "react-router-dom";
import { GiToggles } from "react-icons/gi";
import Axios from "axios";
import { useEffect, useState } from "react";
import Paginate from "../../Component/pagination/Paginate";
import "./seealldata.css";

export default function SeeAllData() {
  let { SeeData } = useParams();
  let [totalpageNum, settotalpageNum] = useState(1);
  let [currentpageNum, setcurrentpageNum] = useState(1);
  let [isPending, setIsPending] = useState(false);
  let [error, setError] = useState(null);
  let [AllData, setAllData] = useState([]);
  let [category, setcategory] = useState("all");
  let [sort, setsort] = useState("");
  let [MaxPrice, setMaxPrice] = useState("");
  let [MinPrice, setMinPrice] = useState("");
  let [Condition, setCondition] = useState("");
  console.log("min", MinPrice, "Max", MaxPrice);
  let [Price, setPrice] = useState({ Min: "", Max: "" });
  const paginate = (pageNumber) => setcurrentpageNum(pageNumber);
  function pricedone() {
    setMaxPrice(Price.Max);
    setMinPrice(Price.Min);
  }
  function getPrice(e) {
    let myitem = { ...Price };
    myitem[e.target.name] = e.target.value;

    setPrice(myitem);
  }

  const GetseeallDeta = async () => {
    setError(null);
    setIsPending(true);

    try {
      let respond = await Axios.get(
        `http://103.48.193.225:3000/products/get?purpose=${SeeData}&category=${category}&sort=${sort}&minPrice=${MinPrice}&maxPrice=${MaxPrice}&condition=${Condition}&page=${currentpageNum}`
      );
      setAllData(respond.data.items);
      settotalpageNum(respond.data.totalPageNumber);
      setIsPending(false);
      //setError(null);
    } catch (err) {
      setIsPending(false);
      setError("could not fetch the data");
      console.log(err.message);
    }
  };
  useEffect(() => {
    GetseeallDeta();
  }, [SeeData, currentpageNum, category, sort, MaxPrice, MinPrice, Condition]);
  return (
    <>
      <section>
        <Navebar />
      </section>
      <section className="pt-4 seeAll_bg ">
        <div className="container-fluid">
          <div className="row">
            <div className="text-center mb-1">
              <h1>{SeeData} Items</h1>
            </div>
            <div className="col-12 col-xl-3 col-lg-3 col-md-3  seeAll_bg navbar-expand-md">
              <div className=" d-flex mb-4">
                <h1 className=" ms-5 me-4 ">Filter</h1>

                <button
                  className="navbar-toggler"
                  type="button"
                  data-bs-toggle="collapse"
                  data-bs-target="#SupportedContent"
                  aria-controls="SupportedContent"
                >
                  <span className="seeAll_bg_troger_parent">
                    <GiToggles className="seeAll_bg_troger " />
                  </span>
                </button>
              </div>
              <div
                className="navbar-collapse collapse  "
                align="center"
                id="SupportedContent"
              >
                <div className="">
                  <div className="mb-4 ">
                    <h4 className="me-1">Sort By</h4>
                    <div className="dropdown">
                      <button
                        GiToggles
                        className="btn btn-secondary dropdown-toggle"
                        type="button"
                        id="dropdownMenuButton1"
                        data-bs-toggle="dropdown"
                        aria-expanded="false"
                      >
                        Recomended
                      </button>
                      <ul
                        className="dropdown-menu"
                        aria-labelledby="dropdownMenuButton1"
                      >
                        <li>
                          <Link
                            onClick={() => {
                              setsort("");
                            }}
                            className="dropdown-item"
                          >
                            Default
                          </Link>
                        </li>
                        <li>
                          <Link
                            onClick={() => {
                              setsort("-price");
                            }}
                            className="dropdown-item"
                          >
                            High price
                          </Link>
                        </li>
                        <li>
                          <Link
                            onClick={() => {
                              setsort("price");
                            }}
                            className="dropdown-item"
                          >
                            Low price
                          </Link>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <div className="mb-4 ">
                    <h4 className="me-1">Condition</h4>
                    <div className="dropdown">
                      <button
                        GiToggles
                        className="btn btn-secondary dropdown-toggle"
                        type="button"
                        id="dropdownMenuButton1"
                        data-bs-toggle="dropdown"
                        aria-expanded="false"
                      >
                        Recomended
                      </button>
                      <ul
                        className="dropdown-menu"
                        aria-labelledby="dropdownMenuButton1"
                      >
                        <li>
                          <Link
                            onClick={() => {
                              setCondition("New");
                            }}
                            className="dropdown-item"
                          >
                            New
                          </Link>
                        </li>
                        <li>
                          <Link
                            onClick={() => {
                              setCondition("Used");
                            }}
                            className="dropdown-item"
                          >
                            Used
                          </Link>
                        </li>
                      </ul>
                    </div>
                  </div>
                  <div>
                    <ul className="list-group mb-5 ">
                      <h3>Category</h3>
                      <li className="list-group ">
                        <Link
                          onClick={() => {
                            setcategory("all");
                          }}
                          className=" mb-2 text-decoration-none text-black fs-4"
                        >
                          All(default)
                        </Link>
                      </li>
                      <li className="list-group ">
                        <Link
                          onClick={() => {
                            setcategory("Electronics");
                          }}
                          className=" mb-2 text-decoration-none text-black fs-4"
                        >
                          Electronics
                        </Link>
                      </li>
                      <li className="list-group">
                        <Link
                          onClick={() => {
                            setcategory("Fashion");
                          }}
                          className="mb-2 text-decoration-none text-black fs-4"
                        >
                          Fashion
                        </Link>
                      </li>
                      <li className="list-group">
                        <Link
                          onClick={() => {
                            setcategory("Furniture");
                          }}
                          className="mb-2 text-decoration-none text-black fs-4"
                        >
                          Furniture
                        </Link>
                      </li>
                      <li className="list-group">
                        <Link
                          onClick={() => {
                            setcategory("Sports");
                          }}
                          className="mb-2 text-decoration-none text-black fs-4"
                        >
                          Sports
                        </Link>
                      </li>
                      <li className="list-group">
                        <Link
                          onClick={() => {
                            setcategory("Supermarket");
                          }}
                          className="mb-2 text-decoration-none text-black fs-4"
                        >
                          Supermarket
                        </Link>
                      </li>
                      <li className="list-group">
                        <Link
                          onClick={() => {
                            setcategory("Vehicles");
                          }}
                          className="mb-2 text-decoration-none text-black fs-4"
                        >
                          Vehicle
                        </Link>
                      </li>
                      <li className="list-group">
                        <Link
                          onClick={() => {
                            setcategory("Other");
                          }}
                          className="mb-2 text-decoration-none text-black fs-4"
                        >
                          Other
                        </Link>
                      </li>
                      <li className="list-group">
                        <Link
                          onClick={() => {
                            setcategory("Phones%26Tablets");
                          }}
                          className="mb-2 text-decoration-none text-black fs-4"
                        >
                          Phones&Tablets
                        </Link>
                      </li>
                      <li className="list-group">
                        <Link
                          onClick={() => {
                            setcategory("Body%26HealthCare");
                          }}
                          className="mb-2 text-decoration-none text-black fs-4"
                        >
                          Body&HealthCare
                        </Link>
                      </li>
                    </ul>
                  </div>
                  <div>
                    <h5>Max_Price</h5>
                    <div className="input-group mb-3">
                      <span className="input-group-text">$</span>
                      <input
                        onChange={getPrice}
                        name="Max"
                        type="text"
                        className="form-control"
                        aria-label="Amount (to the nearest dollar)"
                      />
                      <span className="input-group-text">.00</span>
                    </div>
                  </div>
                  <div>
                    <h5>Min_Price</h5>
                    <div className="input-group mb-3">
                      <span className="input-group-text">$</span>
                      <input
                        onChange={getPrice}
                        name="Min"
                        type="text"
                        className="form-control"
                        aria-label="Amount (to the nearest dollar)"
                      />
                      <span className="input-group-text">.00</span>
                    </div>
                  </div>
                  <div>
                    <button
                      onClick={() => {
                        pricedone();
                      }}
                      className="btn btn-primary"
                    >
                      Price
                    </button>
                  </div>
                </div>
              </div>
            </div>
            <div className="col-xxl-9 col-xl-9 col-lg-9 col-md-9 col-sm-12 ">
              <div className="row justify-content-center">
                {AllData.map((All, index) => (
                  <div
                    key={index}
                    className="col-xxl-4  col-xl-4  col-lg-6 col-sm-6 col-6  "
                  >
                    <Link
                      to={`/items/${All._id}`}
                      className="text-decoration-none "
                    >
                      <div className=" item slider-style2 mb-3  ">
                        <div className="slider-service-div  text-center seeAll_bg_item w-100 ">
                          <div className="slider-service-img ">
                            <img
                              src={All.productImage}
                              className="card-img-top w-100 h-100  "
                              alt="..."
                            />
                          </div>

                          <div className="slider-service-title">
                            <h5 className="card-title text-black mb-3 mt-3">
                              {All.productName}
                            </h5>
                          </div>
                          <div className="slider-service-detailes ">
                            <p className=" text-black  h-100 w-100 ">
                              Some quick example text to build on the card title
                              and make up the bulk of the card's content
                            </p>
                          </div>
                          <div className="slider-service-price ">
                            <p className=" text-black mb-3 h-100 w-100">
                              {All.price}
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
          <div className=" d-flex justify-content-center pb-5">
            <Paginate paginate={paginate} totalpageNum={totalpageNum} />
          </div>
        </div>
      </section>

      <section>
        <Footer />
      </section>
    </>
  );
}
