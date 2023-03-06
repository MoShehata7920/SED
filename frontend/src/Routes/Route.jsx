import React from "react";
import { Routes, Route } from "react-router-dom";
import Dataitems from "../Pages/dataitems/dataitems";
import Home from "../Pages/home/Home";
import Profile from "../Pages/Profile/Profile";
import SignIn from "../Pages/SignIn/SignIn";
import SignUp from "../Pages/SignUp/SignUp";

function MainRoutes() {
  return (
    <Routes>
      <Route path="/" element={<Home />} />
      <Route path="SignIn" element={<SignIn />} />
      <Route path="SignUp" element={<SignUp />} />
      <Route path="Profile" element={<Profile />} />
      <Route path="items/:id" element={<Dataitems />} />
    </Routes>
  );
}

export default MainRoutes;
