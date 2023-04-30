import Footer from "../../Component/footer/Footer";
import Navebar from "../../Component/navebar/navbar";
import { GiToggles } from "react-icons/gi";
import { Link, useParams } from "react-router-dom";
import Axios from "axios";
import { useEffect, useState } from "react";
import Paginate from "../../Component/pagination/Paginate";

export default function Categories() {
  let { CategorieType } = useParams();
  const [totalpageNum, settotalpageNum] = useState(1);
  const [currentpageNum, setcurrentpageNum] = useState(1);
  const paginate = (pageNumber) => setcurrentpageNum(pageNumber);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState(null);
  let [sort, setsort] = useState("");
  let [Detcateg, setDetcateg] = useState([]);
  let [Service, setService] = useState("all");
  console.log(Detcateg);
  const GetCategDeta = async () => {
    setError(null);
    setIsPending(true);

    try {
      if (
        CategorieType == "Phones&Tablets" ||
        CategorieType == "Phones & Tablets"
      ) {
        let respond = await Axios.get(
          `http://103.48.193.225:3000/products/get?purpose=${Service}&category=Phones%26Tablets&sort=${sort}&page=${currentpageNum}`
        );
        setDetcateg(respond.data.items);
        settotalpageNum(respond.data.totalPageNumber);
      } else if (
        CategorieType == "Body&HealthCare" ||
        CategorieType == "Body & Health Care"
      ) {
        let respond = await Axios.get(
          `http://103.48.193.225:3000/products/get?purpose=${Service}&category=Body%26HealthCare&sort=${sort}&page=${currentpageNum}`
        );
        setDetcateg(respond.data.items);
        settotalpageNum(respond.data.totalPageNumber);
      } else {
        let respond = await Axios.get(
          `http://103.48.193.225:3000/products/get?purpose=${Service}&category=${CategorieType}&sort=${sort}&page=${currentpageNum}`
        );
        setDetcateg(respond.data.items);
        settotalpageNum(respond.data.totalPageNumber);
      }
      setIsPending(false);
      //setError(null);
    } catch (err) {
      setIsPending(false);
      setError("could not fetch the data");
      console.log(err.items);
    }
  };
  useEffect(() => {
    GetCategDeta();
  }, [CategorieType, currentpageNum, Service, sort]);
  return (
    <>
      <section>
        <Navebar />
      </section>

      <section className="pt-4 seeAll_bg ">
        <div className="container-fluid">
          <div className="row">
            <div className="text-center mb-1">
              <h1>{CategorieType} Items</h1>
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
                  <div>
                    <ul className="list-group mb-5 ">
                      <h3>Services</h3>
                      <li className="list-group ">
                        <Link
                          onClick={() => {
                            setService("all");
                          }}
                          className=" mb-2 text-decoration-none text-black fs-4"
                        >
                          All(default)
                        </Link>
                      </li>
                      <li className="list-group ">
                        <Link
                          onClick={() => {
                            setService("sell");
                          }}
                          className=" mb-2 text-decoration-none text-black fs-4"
                        >
                          Sell
                        </Link>
                      </li>
                      <li className="list-group">
                        <Link
                          onClick={() => {
                            setService("exchange");
                          }}
                          className="mb-2 text-decoration-none text-black fs-4"
                        >
                          Exchange
                        </Link>
                      </li>
                      <li className="list-group">
                        <Link
                          onClick={() => {
                            setService("donate");
                          }}
                          className="mb-2 text-decoration-none text-black fs-4"
                        >
                          Donate
                        </Link>
                      </li>
                    </ul>
                  </div>
                  <div>
                    <h5>Max_Price</h5>
                    <div className="input-group mb-3">
                      <span className="input-group-text">$</span>
                      <input
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
                        type="text"
                        className="form-control"
                        aria-label="Amount (to the nearest dollar)"
                      />
                      <span className="input-group-text">.00</span>
                    </div>
                  </div>
                </div>
              </div>
            </div>
            <div className="col-xxl-9 col-xl-9 col-lg-9 col-md-9 col-sm-12 ">
              <div className="row justify-content-center">
                {Detcateg.map((categ, index) => (
                  <div className="col-xxl-4  col-xl-4  col-lg-6 col-sm-6 col-6  ">
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
                          <div className="slider-service-detailes ">
                            <p className=" text-black  h-100 w-100 ">
                              Some quick example text to build on the card title
                              and make up the bulk of the card's content
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
