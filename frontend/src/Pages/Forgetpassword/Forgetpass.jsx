import React, { useState } from "react";
import "./Forgetpass.css";
import Navebar from "../../Component/navebar/navbar";
import { UseAxiosPost } from "../../Component/axios/PostApi/PostApi";

function Forgetpass() {
  const [Email, setEmail] = useState("");
  const postAPi = "/auth/forgot";
  const { response, data, ErrorMessage, HandelPostApi } = UseAxiosPost(
    postAPi,
    Email
  );
  function getiteminfo(e) {
    const myitem = e.target.value;
    setEmail(myitem);
  }
  const itemsubmit = (e) => {
    e.preventDefault();
    HandelPostApi();
  };
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
                name="loginOption"
                id="loginOption"
                required
              />
              <label for="loginOption" class="form__label">
                Email
              </label>
            </div>
            <div className="login mt-5 mb-2">
              <button type="submit"> send virify </button>
            </div>
          </form>
        </div>
      </section>
    </>
  );
}
export default Forgetpass;
