import Footer from "../../Component/footer/Footer";
import Navebar from "../../Component/navebar/navbar";
import { Link, useSearchParams } from "react-router-dom";
import { useEffect, useState } from "react";
import { UseAxiosGet } from "../../Component/axios/GetApi/GetApi";

export default function SearchPage() {
  const [searchParams] = useSearchParams();
  const greeting = searchParams.get("query");
  const GetApi = `/products/search?search=${greeting}`;
  const { data, isPending, error } = UseAxiosGet(GetApi);
  let Searchdata = data ? data.items : [];
  return (
    <>
      <section>
        <Navebar />
      </section>

      <section className="mt-5">
        <div className="container">
          <div className="row">
            {Searchdata.map((search, index) => (
              <div className="col-3">
                <Link
                  key={index}
                  to={`/items/${search._id}`}
                  className="text-decoration-none "
                >
                  <div className="item slider-style2 mb-1 ">
                    <div className="slider-service-div  text-center  ">
                      <div className="slider-service-img ">
                        <img
                          src={search.productImage}
                          className="card-img-top w-100 h-100  "
                          alt="..."
                        />
                      </div>

                      <div className="slider-service-title">
                        <h5 className="card-title text-black mb-3 mt-3">
                          {search.productName}
                        </h5>
                      </div>
                      <div className="slider-service-detailes ">
                        <p className=" text-black  h-100 w-100 ">
                          {search.description}
                        </p>
                      </div>
                      <div className="slider-service-price ">
                        <p className=" text-black mb-3 h-100 w-100">
                          {search.price}
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
      </section>

      <section>
        <Footer />
      </section>
    </>
  );
}
