import React, { useState } from "react";
import Footer from "../../Component/footer/Footer";
import Navebar from "../../Component/navebar/navbar";
import ImageUploading from "react-images-uploading";
import "./additem.css";

export default function AddItem() {
  let [] = useState("");
  let [] = useState("");
  let [] = useState("");
  let [] = useState("");
  let [] = useState("");
  let [] = useState("");
  const [image, setImage] = useState(null);
  const [imageUrl, setImageUrl] = useState("");
  console.log(image, imageUrl);
  function handleImageChange(e) {
    const selectedImage = e.target.files[0];

    if (selectedImage) {
      const reader = new FileReader();

      reader.onload = () => {
        setImageUrl(reader.result);
      };

      reader.readAsDataURL(selectedImage);
      setImage(selectedImage);
    }
  }

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
                <div className=" d-flex flex-column  align-items-center">
                  <div className="input-group mb-3 mt-5 w-75 ">
                    <label
                      className="input-group-text"
                      for="inputGroupSelect01"
                    >
                      Options
                    </label>
                    <select className="form-select" id="inputGroupSelect01">
                      <option selected>Choose...</option>
                      <option value="1">One</option>
                      <option value="2">Two</option>
                      <option value="3">Three</option>
                    </select>
                  </div>
                  <div className="mt-5">
                    <h5 className="">Product Name</h5>
                  </div>
                  <div class="input-group  w-75">
                    <input
                      type="text"
                      class="form-control"
                      placeholder="Product"
                      aria-label="Username"
                      aria-describedby="addon-wrapping"
                    />
                  </div>
                  <div className="mt-5">
                    <h5 className="">Product Price</h5>
                  </div>
                  <div class="input-group w-75 ">
                    <span class="input-group-text">LE</span>
                    <input
                      type="text"
                      class="form-control"
                      aria-label="Amount (to the nearest dollar)"
                    />
                    <span class="input-group-text">.00</span>
                  </div>
                  <div className="mt-5">
                    <h5 className="">Product Iamge</h5>
                  </div>
                  <div className="">
                    <input
                      type="file"
                      accept="image/*"
                      onChange={handleImageChange}
                    />
                    {imageUrl && (
                      <a
                        href={imageUrl}
                        target="_blank"
                        rel="noopener noreferrer"
                      >
                        Preview Image
                      </a>
                    )}
                    <button>Upload</button>
                  </div>
                  <div className="mt-5">
                    <h5 className="">Product description</h5>
                  </div>
                  <div class="input-group w-75 mb-5">
                    <span class="input-group-text">DESC</span>
                    <textarea
                      class="form-control"
                      aria-label="With textarea"
                    ></textarea>
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
