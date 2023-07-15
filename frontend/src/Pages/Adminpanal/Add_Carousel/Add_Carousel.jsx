import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import "react-toastify/dist/ReactToastify.css";
import "./Add_Carousel.css";
import { UseAxiosPost } from "../../../Component/axios/PostApi/PostApi";
import { useNavigate } from "react-router-dom";
import AdminInfo from "../../../Component/AdminInfo/AdminInfo";
export default function AddCarouselImage() {
  const navigate = useNavigate();
  const [CarouselImg, setCarouselImg] = useState({
    imageLocation: "carousel",
    image: "",
  });
  const postAPi = "/admin/appImages";
  const [selectedFile, setSelectedFile] = useState(null);
  const handleImageChange = (e) => {
    setSelectedFile(e.target.files[0]);
  };
  console.log(selectedFile);
  const formData = new FormData();
  formData.append("image", selectedFile);
  formData.append("imageLocation", CarouselImg.imageLocation);
  for (var pair of formData.entries()) {
    console.log(pair[1] + ", " + pair[0]);
  }
  const { response, ErrorMessage, HandelPostApi } = UseAxiosPost(
    postAPi,
    formData
  );
  const itemsubmit = (e) => {
    e.preventDefault();
    HandelPostApi();
  };
  useEffect(() => {
    if (response) {
      toast(`✔️ ${response}`);
      setTimeout(() => {
        navigate("/Admin/UsersInfo");
      }, 5000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [response, ErrorMessage]);
  return (
    <>
      <AdminInfo />
      <section>
        <div className="">
          <div className="row      ">
            <div className="  col-12 ">
              <div className="Card_div  ">
                <form onSubmit={itemsubmit} enctype="multipart/form-data">
                  <div class="segment">
                    <h1>Add Carousel Image</h1>
                  </div>
                  <label>
                    <input
                      onChange={handleImageChange}
                      type="file"
                      id="formFile"
                    />
                  </label>
                  <button class="red mb-3" type="submit">
                    <i class="icon ion-md-lock"></i> Add Image
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
