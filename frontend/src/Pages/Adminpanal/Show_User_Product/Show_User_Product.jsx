import "./Sow_User_Product.css";
import { useParams, Link } from "react-router-dom";
import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
import AdminInfo from "../../../Component/AdminInfo/AdminInfo";
export default function ShowUserProduct() {
  let { ProductId } = useParams();
  const GetApi = `/products/product/${ProductId}`;
  const { data, isPending, error } = UseAxiosGet(GetApi);
  let Productitems = data ? data.product : "";
  console.log(Productitems);
  return (
    <>
      <AdminInfo />
      <div className="contanier  ">
        <div className="row  align-items-center justify-content-center mt-5 mb-5  ">
          <div className="col-8 product-div bg-danger  rounded-3 bg-light">
            <div className="row">
              <div className="col-xxl-6 col-xl-6 col-lg-4 col-md-12 col-sm-12 col-12 mb-1">
                <div className="photoADDs-div mt-4 ms-5   rounded-4">
                  <img
                    src={Productitems.productImage}
                    className=" w-100 h-100 rounded-4 "
                    alt="..."
                  />
                </div>
              </div>
              <div className="product-info col-xxl-6 col-xl-6 col-lg-8 col-md-12 col-sm-12 col-12 mt-3">
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
                <div className="mt-5 mb-3 text-center">
                  <Link to={`/Admin/Product_Edit/${Productitems._id}`}>
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
