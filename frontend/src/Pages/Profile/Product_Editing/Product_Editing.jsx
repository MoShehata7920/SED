import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { Link, useNavigate, useParams } from "react-router-dom";
import "./Product_editing.css";
import Navebar from "../../../Component/navebar/navbar";
import { UseAxiosPache } from "../../../Component/axios/PachApi/PatchApi";
import { UseAxiosDelete } from "../../../Component/axios/DeleteApi/DeleteApi";
import Userinfo from "../Userinfo/Userinfo";
export default function ProductEditing() {
  const navigate = useNavigate();
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
  function getiteminfo(e) {
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
        navigate("/Profile/notification");
      }, 3000);
    }
    if (deleteErrorMessage && deleteresponse == "") {
      toast(`❌ ${deleteErrorMessage} `);
    }
    if (postresponse) {
      toast(`✔️ ${postresponse}`);
      setTimeout(() => {
        localStorage.removeItem("Productdata");
        navigate("/Profile/notification");
      }, 3000);
    }
    if (postErrorMessage && postresponse == "") {
      toast(`❌ ${postErrorMessage} `);
    }
  }, [postresponse, deleteresponse]);
  return (
    <>
      <Userinfo />
      <section>
        <div className="">
          <div className="row      ">
            <div className="  col-12 ">
              <div className="Card_div  ">
                <form onSubmit={itemsubmit} enctype="multipart/form-data">
                  <div class="segment">
                    <h1>Edit product</h1>
                  </div>

                  <label>
                    <input
                      name="productName"
                      onChange={getiteminfo}
                      type="text"
                      placeholder="Product Name"
                    />
                  </label>
                  <label>
                    <select
                      name="category"
                      onChange={getiteminfo}
                      className="form-select"
                      id="inputGroupSelect01"
                    >
                      <option selected>Chose Your Category</option>
                      <option value="Electronics">Electronics</option>
                      <option value="fasion">Fasion</option>
                      <option value="Furniture">Furniture</option>
                      <option value="Sports">Sports</option>
                      <option value="Supermarket">Supermarket</option>
                      <option value="Vehicles">Vehicles</option>
                      <option value="Books">Books</option>
                      <option value="Other">Other</option>
                      <option value="Phones&Tablets">Phones&Tablets</option>
                      <option value="Body&HealthCare">Body&HealthCare</option>
                    </select>
                  </label>
                  <label>
                    <select
                      name="purpose"
                      onChange={getiteminfo}
                      className="form-select"
                      id="inputGroupSelect01"
                    >
                      <option selected>Chose Your Purpose</option>
                      <option value="sell">Sell</option>
                      <option value="exchange">Exchange</option>
                      <option value="donate">Donate</option>
                    </select>
                  </label>
                  <label>
                    <input
                      name="price"
                      onChange={getiteminfo}
                      type="text"
                      aria-label="Amount (to the nearest dollar)"
                      placeholder="Product Price"
                    />
                  </label>
                  <label>
                    <textarea
                      name="description"
                      onChange={getiteminfo}
                      class="form-control"
                      aria-label="With textarea"
                    ></textarea>
                  </label>
                  <label>
                    <select
                      name="condition"
                      onChange={getiteminfo}
                      className="form-select"
                      id="inputGroupSelect01"
                    >
                      <option selected>Chose The Condition</option>
                      <option value="New">New</option>
                      <option value="Used">Used</option>
                    </select>
                  </label>
                  <label>
                    <input
                      onChange={handleImageChange}
                      type="file"
                      id="formFile"
                    />
                  </label>
                  <button class="red mb-3" type="submit">
                    <i class="icon ion-md-lock"></i> Edit Product
                  </button>
                </form>
                <form onSubmit={itemRemove}>
                  <button class="red mb-3" type="submit">
                    <i class="icon ion-md-lock"></i> Remove
                  </button>
                </form>
              </div>
            </div>
          </div>
          <ToastContainer />
        </div>
      </section>
    </>
  );
}
