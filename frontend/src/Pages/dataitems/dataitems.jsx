import { useParams } from "react-router-dom";
import Axios from "axios";
import { useEffect, useState } from "react";
import Navebar from "../../Component/navebar/navbar";
import "./dataitems.css";
import Footer from "../../Component/footer/Footer";

export default function Dataitems() {
  let { id } = useParams();
  let [Detaitmes, setDataitems] = useState({});
  async function Getitems(id, callback) {
    let { data } = await Axios.get(
      `http://103.48.193.225:3000/products/product/${id}`
    );
    callback(data.item);
  }
  useEffect(() => {
    Getitems(id, setDataitems);
  }, []);
  return (
    <>
      <section>
        <Navebar />
      </section>
      <section className=" h-auto">
        <div className="container">
          <div className="row">
            <div className="col-6">
              <div className="photo-div bg-black">
                <img
                  src={Detaitmes.Image}
                  className=" w-100 h-100 "
                  alt="..."
                />
              </div>
            </div>
            <div className="col-6">
              <div className="mt-5">
                <h1 className="">{Detaitmes.Name}</h1>
                <h3 className="mt-5">Price: {Detaitmes.Price} LE</h3>
                <h3 className="mt-5">Product details :-</h3>
                <h5 className="mt-3">{Detaitmes.Descr}</h5>
              </div>
              <div className="mt-5">
                <button className=" btn-items">Contact</button>
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
