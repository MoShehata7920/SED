import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { Link, useParams } from "react-router-dom";
import "./Product_editing.css";
import Axios from "axios";
import Navebar from "../../../Component/navebar/navbar";
import { encrypt, decrypt, compare } from "n-krypta";
export default function ProductEditing() {
  let { Product_id } = useParams();
  const secret = "@#$%abdo@#@$$ezzatQ1234lalls&^";
  const storedEncryptedData = localStorage.getItem("encryptedToken");
  const decryptedData = decrypt(storedEncryptedData, secret);
  const [ProductEdit, setProductEdit] = useState({
    productName: "",
    price: "",
    description: "",
    category: "",
    condition: "",
    purpose: "",
  });
  const [UserToken, setUserToken] = useState("");
  const [selectedFile, setSelectedFile] = useState(null);
  const [response, setResponse] = useState("");
  const [ErrorMessage, setErrorMessage] = useState("");

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

  async function itemsubmit(e) {
    e.preventDefault();

    let request = await Axios.patch(
      `http://47.243.7.214:3000/products/product/${Product_id}`,
      formData,
      {
        headers: {
          Authentication: `Bearer ${decryptedData}`,
        },
      }
    )
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
  async function itemRemove(e) {
    e.preventDefault();

    let request = await Axios.delete(
      `http://47.243.7.214:3000/products/product/${Product_id}`,
      {
        headers: {
          Authentication: `Bearer ${decryptedData}`,
        },
      }
    )
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
    if (response) {
      toast(`✔️ ${response}`);
      setTimeout(() => {
        localStorage.removeItem("Productdata");
        window.location.href = "/Profile/userinfo";
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [response, ErrorMessage]);
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

                <Link
                  to={"/profile/myProduct"}
                  onClick={() => {
                    localStorage.removeItem("Productdata");
                  }}
                >
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
