import { useEffect, useState } from "react";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate, useParams } from "react-router-dom";
import "./Admin_Account_Editing.css";
import { UseAxiosPache } from "../../../Component/axios/PachApi/PatchApi";
import { getTokendeta } from "../../../Component/axios/tokendata/Token_Data";
import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
import AdminInfo from "../../../Component/AdminInfo/AdminInfo";
export default function AdminAccountEditing() {
  const Tokendata = getTokendeta();
  const GetApi = `/users/get`;
  const { data, isPending, error } = UseAxiosGet(GetApi);
  let datauser = data ? data.user : "";
  console.log(datauser);
  const navigate = useNavigate();
  let { UserID } = useParams();
  const [userInfoEdit, setuserInfoEdit] = useState({
    fullName: "",
    email: "",
    government: "",
    address: "",
    phone: "",
  });
  const patchAPi = `/users/update/${UserID}`;
  const [selectedFile, setSelectedFile] = useState(null);
  const handleImageChange = (e) => {
    setSelectedFile(e.target.files[0]);
  };
  console.log(selectedFile);
  function getUserinfo(e) {
    let myinfo = { ...userInfoEdit };
    myinfo[e.target.name] = e.target.value;
    setuserInfoEdit(myinfo);
  }
  const formData = new FormData();
  if (selectedFile) {
    formData.append("userImage", selectedFile);
  }
  if (userInfoEdit.fullName) {
    formData.append("fullName", userInfoEdit.fullName);
  }
  if (userInfoEdit.email) {
    formData.append("email", userInfoEdit.email);
  }
  if (userInfoEdit.phone) {
    formData.append("phone", userInfoEdit.phone);
  }
  if (userInfoEdit.government) {
    formData.append("government", userInfoEdit.government);
  }
  if (userInfoEdit.address) {
    formData.append("address", userInfoEdit.address);
  }
  for (var pair of formData.entries()) {
    console.log(pair[1] + ", " + pair[0]);
  }
  const { response, ErrorMessage, HandelPachApi } = UseAxiosPache(
    patchAPi,
    formData
  );
  async function itemsubmit(e) {
    e.preventDefault();
    HandelPachApi();
  }
  useEffect(() => {
    if (response) {
      toast(`✔️ ${response}`);
      setTimeout(() => {
        navigate("/Admin/UsersInfo");
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [response, ErrorMessage]);
  return (
    <>
      <AdminInfo />
      <div className="">
        <div className="row      ">
          <div className="  col-12 ">
            <div className="Card_div  ">
              <form onSubmit={itemsubmit}>
                <div class="segment">
                  <h1>Account</h1>
                </div>

                <label>
                  <input
                    name="fullName"
                    onChange={getUserinfo}
                    type="text"
                    placeholder={datauser.fullName}
                  />
                </label>
                <label>
                  <input
                    name="email"
                    onChange={getUserinfo}
                    type="email"
                    placeholder={datauser.email}
                  />
                </label>
                <label>
                  <input
                    name="government"
                    onChange={getUserinfo}
                    type="text"
                    placeholder={datauser.government}
                  />
                </label>
                <label>
                  <input
                    name="address"
                    onChange={getUserinfo}
                    type="text"
                    placeholder={datauser.address}
                  />
                </label>
                <label>
                  <input
                    name="phone"
                    onChange={getUserinfo}
                    type="email"
                    placeholder={datauser.phone}
                  />
                </label>
                <label>
                  <input
                    onChange={handleImageChange}
                    type="file"
                    id="formFile"
                  />
                </label>
                <button class="red mb-3" type="submit">
                  <i class="icon ion-md-lock"></i> Change
                </button>
              </form>
            </div>
          </div>
        </div>
        <ToastContainer />
      </div>
    </>
  );
}
