import { useEffect, useState } from "react";
import Navebar from "../navebar/navbar";
import {
  MDBContainer,
  MDBCol,
  MDBRow,
  MDBBtn,
  MDBInput,
} from "mdb-react-ui-kit";
import { Icon } from "react-icons-kit";
import { eyeOff } from "react-icons-kit/feather/eyeOff";
import { eye } from "react-icons-kit/feather/eye";
import { UseAxiosPache } from "../axios/PachApi/PatchApi";
import { ToastContainer, toast } from "react-toastify";
import { useNavigate } from "react-router-dom";
export default function ResetPassword() {
  const navigate = useNavigate();
  const [Reset_pass, setReset_pass] = useState({
    password: "",
    confirmPassword: "",
  });
  const [type, setType] = useState("password");
  const [icon, setIcon] = useState(eyeOff);
  const patchAPi = "/auth/verified-pw-change";
  console.log(Reset_pass);
  function getiteminfo(e) {
    let myuser = { ...Reset_pass };
    myuser[e.target.name] = e.target.value;
    setReset_pass(myuser);
  }
  const handleToggle = () => {
    if (type === "password") {
      setIcon(eye);
      setType("text");
    } else {
      setIcon(eyeOff);
      setType("password");
    }
  };
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
        navigate("/SignIn");
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
        <MDBContainer fluid className="p-3 my-5 h-custom">
          <MDBRow>
            <MDBCol col="10" md="6">
              <img
                src="https://mdbcdn.b-cdn.net/img/Photos/new-templates/bootstrap-login-form/draw2.webp"
                class="img-fluid"
                alt="Sample image"
              />
            </MDBCol>

            <MDBCol className="mt-5" col="4" md="6">
              <form onSubmit={itemsubmit}>
                <div className=" position-relative ">
                  <MDBInput
                    wrapperClass="mb-4"
                    onChange={getiteminfo}
                    label="New Password"
                    id="formControlLg"
                    type={type}
                    name="password"
                    size="lg"
                  />
                  <span className=" icon-container " onClick={handleToggle}>
                    <Icon icon={icon} size={25} />
                  </span>
                </div>
                <div className=" position-relative ">
                  <MDBInput
                    wrapperClass="mb-4"
                    onChange={getiteminfo}
                    label="Confirm Password"
                    id="formControlLg"
                    type={type}
                    name="confirmPassword"
                    size="lg"
                  />
                  <span className=" icon-container " onClick={handleToggle}>
                    <Icon icon={icon} size={25} />
                  </span>
                </div>
                <div className="text-center text-md-start mt-4 pt-2">
                  <div>
                    <button
                      type="submit"
                      className=" btn btn-primary  py-2 px-5"
                      size="lg"
                    >
                      RESET Password
                    </button>
                  </div>
                </div>
              </form>
            </MDBCol>
            <ToastContainer />
          </MDBRow>
        </MDBContainer>
      </section>
    </>
  );
}
