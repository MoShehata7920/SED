import "./App.css";
import React, { useEffect } from "react";
import MainRoutes from "./Routes/Route";
import { BrowserRouter } from "react-router-dom";

function App() {
  return (
    <BrowserRouter>
      <MainRoutes />
    </BrowserRouter>
  );
}

export default App;
