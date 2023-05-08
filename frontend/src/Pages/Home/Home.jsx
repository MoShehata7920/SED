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
  let [carousel, setcarousel] = useState([]);
  let [Detasell, setDetasell] = useState([]);
  let [Detadonat, setDetadonat] = useState([]);
  let [Userdata, setUserdata] = useState([]);
  let [Detaexchange, setDetaexchange] = useState([]);
  let [categories, setcategories] = useState([]);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState(null);
  const storedToken = localStorage.getItem("usertoken");
  window.localStorage.setItem("UserData", JSON.stringify(Userdata));
  const GetDeta = async () => {
    setError(null);
    setIsPending(true);

    try {
      let respond = await Axios.get(`http://47.243.7.214:3000/home`);
      setcarousel(respond.data.carousel.Images);
      setDetasell(respond.data.sellItems);
      setDetadonat(respond.data.donateItems);
      setDetaexchange(respond.data.exchangeItems);
      setcategories(respond.data.categories);
      setIsPending(false);
      // setError(null);
    } catch (err) {
      setIsPending(false);
      setError("could not fetch the data");
      console.log(err.message);
    }
  };
  const GetUserDeta = async () => {
    setError(null);
    setIsPending(true);

    try {
      let User = await Axios.get(`http://47.243.7.214:3000/users/get`, {
        headers: {
          Authentication: `Bearer ${storedToken}`,
        },
      });
      setUserdata(User.data);
      setIsPending(false);
      // setError(null);
    } catch (err) {
      setIsPending(false);
      setError("could not fetch the data");
      console.log(err.message);
    }
  };
  useEffect(() => {
    GetDeta();
    GetUserDeta();
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
            {carousel.map((carous, carousindex) => (
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
          <Swiper
            pagination={{
              clickable: true,
            }}
            modules={[Pagination]}
            className=" mySwiper"
            slidesPerView={6}
            spaceBetween={20}
            breakpoints={{
              0: {
                slidesPerView: 1,
              },
              400: {
                slidesPerView: 1,
              },
              500: {
                slidesPerView: 2,
              },
              600: {
                slidesPerView: 2,
              },
              639: {
                slidesPerView: 2,
              },
              750: {
                slidesPerView: 3,
              },
              865: {
                slidesPerView: 3,
              },
              1000: {
                slidesPerView: 4,
              },
              1500: {
                slidesPerView: 5,
              },
              1700: {
                slidesPerView: 7,
              },
              2560: {
                slidesPerView: 8,
              },
              3840: {
                slidesPerView: 9,
              },
              4096: {
                slidesPerView: 10,
              },
              5120: {
                slidesPerView: 11,
              },
            }}
          >
            {categories.map((category, categoryindex) => (
              <SwiperSlide key={categoryindex} className="mb-3">
                <Link
                  to={`/Categories/${category.name}`}
                  className="  text-decoration-none"
                >
                  <div className="catogiry-div  position-relative  ">
                    <div className=" position-absolute h-100 w-100">
                      <img
                        className="catogiry-img w-100 h-100"
                        src={category.image}
                        alt=""
                      />
                    </div>
                    <div className=" catogiry-text  w-100 text-center text-black">
                      <h4 className=" pb-3 ">{category.name}</h4>
                    </div>
                  </div>
                </Link>
              </SwiperSlide>
            ))}
          </Swiper>
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
      <section className="pt-5  ">
        <Swiper
          pagination={{
            clickable: true,
          }}
          modules={[Pagination]}
          className=" mySwiper"
          slidesPerView={6}
          breakpoints={{
            0: {
              slidesPerView: 1,
            },
            400: {
              slidesPerView: 1,
            },
            500: {
              slidesPerView: 2,
            },
            600: {
              slidesPerView: 2,
            },
            639: {
              slidesPerView: 2,
            },
            750: {
              slidesPerView: 3,
            },
            865: {
              slidesPerView: 3,
            },
            1000: {
              slidesPerView: 4,
            },
            1500: {
              slidesPerView: 5,
            },
            1700: {
              slidesPerView: 7,
            },
            2560: {
              slidesPerView: 8,
            },
            3840: {
              slidesPerView: 9,
            },
            4096: {
              slidesPerView: 10,
            },
            5120: {
              slidesPerView: 11,
            },
          }}
        >
          <SwiperSlide>
            <div className="item text-center">
              <h1 className=" fs-10 ">SELL</h1>
              <Link to={"/SeeAllData/sell"}>
                <p className="text-black fs-3 "> see all</p>
              </Link>
            </div>
          </SwiperSlide>

          {Detasell.map((sell, index) => (
            <SwiperSlide
              key={index}
              className="mb-5 d-flex justify-content-center"
            >
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
          slidesPerView={6}
          breakpoints={{
            0: {
              slidesPerView: 1,
            },
            400: {
              slidesPerView: 1,
            },
            500: {
              slidesPerView: 2,
            },
            600: {
              slidesPerView: 2,
            },
            639: {
              slidesPerView: 2,
            },
            750: {
              slidesPerView: 3,
            },
            865: {
              slidesPerView: 3,
            },
            1000: {
              slidesPerView: 4,
            },
            1500: {
              slidesPerView: 5,
            },
            1700: {
              slidesPerView: 7,
            },
            2560: {
              slidesPerView: 8,
            },
            3840: {
              slidesPerView: 9,
            },
            4096: {
              slidesPerView: 10,
            },
            5120: {
              slidesPerView: 11,
            },
          }}
        >
          <SwiperSlide>
            <div className="item text-center">
              <h1 className=" fs-9 ">EXCHANGE</h1>
              <Link to={"/SeeAllData/exchange"}>
                <p className="text-black fs-3 "> see all</p>
              </Link>
            </div>
          </SwiperSlide>

          {Detaexchange.map((exchange, ind) => (
            <SwiperSlide
              key={ind}
              className="mb-5 d-flex justify-content-center"
            >
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
      <section className="pt-5 pb-5  ">
        <Swiper
          pagination={{
            clickable: true,
          }}
          modules={[Pagination]}
          className=" mySwiper"
          slidesPerView={6}
          breakpoints={{
            0: {
              slidesPerView: 1,
            },
            400: {
              slidesPerView: 1,
            },
            500: {
              slidesPerView: 2,
            },
            600: {
              slidesPerView: 2,
            },
            639: {
              slidesPerView: 2,
            },
            750: {
              slidesPerView: 3,
            },
            865: {
              slidesPerView: 3,
            },
            1000: {
              slidesPerView: 4,
            },
            1500: {
              slidesPerView: 5,
            },
            1700: {
              slidesPerView: 7,
            },
            2560: {
              slidesPerView: 8,
            },
            3840: {
              slidesPerView: 9,
            },
            4096: {
              slidesPerView: 10,
            },
            5120: {
              slidesPerView: 11,
            },
          }}
        >
          <SwiperSlide>
            <div className="item text-center">
              <h1 className=" fs-9 ">DONATE</h1>
              <Link to={"/SeeAllData/donate"}>
                <p className="text-black fs-3 "> see all</p>
              </Link>
            </div>
          </SwiperSlide>
          {Detadonat.map((donate, donateindex) => (
            <SwiperSlide
              key={donateindex}
              className="mb-5 d-flex justify-content-center"
            >
              <DonateSlider donate={donate} />
            </SwiperSlide>
          ))}
        </Swiper>
      </section>
      <section>
        <Footer />
      </section>
    </>
  );
}
