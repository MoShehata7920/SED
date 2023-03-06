import Navebar from "../../Component/navebar/navbar";
import "./Home.css";
import "react-responsive-carousel/lib/styles/carousel.css";
import OwlCarousel from "react-owl-carousel";
import { Link } from "react-router-dom";
import Axios from "axios";
import { useEffect, useState } from "react";

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
    console.log(data.items);
    callback(data.items);
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
          <div className="item">
            <img
              className=""
              src="https://thumbs.dreamstime.com/b/lake-clouds-sky-water-panoramic-panorama-banner-15611956.jpg"
              alt=""
            />
          </div>
          <div className="item">
            <img
              src="https://media.istockphoto.com/id/163196980/photo/sunset-panorama.jpg?s=612x612&w=0&k=20&c=kHv1TLoxBv5D2wZVnFUvyrU4KFbvJ9tEiXoG7h9y6ig="
              alt=""
            />
          </div>
          <div className="item">
            <img
              src="https://images.pexels.com/photos/358482/pexels-photo-358482.jpeg?cs=srgb&dl=pexels-pixabay-358482.jpg&fm=jpg"
              alt=""
            />
          </div>
          <div className="item">
            <img
              src="https://expertphotography.b-cdn.net/wp-content/uploads/2020/02/Photoshop.panorama.stitch.mishra.chicago.skyline-1024x290.jpg"
              alt=""
            />
          </div>
          <div className="item">
            <img
              src="https://www.kraftwerk.at/app/uploads/fly-images/962/reference-img-worlds-of-adventure-park-4-1920x9999.jpg"
              alt=""
            />
          </div>
          <div className="item">
            <img
              src="https://www.kraftwerk.at/app/uploads/fly-images/962/reference-img-worlds-of-adventure-park-4-1920x9999.jpg"
              alt=""
            />
          </div>
          <div className="item">
            <img
              src="https://www.kraftwerk.at/app/uploads/fly-images/962/reference-img-worlds-of-adventure-park-4-1920x9999.jpg"
              alt=""
            />
          </div>
          <div className="item">
            <img
              src="https://www.kraftwerk.at/app/uploads/fly-images/962/reference-img-worlds-of-adventure-park-4-1920x9999.jpg"
              alt=""
            />
          </div>
          <div className="item">
            <img
              src="https://www.kraftwerk.at/app/uploads/fly-images/962/reference-img-worlds-of-adventure-park-4-1920x9999.jpg"
              alt=""
            />
          </div>
          <div className="item">
            <img
              src="https://www.kraftwerk.at/app/uploads/fly-images/962/reference-img-worlds-of-adventure-park-4-1920x9999.jpg"
              alt=""
            />
          </div>
        </OwlCarousel>
      </section>
      <section>
        <div className="row">
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <Link to={"a"} className="  text-decoration-none">
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
            </Link>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12">
            <Link to={"a"} className=" text-decoration-none">
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
            </Link>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <Link to={"a"} className="  text-decoration-none">
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
            </Link>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <Link to={"a"} className="  text-decoration-none  ">
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
            </Link>
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
            <Link to={"a"} className="  text-decoration-none">
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
            </Link>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12">
            <Link to={"a"} className=" text-decoration-none">
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
            </Link>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <Link to={"a"} className="  text-decoration-none">
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
            </Link>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <Link to={"a"} className="  text-decoration-none  ">
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
            </Link>
          </div>
        </div>
      </section>
      <section className="pt-5  ">
        <OwlCarousel className=" owl-theme  " {...options2}>
          <div className="item text-center">
            <h1 className=" fs-10 ">SELL</h1>
            <Link to={"a"}>
              <p className="text-black fs-3 "> see all</p>
            </Link>
          </div>
          {Detasell.map((sell, index) => (
            <Link
              key={sell.id}
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
          ))}
        </OwlCarousel>
      </section>
      <section className="pt-5  ">
        <OwlCarousel className=" owl-theme  " {...options2}>
          <div className="item text-center">
            <h1 className=" fs-9 ">EXCHANGE</h1>
            <Link to={"a"}>
              <p className="text-black fs-3 "> see all</p>
            </Link>
          </div>
          {Detaexchange.map((exchange, ind) => (
            <Link
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
          ))}
        </OwlCarousel>
      </section>
      <section className="pt-5  ">
        <OwlCarousel className=" owl-theme  " {...options2}>
          <div className="item text-center">
            <h1 className=" fs-9 ">DONATE</h1>
            <Link to={"a"}>
              <p className="text-black fs-3 "> see all</p>
            </Link>
          </div>
          {Detadonat.map((donate, ind) => (
            <Link
              key={ind}
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
          ))}
        </OwlCarousel>
      </section>
      <footer className=" h-auto footer-div mt-5">
        <div className="container">
          <div className="row">
            <div className="col-6">
              <div className="app-div mt-5 rounded-3">
                <h5 className="ms-3 pt-2 pb-1">Download Our App</h5>
                <div className="app-content d-flex justify-content-center ">
                  <div className="app-img me-2 ">
                    <a href="a" className="w-100">
                      <img
                        className="w-100"
                        src="https://cdn.media.amplience.net/i/xcite/Download_on_the_App_Store_Badge2?img404=default&w=384&qlt=75&fmt=auto"
                        alt=""
                      />
                    </a>
                  </div>
                  <div className="app-img">
                    <a href="a" className="w-100">
                      <img
                        className="w-100"
                        src="https://cdn.media.amplience.net/i/xcite/Google_Play_Store_badge_EN2?img404=default&w=384&qlt=75&fmt=auto"
                        alt=""
                      />
                    </a>
                  </div>
                </div>
              </div>
            </div>
          </div>
        </div>
        <div className="line-footer mt-5"></div>
        <div className="container mt-5">
          <div className="row">
            <div className="col-3">
              <div className="footer-text1 text-white">
                <h1 className="mb-3">SED</h1>
                <p className=" fs-7">
                  Xcite: The Ultimate Online Shopping Destination in Kuwait |
                  Buy 100% genuine consumer electronics and home appliances from
                  Xcite, the largest online electronics store in Kuwait.
                </p>
              </div>
            </div>
            <div className="col-3 mt-2">
              <div className="footer-text2 text-white ">
                <h5 className="mb-4">General Information</h5>
                <a href="a" className=" d-block mb-3">
                  Help
                </a>
                <a href="a" className=" d-block mb-3">
                  About X-cite
                </a>
                <a href="a" className=" d-block mb-3">
                  Privacy Policy
                </a>
                <a href="a" className=" d-block mb-3">
                  Frequently Asked Questions
                </a>
                <a href="a" className=" d-block">
                  Terms & Conditions
                </a>
              </div>
            </div>
            <div className="col-3 mt-2">
              <div className="footer-text2 text-white ">
                <h5 className="mb-4">Our Services</h5>
                <a href="a" className=" d-block mb-3">
                  Pay Monthly Installments
                </a>
                <a href="a" className=" d-block mb-3">
                  Service Centers
                </a>
                <a href="a" className=" d-block mb-3">
                  Contact Us
                </a>
                <a href="a" className=" d-block mb-3">
                  Quick Delivery & Installation
                </a>
                <a href="a" className=" d-block mb-3">
                  Buyer Protection
                </a>
                <a href="a" className=" d-block mb-3">
                  X-cite Secure Shopping
                </a>
                <a href="a" className=" d-block mb-3">
                  B2B - Corporate Sales
                </a>
              </div>
            </div>
            <div className="col-3 mt-2">
              <div className="footer-text2 text-white ">
                <h5 className="mb-4">Highlights</h5>
                <a href="a" className=" d-block mb-3">
                  flyer
                </a>
                <a href="a" className=" d-block mb-3">
                  X-cite Mobile App
                </a>
              </div>
            </div>
          </div>
        </div>
        <div className="line-footer mt-5"></div>
        <h5 className="text-white mt-4 pb-5">
          © 2023 X-cite General Trading Co. S.A.K. (C)
        </h5>
      </footer>
    </>
  );
}
