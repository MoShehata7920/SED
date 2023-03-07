import Navebar from "../../Component/navebar/navbar";
import "./Home.css";
import "react-responsive-carousel/lib/styles/carousel.css";
import OwlCarousel from "react-owl-carousel";
import { NavLink } from "react-router-dom";
import Axios from "axios";
import { useEffect, useState } from "react";
import Footer from "../../Component/footer/Footer";

export default function Home() {
  const options = {
    margin: 20,
    loop: true,
    autoplay: true,
    autoplayTimeout: 5000,
    autoplayHoverPause: true,
    responsive: {
      0: {
        items: 1,
      },
      400: {
        items: 1,
      },
      600: {
        items: 1,
      },
      700: {
        items: 1,
      },
      1000: {
        items: 1,
      },
    },
  };
  const options2 = {
    margin: 20,
    merge: true,
    nav: true,
    dot: true,
    responsiveClass: true,
    autoplay: false,
    smartSpeed: 1000,
    responsive: {
      0: {
        items: 2,
      },
      400: {
        items: 2,
      },
      600: {
        items: 2,
      },
      700: {
        items: 3,
      },
      1000: {
        items: 5,
      },
    },
  };
  let [DetaAll, setDetaAll] = useState([]);
  let [Detasell, setDetasell] = useState([]);
  let [Detadonat, setDetadonat] = useState([]);
  let [Detaexchange, setDetaexchange] = useState([]);
  async function GetDeta(mediatype, callback) {
    let { data } = await Axios.get(
      `http://103.48.193.225:9000/home/${mediatype}`
    );

    if (mediatype === "") {
      callback(data.carousel.Images);
    } else {
      callback(data.items);
    }
  }

  useEffect(() => {
    GetDeta("", setDetaAll);
    GetDeta("sell", setDetasell);
    GetDeta("donate", setDetadonat);
    GetDeta("exchange", setDetaexchange);
  }, []);
  return (
    <>
      <section>
        <Navebar />
      </section>
      <section className="pt-5">
        <OwlCarousel className="slider-style " {...options}>
          {DetaAll.map((carous, carousindex) => (
            <div key={carousindex} className="item">
              <img className="" src={carous} alt="" />
            </div>
          ))}
        </OwlCarousel>
      </section>
      <section>
        <div className="row">
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <NavLink to={"aa"} className="  text-decoration-none">
              <div className="catogiry-div  position-relative  ">
                <div className=" position-absolute h-100 w-100">
                  <img
                    className="catogiry-img w-100 h-100"
                    src="https://cdn.media.amplience.net/i/xcite/Ramadan2023-homepage-Phones_2?img404=default&w=1080&qlt=75&fmt=auto"
                    alt=""
                  />
                </div>
                <div className=" catogiry-text  w-100 text-center">
                  <h4 className=" pb-3 ">Phone & accsessories</h4>
                </div>
              </div>
            </NavLink>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12">
            <NavLink to={"a"} className=" text-decoration-none">
              <div className="catogiry-div  position-relative ">
                <div className=" position-absolute w-100 h-100">
                  <img
                    className="catogiry-img w-100 h-100 "
                    src="https://cdn.media.amplience.net/i/xcite/Ramadan2023-homepage-homeentertainment_2?img404=default&w=1080&qlt=75&fmt=auto"
                    alt=""
                  />
                </div>
                <div className=" catogiry-text text-white  w-100 text-center">
                  <h4 className=" pb-3 ">Home Intertainment</h4>
                </div>
              </div>
            </NavLink>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <NavLink to={"a"} className="  text-decoration-none">
              <div className="catogiry-div  position-relative   ">
                <div className=" position-absolute w-100 h-100">
                  <img
                    className="catogiry-img w-100 h-100 "
                    src="https://cdn.media.amplience.net/i/xcite/Ramadan2023-homepage-SA_2?img404=default&w=1080&qlt=75&fmt=auto"
                    alt=""
                  />
                </div>
                <div className=" catogiry-text text-white  w-100 text-center">
                  <h4 className=" pb-3 ">Phone & accsessories</h4>
                </div>
              </div>
            </NavLink>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <NavLink to={"a"} className="  text-decoration-none  ">
              <div className="catogiry-div  position-relative d-flex justify-content-center">
                <div className=" position-absolute w-100 h-100">
                  <img
                    className="catogiry-img w-100 h-100"
                    src="https://cdn.media.amplience.net/i/xcite/Ramadan2023-homepage-Computers_2?img404=default&w=1080&qlt=75&fmt=auto"
                    alt=""
                  />
                </div>
                <div className=" catogiry-text text-white  w-100 text-center">
                  <h4 className=" pb-3 ms-3 ">Computer & Tablet</h4>
                </div>
              </div>
            </NavLink>
          </div>
        </div>
      </section>
      <section>
        <div className="row mb-5">
          <div className="col-12 ">
            <div className="bg-black advertisement ">
              <img
                className="w-100 h-100"
                src="https://assets.voxcinemas.com/content/KWT_Visa_Infinite_Card_VOX_Website_Banner_880X300_18_01_224_1642675381.jpg"
                alt=""
              />
            </div>
          </div>
        </div>
      </section>
      <section>
        <div className="row ">
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <NavLink to={"a"} className="  text-decoration-none">
              <div className="catogiry-div  position-relative  ">
                <div className=" position-absolute h-100 w-100">
                  <img
                    className="catogiry-img w-100 h-100"
                    src="https://cdn.media.amplience.net/i/xcite/Ramadan2023-homepage-LA_2?img404=default&w=1080&qlt=75&fmt=auto"
                    alt=""
                  />
                </div>
                <div className=" catogiry-text  w-100 text-center">
                  <h4 className=" pb-3 ">Lage Home Appliances</h4>
                </div>
              </div>
            </NavLink>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12">
            <NavLink to={"a"} className=" text-decoration-none">
              <div className="catogiry-div  position-relative ">
                <div className=" position-absolute w-100 h-100">
                  <img
                    className="catogiry-img w-100 h-100 "
                    src="https://cdn.media.amplience.net/i/xcite/Ramadan2023-homepage-Personalcare_2?img404=default&w=1080&qlt=75&fmt=auto"
                    alt=""
                  />
                </div>
                <div className=" catogiry-text text-white  w-100 text-center">
                  <h4 className=" pb-3 ">Personla Care</h4>
                </div>
              </div>
            </NavLink>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <NavLink to={"a"} className="  text-decoration-none">
              <div className="catogiry-div  position-relative   ">
                <div className=" position-absolute w-100 h-100">
                  <img
                    className="catogiry-img w-100 h-100"
                    src="https://cdn.media.amplience.net/i/xcite/Ramadan2023-homepage-Gaming_2?img404=default&w=1080&qlt=75&fmt=auto"
                    alt=""
                  />
                </div>
                <div className=" catogiry-text text-white  w-100 text-center">
                  <h4 className=" pb-3 ">Gaming</h4>
                </div>
              </div>
            </NavLink>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <NavLink to={"a"} className="  text-decoration-none  ">
              <div className="catogiry-div  position-relative d-flex justify-content-center">
                <div className=" position-absolute w-100 h-100">
                  <img
                    className="catogiry-img w-100 h-100"
                    src="https://cdn.media.amplience.net/i/xcite/Ramadan-category-ACs?img404=default&w=1080&qlt=75&fmt=auto"
                    alt=""
                  />
                </div>
                <div className=" catogiry-text text-white  w-100 text-center">
                  <h4 className=" pb-3 ms-3 ">Computer & Tablet</h4>
                </div>
              </div>
            </NavLink>
          </div>
        </div>
      </section>
      <section className="pt-5  ">
        <OwlCarousel className=" owl-theme  " {...options2}>
          <div className="item text-center">
            <h1 className=" fs-10 ">SELL</h1>
            <NavLink to={"a"}>
              <p className="text-black fs-3 "> see all</p>
            </NavLink>
          </div>
          {Detasell.map((sell, index) => (
            <NavLink
              key={index}
              to={`/items/${sell.ID}`}
              className="text-decoration-none "
            >
              <div className="item slider-style2 mb-1">
                <div className="slider-service-div  text-center  ">
                  <div className="slider-service-img ">
                    <img
                      src={sell.Image}
                      className="card-img-top w-100 h-100  "
                      alt="..."
                    />
                  </div>

                  <div className="slider-service-title">
                    <h5 className="card-title text-black mb-3 mt-3">
                      {sell.Name}
                    </h5>
                  </div>
                  <div className="slider-service-detailes ">
                    <p className=" text-black  h-100 w-100 "></p>
                  </div>
                  <div className="slider-service-price ">
                    <p className=" text-black mb-3 h-100 w-100">{sell.Price}</p>
                  </div>

                  <div className="slider-service-btn">
                    <button className="btn btn-primary mt-2 mb-3">
                      <NavLink
                        to={"n"}
                        className="text-decoration-none text-white"
                      >
                        ADD TO CARD
                      </NavLink>
                    </button>
                  </div>
                </div>
              </div>
            </NavLink>
          ))}
        </OwlCarousel>
      </section>
      <section className="pt-5  ">
        <OwlCarousel className=" owl-theme  " {...options2}>
          <div className="item text-center">
            <h1 className=" fs-9 ">EXCHANGE</h1>
            <NavLink to={"a"}>
              <p className="text-black fs-3 "> see all</p>
            </NavLink>
          </div>
          {Detaexchange.map((exchange, ind) => (
            <NavLink
              key={ind}
              to={`/items/${exchange.ID}`}
              className="text-decoration-none "
            >
              <div className="item slider-style2 mb-1">
                <div className="slider-service-div  text-center  ">
                  <div className="slider-service-img ">
                    <img
                      src={exchange.Image}
                      className="card-img-top w-100 h-100  "
                      alt="..."
                    />
                  </div>

                  <div className="slider-service-title">
                    <h5 className="card-title text-black mb-3 mt-3">
                      {exchange.Name}
                    </h5>
                  </div>
                  <div className="slider-service-detailes ">
                    <p className=" text-black  h-100 w-100 ">
                      Some quick example text to build on the card title and
                      make up the bulk of the card's content
                    </p>
                  </div>
                  <div className="slider-service-price ">
                    <p className=" text-black mb-3 h-100 w-100">
                      {exchange.Price}
                    </p>
                  </div>

                  <div className="slider-service-btn">
                    <button className="btn btn-primary mt-2 mb-3">
                      <NavLink
                        to={"n"}
                        className="text-decoration-none text-white"
                      >
                        ADD TO CARD
                      </NavLink>
                    </button>
                  </div>
                </div>
              </div>
            </NavLink>
          ))}
        </OwlCarousel>
      </section>
      <section className="pt-5  ">
        <OwlCarousel className=" owl-theme  " {...options2}>
          <div className="item text-center">
            <h1 className=" fs-9 ">DONATE</h1>
            <NavLink to={"a"}>
              <p className="text-black fs-3 "> see all</p>
            </NavLink>
          </div>
          {Detadonat.map((donate, donateindex) => (
            <NavLink
              key={donateindex}
              to={`/items/${donate.ID}`}
              className="text-decoration-none "
            >
              <div className="item slider-style2 mb-1">
                <div className="slider-service-div  text-center  ">
                  <div className="slider-service-img ">
                    <img
                      src={donate.Image}
                      className="card-img-top w-100 h-100  "
                      alt="..."
                    />
                  </div>

                  <div className="slider-service-title">
                    <h5 className="card-title text-black mb-3 mt-3">
                      {donate.Name}
                    </h5>
                  </div>
                  <div className="slider-service-detailes ">
                    <p className=" text-black  h-100 w-100 ">
                      Some quick example text to build on the card title and
                      make up the bulk of the card's content
                    </p>
                  </div>
                  <div className="slider-service-price ">
                    <p className=" text-black mb-3 h-100 w-100">
                      {donate.Price}
                    </p>
                  </div>

                  <div className="slider-service-btn">
                    <button className="btn btn-primary mt-2 mb-3">
                      <NavLink
                        to={"n"}
                        className="text-decoration-none text-white"
                      >
                        ADD TO CARD
                      </NavLink>
                    </button>
                  </div>
                </div>
              </div>
            </NavLink>
          ))}
        </OwlCarousel>
      </section>
      <Footer />
    </>
  );
}
