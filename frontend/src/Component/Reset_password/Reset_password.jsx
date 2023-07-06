import { useEffect, useState } from "react";
import Navebar from "../navebar/navbar";
import { UseAxiosPache } from "../axios/PachApi/PatchApi";
import { ToastContainer, toast } from "react-toastify";
export default function ResetPassword() {
  const [Reset_pass, setReset_pass] = useState({
    password: "",
    confirmPassword: "",
  });
  const patchAPi = "/auth/verified-pw-change";
  console.log(Reset_pass);
  function getiteminfo(e) {
    let myuser = { ...Reset_pass };
    myuser[e.target.name] = e.target.value;
    setReset_pass(myuser);
  }
  const { response, ErrorMessage, HandelPachApi } = UseAxiosPache(
    patchAPi,
    Reset_pass
  );
  const itemsubmit = (e) => {
    e.preventDefault();
    HandelPachApi();
  };
  useEffect(() => {
    if (response) {
      toast(`✔️ ${response} `);
      setTimeout(() => {
        localStorage.removeItem("encryptedToken");
        window.location.href = "/SignIn";
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
          <h2 className=" mb-1  mt-3">Reset_Password</h2>
          <form onSubmit={itemsubmit}>
            <div class="form__group field">
              <input
                onChange={getiteminfo}
                type="input"
                class="form__field"
                placeholder="password"
                name="password"
                id="searchOption"
                required
              />
              <label for="searchOption" class="form__label">
                password
              </label>
            </div>
            <div class="form__group field">
              <input
                onChange={getiteminfo}
                type="input"
                class="form__field"
                placeholder="password"
                name="confirmPassword"
                id="searchOption"
                required
              />
              <label for="searchOption" class="form__label">
                ConfirmPassword
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
