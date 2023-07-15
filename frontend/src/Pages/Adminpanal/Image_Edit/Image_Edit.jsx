import React, { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate, useParams } from "react-router-dom";
import { UseAxiosPache } from "../../../Component/axios/PachApi/PatchApi";
import AdminInfo from "../../../Component/AdminInfo/AdminInfo";
import { UseAxiosDelete } from "../../../Component/axios/DeleteApi/DeleteApi";
export default function ImageEdit() {
  const navigate = useNavigate();
  let { ImgID } = useParams();
  console.log(ImgID);
  const patchAPi = `/admin/editcarousel/${ImgID}`;
  const DeletApi = `/admin/delete/${ImgID}`;
  const [selectedFile, setSelectedFile] = useState(null);
  const handleImageChange = (e) => {
    setSelectedFile(e.target.files[0]);
  };
  console.log(selectedFile);
  const formData = new FormData();
  formData.append("image", selectedFile);
  const { response, ErrorMessage, HandelPachApi } = UseAxiosPache(
    patchAPi,
    formData
  );
  console.log(ImgID);
  async function itemsubmit(e) {
    e.preventDefault();
    HandelPachApi();
  }
  const {
    response: Deletrespons,
    ErrorMessage: Deleterror,
    HandelDeleteApi,
  } = UseAxiosDelete(DeletApi);
  const Removesubmit = (e) => {
    e.preventDefault();
    HandelDeleteApi();
  };
  useEffect(() => {
    if (Deletrespons) {
      toast(`✔️ ${Deletrespons}`);
      setTimeout(() => {
        navigate("/Admin/UsersInfo");
      }, 3000);
    }
    if (Deleterror && Deletrespons == "") {
      toast(`❌ ${Deleterror} `);
    }
    if (response) {
      toast(`✔️ ${response}`);
      setTimeout(() => {
        navigate("/Admin/UsersInfo");
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [response, ErrorMessage, Deleterror, Deletrespons]);
  return (
    <>
      <AdminInfo />
      <div className="row">
        <div className="  col-12 ">
          <div className="Card_div  ">
            <form onSubmit={itemsubmit} enctype="multipart/form-data">
              <div class="segment">
                <h1>Add Carousel Image</h1>
              </div>
              <label>
                <input onChange={handleImageChange} type="file" id="formFile" />
              </label>
              <button class="red mb-3" type="submit">
                <i class="icon ion-md-lock"></i> Add Image
              </button>
            </form>
            <form onSubmit={Removesubmit} enctype="multipart/form-data">
              <button class="red mb-3" type="submit">
                <i class="icon ion-md-lock"></i> Remove
              </button>
            </form>
          </div>
        </div>
      </div>
      <ToastContainer />
    </>
  );
}
