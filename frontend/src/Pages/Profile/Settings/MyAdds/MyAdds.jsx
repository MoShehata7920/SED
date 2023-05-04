import React from "react";
import "./MyAdds.css";
import Axios from "axios";
import { useEffect, useState } from "react";
import { useParams, Link } from "react-router-dom";

function MyAdds() {
  let { ProductId } = useParams();
  let [Productitems, setProductitems] = useState({});

  window.localStorage.setItem("Productdata", JSON.stringify(Productitems));
  async function GetProductitems(ProductId, callback) {
    let { data } = await Axios.get(
      `http://103.48.193.225:3000/products/product/${ProductId}`
    );
    callback(data.product);
  }
  useEffect(() => {
    GetProductitems(ProductId, setProductitems);
  }, []);

  return (
    <>
      <div className="contanier  ">
        <div className="row vh-100 flex-column align-items-center justify-content-center ">
          <div className="col-9 product-div  rounded-3 bg-light">
            <div className="row">
              <div className="col-4 ">
                <div className="photo-div bg-black h-75  rounded-3">
                  <img
                    src={Productitems.productImage}
                    className=" w-100 h-100 "
                    alt="..."
                  />
                </div>
              </div>
              <div className=" offset-4 mt-4 col-4  ">
                <div className=" mt-5 text-center">
                  <h3 className="mt-5"> {Productitems.productName} </h3>
                  <h6 className="mt-5 fs-4 mb-4">
                    Price: {Productitems.price}
                  </h6>
                  <div
                    class="modal"
                    id="exampleModal"
                    tabindex="-1"
                    aria-labelledby="exampleModalLabel"
                    aria-hidden="true"
                  >
                    <div class="modal-dialog modal-dialog-scrollable ">
                      <div class="modal-content">
                        <div class="modal-header ">
                          <h5 class="modal-title " id="exampleModalLabel">
                            Product Description
                          </h5>
                          <button
                            type="button"
                            class="btn-close"
                            data-bs-dismiss="modal"
                            aria-label="Close"
                          ></button>
                        </div>
                        <div class="modal-body">
                          <p className=" mt-3   ">{Productitems.description}</p>
                        </div>
                        <div class="modal-footer">
                          <button
                            type="button"
                            class="btn btn-secondary"
                            data-bs-dismiss="modal"
                          >
                            Close
                          </button>
                        </div>
                      </div>
                    </div>
                  </div>
                  <button
                    type="button"
                    class="btn btn-primary btn-lg mt-3"
                    data-bs-toggle="modal"
                    data-bs-target="#exampleModal"
                  >
                    Product Details
                  </button>
                </div>
                <div className="mt-5 text-center">
                  <Link to={`/Product_Editing/${Productitems._id}`}>
                    <button className=" btn-items">Edit</button>
                  </Link>
                </div>
              </div>
            </div>
          </div>
        </div>
      </div>
    </>
  );
}
export default MyAdds;
