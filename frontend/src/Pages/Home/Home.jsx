import Navebar from "../../Component/navebar/navbar";
import "./Home.css";
import { Swiper, SwiperSlide } from "swiper/react";
import "swiper/css";
import "swiper/css/pagination";
import "swiper/css/navigation";
import { Autoplay, Pagination, Navigation } from "swiper";
import { Link } from "react-router-dom";
import Axios from "axios";
import { useEffect, useState } from "react";
import Footer from "../../Component/footer/Footer";
import ExchangeSlider from "../../Component/exchange_slider/exchange_slider";
import SellSlider from "../../Component/sell_slider/sell_slider";
import DonateSlider from "../../Component/donate_slider/donate_slider";

export default function Home() {
  let [DetaAll, setDetaAll] = useState([]);
  let [Detasell, setDetasell] = useState([]);
  let [Detadonat, setDetadonat] = useState([]);
  let [Detaexchange, setDetaexchange] = useState([]);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState(null);
  const GetDeta = async (mediatype, callback) => {
    setError(null);
    setIsPending(true);

    try {
      let respond = await Axios.get(
        `http://103.48.193.225:9000/home/${mediatype}`,
        {
          headers: {
            Authorization: `6ALOYOMR`,
          },
        }
      );
      if (mediatype === "") {
        callback(respond.data.carousel.Images);
        console.log(respond.data.carousel.Images);
      } else {
        callback(respond.data.items);
        console.log(respond.data.items);
      }

      setIsPending(false);
      //setError(null);
    } catch (err) {
      setIsPending(false);
      setError("could not fetch the data");
      console.log(err.message);
    }
  };

  // async function GetDeta(mediatype, callback) {
  //   let respond = await Axios.get(
  //     `http://103.48.193.225:9000/home/${mediatype}`
  //   );

  //   if (mediatype === "") {
  //     callback(respond.data.carousel.Images);
  //     console.log(respond.data.carousel.Images);
  //   } else {
  //     callback(respond.data.items);
  //     console.log(respond.data.items);
  //   }
  // }

  useEffect(() => {
    GetDeta("", setDetaAll);
    GetDeta("donate", setDetadonat);
    GetDeta("sell", setDetasell);
    GetDeta("exchange", setDetaexchange);
  }, []);
  return (
    <>
      <section>
        <Navebar />
      </section>
      <section className="mb-5">
        <div className="slider-style ">
          <Swiper
            spaceBetween={30}
            centeredSlides={true}
            autoplay={{
              delay: 2500,
              disableOnInteraction: false,
            }}
            pagination={{
              clickable: true,
            }}
            modules={[Autoplay, Pagination, Navigation]}
            className="mySwiper"
          >
            {DetaAll.map((carous, carousindex) => (
              <SwiperSlide key={carousindex}>
                <div className="item">
                  <img className="" src={carous} alt="" />
                </div>
              </SwiperSlide>
            ))}
          </Swiper>
        </div>
      </section>
      <section>
        <div className="row">
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <Link
              to={`/Categories/Electronics`}
              className="  text-decoration-none"
            >
              <div className="catogiry-div  position-relative  ">
                <div className=" position-absolute h-100 w-100">
                  <img
                    className="catogiry-img w-100 h-100"
                    src="https://cdn.media.amplience.net/i/xcite/Ramadan2023-homepage-Phones_2?img404=default&w=1080&qlt=75&fmt=auto"
                    alt=""
                  />
                </div>
                <div className=" catogiry-text  w-100 text-center">
                  <h4 className=" pb-3 ">Electronics</h4>
                </div>
              </div>
            </Link>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12">
            <Link to={`/Categories/Fashion`} className=" text-decoration-none">
              <div className="catogiry-div  position-relative ">
                <div className=" position-absolute w-100 h-100">
                  <img
                    className="catogiry-img w-100 h-100 "
                    src="https://cdn.media.amplience.net/i/xcite/Ramadan2023-homepage-homeentertainment_2?img404=default&w=1080&qlt=75&fmt=auto"
                    alt=""
                  />
                </div>
                <div className=" catogiry-text text-white  w-100 text-center">
                  <h4 className=" pb-3 ">Fashion</h4>
                </div>
              </div>
            </Link>
          </div>
          <div className="col-xxl-3 col-xl-3 col-md-6 col-sm-12  col-12 ">
            <Link to={`/Categories/Fashion`} className="  text-decoration-none">
              <div className="catogiry-div  position-relative   ">
                <div className=" position-absolute w-100 h-100">
                  <img
                    className="catogiry-img w-100 h-100 "
                    src="https://cdn.media.amplience.net/i/xcite/Ramadan2023-homepage-SA_2?img404=default&w=1080&qlt=75&fmt=auto"
                    alt=""
                  />
                </div>
                <div className=" catogiry-text text-white  w-100 text-center">
                  <h4 className=" pb-3 ">Phones & Tablets</h4>
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
                  <h4 className=" pb-3 ms-3 ">Books</h4>
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
                  <h4 className=" pb-3 ">Furniture</h4>
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
                  <h4 className=" pb-3 ">Body & Health Care</h4>
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
                  <h4 className=" pb-3 ms-3 ">Sports</h4>
                </div>
              </div>
            </Link>
          </div>
        </div>
      </section>
      <section className="pt-5  ">
        <Swiper
          pagination={{
            clickable: true,
          }}
          modules={[Pagination]}
          className=" mySwiper"
          spaceBetween={5}
          slidesPerView={5}
        >
          <SwiperSlide>
            <div className="item text-center">
              <h1 className=" fs-10 ">SELL</h1>
              <Link to={"/SeeAllData/Sell"}>
                <p className="text-black fs-3 "> see all</p>
              </Link>
            </div>
          </SwiperSlide>

          {Detasell.map((sell, index) => (
            <SwiperSlide key={index} className="mb-5">
              <SellSlider sell={sell} />
            </SwiperSlide>
          ))}
        </Swiper>
      </section>
      <section className="pt-5  ">
        <Swiper
          pagination={{
            clickable: true,
          }}
          modules={[Pagination]}
          className=" mySwiper"
          spaceBetween={5}
          slidesPerView={5}
        >
          <SwiperSlide>
            <div className="item text-center">
              <h1 className=" fs-9 ">EXCHANGE</h1>
              <Link to={"/SeeAllData/Exchange"}>
                <p className="text-black fs-3 "> see all</p>
              </Link>
            </div>
          </SwiperSlide>

          {Detaexchange.map((exchange, ind) => (
            <SwiperSlide key={ind} className="mb-5">
              <ExchangeSlider exchange={exchange} />
            </SwiperSlide>
          ))}
        </Swiper>
      </section>
      {/* <section className="pt-5  ">
        <OwlCarousel className=" owl-theme  " {...options2}>
          <div className="item text-center">
            <h1 className=" fs-9 ">DONATE</h1>
            <Link to={"a"}>
              <p className="text-black fs-3 "> see all</p>
            </Link>
          </div>
          {Detadonat.map((donate, donateindex) => (
            <DonateSlider key={donateindex} donate={donate} />
          ))}
        </OwlCarousel>
      </section> */}
      <section className="pt-5  ">
        <Swiper
          pagination={{
            clickable: true,
          }}
          modules={[Pagination]}
          className=" mySwiper"
          spaceBetween={5}
          slidesPerView={5}
        >
          <SwiperSlide>
            <div className="item text-center">
              <h1 className=" fs-9 ">DONATE</h1>
              <Link to={"/SeeAllData/Donate"}>
                <p className="text-black fs-3 "> see all</p>
              </Link>
            </div>
          </SwiperSlide>
          {Detadonat.map((donate, donateindex) => (
            <SwiperSlide key={donateindex} className="mb-5">
              <DonateSlider donate={donate} />
            </SwiperSlide>
          ))}
        </Swiper>
      </section>
      <Footer />
    </>
  );
}
