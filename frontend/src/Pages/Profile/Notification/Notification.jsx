import React from "react";
import "./Notification.css";
import Userinfo from "../Userinfo/Userinfo";
import Toast from "react-bootstrap/Toast";
import ToastContainer from "react-bootstrap/ToastContainer";

function Notification() {
  return (
    <>
      <Userinfo />
      <section>
        <div className="container-fluid  vh-100 mt-4">
          <div className=" text-center">
            <h1>Notification</h1>
          </div>
          <div className="  bg-black pading_05"></div>
          <div className=" w-50  mt-4">
            <ToastContainer className="position-static w-100">
              <Toast className="w-100">
                <Toast.Header>
                  <img
                    src="holder.js/20x20?text=%20"
                    className="rounded me-2"
                    alt=""
                  />
                  <strong className="me-auto">Admin</strong>
                  <small className="text-muted">just now</small>
                </Toast.Header>
                <Toast.Body>
                  you need to change youre password evry 30 days
                </Toast.Body>
              </Toast>
              <Toast className="w-100">
                <Toast.Header>
                  <img
                    src="holder.js/20x20?text=%20"
                    className="rounded me-2"
                    alt=""
                  />
                  <strong className="me-auto">Admin</strong>
                  <small className="text-muted">just now</small>
                </Toast.Header>
                <Toast.Body>
                  you need to change youre password evry 30 days
                </Toast.Body>
              </Toast>
              <Toast className="w-100">
                <Toast.Header>
                  <img
                    src="holder.js/20x20?text=%20"
                    className="rounded me-2"
                    alt=""
                  />
                  <strong className="me-auto">Admin</strong>
                  <small className="text-muted">just now</small>
                </Toast.Header>
                <Toast.Body>
                  you need to change youre password evry 30 days
                </Toast.Body>
              </Toast>
              <Toast className="w-100">
                <Toast.Header>
                  <img
                    src="holder.js/20x20?text=%20"
                    className="rounded me-2"
                    alt=""
                  />
                  <strong className="me-auto">Admin</strong>
                  <small className="text-muted">just now</small>
                </Toast.Header>
                <Toast.Body>
                  you need to change youre password evry 30 days
                </Toast.Body>
              </Toast>
            </ToastContainer>
          </div>
        </div>
      </section>
    </>
  );
}
export default Notification;
