import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import "./additem.css";
import { UseAxiosPost } from "../../../Component/axios/PostApi/PostApi";
import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
import { useNavigate } from "react-router-dom";
import Userinfo from "../Userinfo/Userinfo";
export default function AddItem() {
  const navigate = useNavigate();
  const [item, setitem] = useState({
    productName: "",
    description: "",
    category: "",
    purpose: "",
    condition: "",
    price: "",
    seller: "",
  });
  const postAPi = "/products/newproduct";
  const GetApi = "/users/get";
  const [selectedFile, setSelectedFile] = useState(null);
  const { data, isPending, error } = UseAxiosGet(GetApi);
  let UserID = data ? data.user._id : null;

  const handleImageChange = (e) => {
    setSelectedFile(e.target.files[0]);
  };
  console.log(selectedFile);
  function getiteminfo(e) {
    let myitem = { ...item };
    myitem[e.target.name] = e.target.value;
    setitem(myitem);
  }

  const formData = new FormData();
  formData.append("productImage", selectedFile);
  formData.append("productName", item.productName);
  formData.append("description", item.description);
  formData.append("category", item.category);
  formData.append("purpose", item.purpose);
  formData.append("condition", item.condition);
  formData.append("price", item.price);
  formData.append("seller", UserID);

  for (var pair of formData.entries()) {
    console.log(pair[1] + ", " + pair[0]);
  }
  const {
    response,
    data: Data,
    ErrorMessage,
    HandelPostApi,
  } = UseAxiosPost(postAPi, formData);
  const itemsubmit = (e) => {
    e.preventDefault();
    HandelPostApi();
  };

  useEffect(() => {
    if (response) {
      toast(`✔️ ${response}`);
      setTimeout(() => {
        navigate("/Profile/notification");
      }, 5000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} please fill all input field`);
    }
  }, [response, ErrorMessage, data]);
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
                    <h1>Add product</h1>
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
                    <i class="icon ion-md-lock"></i> Add Product
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
