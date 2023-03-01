import Navebar from "../../Component/navebar/navbar";
import "./Home.css";
import "react-responsive-carousel/lib/styles/carousel.css";
import OwlCarousel from "react-owl-carousel";
import { Link } from "react-router-dom";

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
                    src="https://images.squarespace-cdn.com/content/v1/5ac9090375f9ee6977f62f78/1617131058314-3XXR26SRD2MAGAI4L81J/Final-Broken.gif"
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
                    src="http://rotoscopers.com/wp-content/uploads/2016/03/tumblr_nv2kw8bvQx1tq4of6o1_500.gif"
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
                    src="https://www.xiaomitoday.it/wp-content/uploads/2019/06/bc82f211cbe2ff0765d9deabffcd869f.gif"
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
                    src="https://miro.medium.com/max/1400/1*iO7pN-_Ym9fAjlL7sFHl4w.gif"
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
                    src="https://cdn.media.amplience.net/i/xcite/152-Feb-Kuwait-website-mockup-LA?img404=default&w=1080&qlt=75&fmt=auto"
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
                    src="https://cdn.media.amplience.net/i/xcite/152-Feb-Kuwait-website-mockup-SA?img404=default&w=1080&qlt=75&fmt=auto"
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
                    className="catogiry-img w-100 h-100"
                    src="https://cdn.media.amplience.net/i/xcite/152-Feb-Kuwait-website-mockup-Gaming?img404=default&w=1080&qlt=75&fmt=auto"
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
                    src="https://cdn.media.amplience.net/i/xcite/Under10KD-Web-EN?img404=default&w=1080&qlt=75&fmt=auto"
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
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/620930-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/620930-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/620930-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/620930-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/620930-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/620930-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/620930-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/620930-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/620930-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
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
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/534048-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/534048-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/534048-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/534048-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/534048-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/534048-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/534048-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/534048-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/534048-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
          <Link to={"na"} className="text-decoration-none ">
            <div className="item slider-style2 mb-1">
              <div className="slider-service-div  text-center  ">
                <div className="slider-service-img ">
                  <img
                    src="https://cdn.media.amplience.net/s/xcite/534048-SET?img404=default&w=1080&qlt=75&fmt=auto"
                    className="card-img-top w-100 h-100  "
                    alt="..."
                  />
                </div>

                <div className="slider-service-title">
                  <h5 className="card-title text-black mb-3 mt-3">
                    Card title
                  </h5>
                </div>
                <div className="slider-service-detailes ">
                  <p className=" text-black  h-100 w-100 ">
                    Some quick example text to build on the card title and make
                    up the bulk of the card's content
                  </p>
                </div>
                <div className="slider-service-price ">
                  <p className=" text-black mb-3 h-100 w-100">1500 EP</p>
                </div>

                <div className="slider-service-btn">
                  <button className="btn btn-primary mt-2 mb-3">
                    <Link to={"n"} className="text-decoration-none text-white">
                      ADD TO CARD
                    </Link>
                  </button>
                </div>
              </div>
            </div>
          </Link>
        </OwlCarousel>
      </section>
    </>
  );
}
