import Footer from "../../Component/footer/Footer";
import Navebar from "../../Component/navebar/navbar";
import { Link, useParams } from "react-router-dom";
import Axios from "axios";
import { useEffect, useState } from "react";

export default function Categories() {
  let { CategorieType } = useParams();

  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState(null);
  let [Detcateg, setDetcateg] = useState([]);
  console.log(Detcateg);
  const GetCategDeta = async () => {
    setError(null);
    setIsPending(true);

    try {
      let respond = await Axios.get(
        `http://103.48.193.225:3000/products/all/${CategorieType}`
      );
      setDetcateg(respond.data.message);
      setIsPending(false);
      //setError(null);
    } catch (err) {
      setIsPending(false);
      setError("could not fetch the data");
      console.log(err.message);
    }
  };
  useEffect(() => {
    GetCategDeta();
  }, [CategorieType]);
  return (
    <>
      <section>
        <Navebar />
      </section>

      <section className="mt-5">
        <div className="container">
          <div className="row">
            {Detcateg.map((categ, index) => (
              <div className="col-3">
                <Link
                  key={index}
                  to={`/items/${categ.ID}`}
                  className="text-decoration-none "
                >
                  <div className="item slider-style2 mb-1 ">
                    <div className="slider-service-div  text-center  ">
                      <div className="slider-service-img ">
                        <img
                          src={categ.Image}
                          className="card-img-top w-100 h-100  "
                          alt="..."
                        />
                      </div>

                      <div className="slider-service-title">
                        <h5 className="card-title text-black mb-3 mt-3">
                          {categ.Name}
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
                          {categ.Price}
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
