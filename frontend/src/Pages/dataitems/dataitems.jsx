import { useParams } from "react-router-dom";
import Axios from "axios";
import { useEffect, useState } from "react";
import Navebar from "../../Component/navebar/navbar";
import "./dataitems.css";
import Footer from "../../Component/footer/Footer";

export default function Dataitems() {
  let { id } = useParams();
  let [Dataitems, setDataitems] = useState({});
  
  async function Getitems(id, callback) {
    let { data } = await Axios.get(
      `http://103.48.193.225:3000/products/product/${id}`
    );
    callback(data.product);
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
          <div className="contanier d-flex justify-content-center align-item-center">
            <div className="product-div row col-lg-9  m-3 d-flex  justify-content-between rounded-3 bg-light pb-3 ">
            
                    <div className="col-6 ">    
                    <div className="photo-div bg-light h-75   mb-3 rounded-3">
                        <img
                        src={Dataitems.productImage}
                        className=" w-100 "
                        alt="..."
                        />
                    </div>
                    </div>
                    <div className="product-info col-6  ">
                        <div className=" mt-5 text-center">
                            <h3 className="mt-5">{Dataitems.productName}</h3>
                            <h6 className="mt-5">Price: {Dataitems.price}</h6>
                            <h4 className="mt-3">Product Details</h4>
                            <p className=" mt-3   ">{Dataitems.description}</p>
                        </div>
                        <div className="mt-5 text-center">
                            <button className=" btn-items">Edit</button>
                        </div>
                    </div>

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
