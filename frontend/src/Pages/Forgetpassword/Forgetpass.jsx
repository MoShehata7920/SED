import React, { useEffect, useState } from "react";
import "./Forgetpass.css";
import Navebar from "../../Component/navebar/navbar";
import { UseAxiosPost } from "../../Component/axios/PostApi/PostApi";
import { ToastContainer, toast } from "react-toastify";

function Forgetpass() {
  const [Email, setEmail] = useState({
    searchOption: "",
  });
  const postAPi = "/auth/forgotOTP";
  console.log(Email);
  function getiteminfo(e) {
    let myuser = { ...Email };
    myuser[e.target.name] = e.target.value;
    setEmail(myuser);
  }
  const { response, data, ErrorMessage, HandelPostApi } = UseAxiosPost(
    postAPi,
    Email
  );
  const itemsubmit = (e) => {
    e.preventDefault();
    HandelPostApi();
  };
  useEffect(() => {
    if (response) {
      toast(`✔️ ${response} `);
      setTimeout(() => {
        window.location.href = "/Reset_pass_code";
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [response, ErrorMessage]);
  return (
    <>
      <section className="mb-5">
        <Navebar />
      </section>
      <section>
        <div className="login-box mt-5">
          <h2 className=" mb-1  mt-3">Forget password</h2>
          <form onSubmit={itemsubmit}>
            <div class="form__group field">
              <input
                onChange={getiteminfo}
                type="input"
                class="form__field"
                placeholder="Name"
                name="searchOption"
                id="searchOption"
                required
              />
              <label for="searchOption" class="form__label">
                Email
              </label>
            </div>
            <div className="login mt-5 mb-2">
              <button type="submit"> send virify </button>
            </div>
          </form>
        </div>
        <ToastContainer />
      </section>
    </>
  );
}
export default Forgetpass;
