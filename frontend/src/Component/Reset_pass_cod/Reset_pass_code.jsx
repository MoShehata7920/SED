import React, { useEffect, useState } from "react";
import Navebar from "../../Component/navebar/navbar";
import { UseAxiosPost } from "../../Component/axios/PostApi/PostApi";
import { ToastContainer, toast } from "react-toastify";
import { encrypt } from "n-krypta";

function Reset_pass_code() {
  const secret = process.env.REACT_APP_SECRET_KEY;
  const [Reset_code, setReset_codel] = useState({
    code: "",
  });
  const postAPi = "/auth/resetOTP";

  console.log(Reset_code);
  function getiteminfo(e) {
    let myuser = { ...Reset_code };
    myuser[e.target.name] = e.target.value;
    setReset_codel(myuser);
  }
  const { response, data, ErrorMessage, HandelPostApi } = UseAxiosPost(
    postAPi,
    Reset_code
  );
  let token = data ? data.token : null;
  const itemsubmit = (e) => {
    e.preventDefault();
    HandelPostApi();
  };
  useEffect(() => {
    if (data) {
      const encryptedData = encrypt(token, secret);
      localStorage.setItem("encryptedToken", encryptedData);
    }
    if (response) {
      toast(`✔️ ${response} `);
      setTimeout(() => {
        window.location.href = `/Reset_Password`;
      }, 3000);
    }
    if (ErrorMessage && response == "") {
      toast(`❌ ${ErrorMessage} `);
    }
  }, [data, response, ErrorMessage]);
  return (
    <>
      <section className="mb-5">
        <Navebar />
      </section>
      <section>
        <div className="login-box mt-5">
          <h2 className=" mb-1  mt-3">Reset_Password_Code</h2>
          <form onSubmit={itemsubmit}>
            <div class="form__group field">
              <input
                onChange={getiteminfo}
                type="input"
                class="form__field"
                placeholder="Name"
                name="code"
                id="searchOption"
                required
              />
              <label for="searchOption" class="form__label">
                RESET_CODE
              </label>
            </div>
            <div className="login mt-5 mb-2">
              <button type="submit"> RESET </button>
            </div>
          </form>
        </div>
        <ToastContainer />
      </section>
    </>
  );
}
export default Reset_pass_code;
