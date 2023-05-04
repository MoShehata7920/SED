import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { Link, useParams } from "react-router-dom";
import "./Product_editing.css";
import Axios from "axios";

export default function Product_Editing() {
  let { Product_id } = useParams();
  const [ProductEdit, setProductEdit] = useState({
    productName: "",
    price: "",
    description: "",
  });
  const [UserToken, setUserToken] = useState("");
  const [ImgUrl, setImgUrl] = useState("");
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
  formData.append("productImage", selectedFile);
  formData.append("productName", ProductEdit.productName);
  formData.append("price", ProductEdit.price);
  formData.append("description", ProductEdit.description);
  for (var pair of formData.entries()) {
    console.log(pair[1] + ", " + pair[0]);
  }

  const handleUrlSubmit = (event) => {
    fetch(ImgUrl)
      .then((response) => response.blob())
      .then((blob) => {
        const file = new File([blob], "image.jpg", { type: "image/jpeg" });
        setSelectedFile(file);
        setImgUrl("");
      });
  };
  async function itemsubmit(e) {
    e.preventDefault();

    let request = await Axios.patch(
      `http://103.48.193.225:3000/products/product/${Product_id}`,
      formData,
      {
        headers: {
          Authentication: `Bearer ${UserToken}`,
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
      `http://103.48.193.225:3000/products/product/${Product_id}`,
      {
        headers: {
          Authentication: `Bearer ${UserToken}`,
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
    setUserToken(window.localStorage.getItem("usertoken"));
    const storedUserData = window.localStorage.getItem("Productdata");
    const parsedUserData = JSON.parse(storedUserData);
    setProductEdit({
      ...ProductEdit,
      productName: parsedUserData.productName,
      price: parsedUserData.price,
      description: parsedUserData.description,
    });
    setImgUrl(parsedUserData.productImage);
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
    handleUrlSubmit();
  }, [response, ErrorMessage]);
  return (
    <>
      <div className="container  ">
        <div className="row vh-100  flex-column align-items-center justify-content-center   ">
          <div className=" col-8 rounded-3 border border-dark  pt-3 pb-3">
            <form onSubmit={itemsubmit} className="row mt-3 ">
              <div className=" offset-1 col-4 ">
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

                <div class="mb-3 "></div>
                <div class="mb-3">
                  <label class="form-label">Product IMG </label>
                  <input
                    onChange={handleImageChange}
                    class="form-control"
                    type="file"
                    id="formFile"
                  />
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
              <div className="mb-3 mt-3 d-flex justify-content-center ">
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
            <form onSubmit={itemRemove} action="">
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
