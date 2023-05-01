import React, { useEffect, useState } from "react";
import Footer from "../../Component/footer/Footer";
import Navebar from "../../Component/navebar/navbar";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";

import "./additem.css";
import axios from "axios";

export default function AddItem() {
  const [item, setitem] = useState({
    productName: "",
    description: "",
    category: "",
    purpose: "",
    condition: "",
    price: "",
    seller: "",
  });

  const [UserID, setUserID] = useState("");
  console.log(UserID);
  const [UserToken, setUserToken] = useState("");
  console.log(UserToken);
  console.log(item);
  const [selectedFile, setSelectedFile] = useState(null);
  const [response, setResponse] = useState("");
  const [ErrorMessage, setErrorMessage] = useState("");
  console.log(response);
  console.log(ErrorMessage);

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

  async function itemsubmit(e) {
    e.preventDefault();

    let request = await axios
      .post("http://103.48.193.225:3000/products/newproduct", formData, {
        headers: {
          Authentication: `Bearer ${UserToken}`,
        },
      })
      .then((response) => {
        setResponse(response.data.message);
      })
      .catch((error) => {
        // check for the response property of the error object
        if (error.response) {
          // set the error message state variable with the error message
          setErrorMessage(error.response.data.message);
        }
      });
  }

  useEffect(() => {
    setUserToken(window.localStorage.getItem("usertoken"));
    const storedUserData = window.localStorage.getItem("UserData");
    const parsedUserData = JSON.parse(storedUserData);
    setUserID(parsedUserData.user._id);
    if (response) {
      toast(`✔️ ${response}`);
      setTimeout(() => {
        window.location.reload();
      }, 5000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} please fill all input field`);
    }
  }, [response, ErrorMessage]);
  return (
    <>
      <section>
        <Navebar />
      </section>
      <section>
        <div className="container-fluid additembackground">
          <div className="row ">
            <div className=" offset-2 col-8 mt-4 mb-4  ">
              <div className="ADDitemparent py-1">
                <form
                  onSubmit={itemsubmit}
                  enctype="multipart/form-data"
                  className=" d-flex flex-column  align-items-center"
                >
                  <div className="mt-5">
                    <h5 className="">Product Name</h5>
                  </div>
                  <div class="input-group  w-75">
                    <input
                      name="productName"
                      onChange={getiteminfo}
                      type="text"
                      class="form-control"
                      placeholder="Product Name"
                      aria-label="Username"
                      aria-describedby="addon-wrapping"
                    />
                  </div>
                  <div className="mt-5">
                    <h5 className="">category</h5>
                  </div>
                  <div className="input-group  w-75 ">
                    <label
                      className="input-group-text"
                      for="inputGroupSelect01"
                    >
                      Options
                    </label>
                    <select
                      name="category"
                      onChange={getiteminfo}
                      className="form-select"
                      id="inputGroupSelect01"
                    >
                      <option selected>Chose Your Category</option>
                      <option value="Electronics">Electronics</option>
                      <option value="Fasion">Fasion</option>
                      <option value="Furniture">Furniture</option>
                      <option value="Sports">Sports</option>
                      <option value="Supermarket">Supermarket</option>
                      <option value="Vehicles">Vehicles</option>
                      <option value="Books">Books</option>
                      <option value="Other">Other</option>
                      <option value="Phones&Tablets">Phones&Tablets</option>
                      <option value="Body&HealthCare">Body&HealthCare</option>
                    </select>
                  </div>
                  <div className="mt-5">
                    <h5 className="">purpose</h5>
                  </div>
                  <div className="input-group  w-75 ">
                    <label
                      className="input-group-text"
                      for="inputGroupSelect01"
                    >
                      Options
                    </label>
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
                  </div>
                  <div className="mt-5">
                    <h5 className="">Product Price</h5>
                  </div>
                  <div class="input-group w-75 ">
                    <span class="input-group-text">LE</span>
                    <input
                      name="price"
                      onChange={getiteminfo}
                      type="text"
                      class="form-control"
                      aria-label="Amount (to the nearest dollar)"
                    />
                    <span class="input-group-text">.00</span>
                  </div>
                  <div className="mt-5">
                    <h5 className="">Product description</h5>
                  </div>
                  <div class="input-group w-75 ">
                    <span class="input-group-text">DESC</span>
                    <textarea
                      name="description"
                      onChange={getiteminfo}
                      class="form-control"
                      aria-label="With textarea"
                    ></textarea>
                  </div>
                  <div className="mt-5">
                    <h5 className="">Condition</h5>
                  </div>
                  <div className="input-group  w-75 ">
                    <label
                      className="input-group-text"
                      for="inputGroupSelect01"
                    >
                      Options
                    </label>
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
                  </div>
                  <div className="mt-5">
                    <h5 className="">Product Iamge</h5>
                  </div>
                  <div class="">
                    <input
                      onChange={handleImageChange}
                      class="form-control"
                      type="file"
                      id="formFile"
                    />
                  </div>

                  <button
                    type="submit"
                    class="btn btn-primary fs-4 mt-5 additem_button rounded-5 mb-3"
                  >
                    Submit
                  </button>

                  <ToastContainer />
                </form>
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
