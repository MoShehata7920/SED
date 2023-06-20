import React from "react";
import ReactDOM from "react-dom/client";
import "./index.css";
import MainRoutes from "./App";
import "bootstrap/dist/css/bootstrap.min.css";
import "bootstrap/dist/js/bootstrap.bundle.js";
import "@fortawesome/fontawesome-free/css/all.min.css";
import "owl.carousel/dist/assets/owl.carousel.css";
import "owl.carousel/dist/assets/owl.theme.default.css";
import "owl.carousel";

const root = ReactDOM.createRoot(document.getElementById("root"));
root.render(<MainRoutes />);
