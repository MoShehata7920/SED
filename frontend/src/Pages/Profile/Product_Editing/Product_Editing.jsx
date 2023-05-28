import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { Link, useParams } from "react-router-dom";
import "./Product_editing.css";
import Navebar from "../../../Component/navebar/navbar";
import { UseAxiosPache } from "../../../Component/axios/PachApi/PatchApi";
import { UseAxiosDelete } from "../../../Component/axios/DeleteApi/DeleteApi";
export default function ProductEditing() {
  let { Product_id } = useParams();
  const [ProductEdit, setProductEdit] = useState({
    productName: "",
    price: "",
    description: "",
    category: "",
    condition: "",
    purpose: "",
  });
  const postAPi = `/products/product/${Product_id}`;
  const deleteAPi = `/products/product/${Product_id}`;
  const [selectedFile, setSelectedFile] = useState(null);
  const handleImageChange = (e) => {
    setSelectedFile(e.target.files[0]);
  };
  console.log(selectedFile);
  function getUserinfo(e) {
    let myinfo = { ...ProductEdit };
    myinfo[e.target.name] = e.target.value;
    setProductEdit(myinfo);
  }
  const formData = new FormData();
  if (selectedFile) {
    formData.append("productImage", selectedFile);
  }
  if (ProductEdit.productName) {
    formData.append("productName", ProductEdit.productName);
  }
  if (ProductEdit.price) {
    formData.append("price", ProductEdit.price);
  }
  if (ProductEdit.description) {
    formData.append("description", ProductEdit.description);
  }
  if (ProductEdit.category) {
    formData.append("category", ProductEdit.category);
  }
  if (ProductEdit.condition) {
    formData.append("condition", ProductEdit.condition);
  }
  if (ProductEdit.purpose) {
    formData.append("purpose", ProductEdit.purpose);
  }
  for (var pair of formData.entries()) {
    console.log(pair[1] + ", " + pair[0]);
  }
  const {
    response: postresponse,
    ErrorMessage: postErrorMessage,
    HandelPachApi,
  } = UseAxiosPache(postAPi, formData);
  const {
    response: deleteresponse,
    ErrorMessage: deleteErrorMessage,
    HandelDeleteApi,
  } = UseAxiosDelete(deleteAPi);

  async function itemsubmit(e) {
    e.preventDefault();
    HandelPachApi();
  }

  async function itemRemove(e) {
    e.preventDefault();
    HandelDeleteApi();
  }
  useEffect(() => {
    if (deleteresponse) {
      toast(`✔️ ${deleteresponse}`);
      setTimeout(() => {
        localStorage.removeItem("Productdata");
        window.location.href = "/Profile/userinfo";
      }, 3000);
    }
    if (deleteErrorMessage && deleteresponse == "") {
      toast(`❌ ${deleteErrorMessage} `);
    }
    if (postresponse) {
      toast(`✔️ ${postresponse}`);
      setTimeout(() => {
        localStorage.removeItem("Productdata");
        window.location.href = "/Profile/userinfo";
      }, 3000);
    }
    if (postErrorMessage && postresponse == "") {
      toast(`❌ ${postErrorMessage} `);
    }
  }, [postresponse, deleteresponse]);
  return (
    <>
      <section>
        <Navebar />
      </section>
      <div className="container  ">
        <div className="row vh-100  flex-column align-items-center justify-content-center   ">
          <div className=" col-xxl-8 col-xl-8 col-lg-10 col-md-10 col-sm-12 col-12  rounded-3 border border-dark  pt-3 pb-3">
            <form onSubmit={itemsubmit} className="row mt-3 ">
              <div className=" ms-4 col-5 ">
                <div class="mb-3">
                  <label class="form-label">Product_name </label>
                  <input
                    placeholder={ProductEdit.productName}
                    name="productName"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                    aria-describedby="priceHelp"
                  ></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">price </label>
                  <input
                    placeholder={ProductEdit.price}
                    name="price"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                  ></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">Description</label>
                  <input
                    placeholder={ProductEdit.description}
                    name="description"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                  ></input>
                </div>
              </div>
              <div className=" offset-1 col-5 ">
                <div class="mb-3">
                  <label class="form-label">Condition </label>
                  <input
                    placeholder={ProductEdit.condition}
                    name="productName"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                    aria-describedby="priceHelp"
                  ></input>
                </div>

                <div class="mb-3">
                  <label class="form-label">Purpose </label>
                  <input
                    placeholder={ProductEdit.purpose}
                    name="price"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                  ></input>
                </div>
                <div class="mb-3">
                  <label class="form-label">Category</label>
                  <input
                    placeholder={ProductEdit.category}
                    name="description"
                    onChange={getUserinfo}
                    type="text"
                    class="form-control"
                  ></input>
                </div>
              </div>
              <div class="mb-3  d-flex flex-column align-items-center justify-content-center ">
                <label class="form-label">Product IMG </label>
                <input
                  onChange={handleImageChange}
                  class="form-control w-50"
                  type="file"
                  id="formFile"
                />
              </div>
              <div className="mb-3 mt-3  d-flex  justify-content-center ">
                <button type="submit" class="btn btn-primary me-4 ">
                  Save Changes
                </button>

                <Link to={"/Profile/userinfo"}>
                  <button type="button" class="btn btn-primary  ">
                    Cancel
                  </button>
                </Link>
              </div>
              <ToastContainer />
            </form>
            <form
              onSubmit={itemRemove}
              action=""
              className="d-flex  justify-content-end"
            >
              <button type="submit" class="btn btn-primary me-4 ">
                Remove
              </button>
            </form>
          </div>
        </div>
      </div>
    </>
  );
}
