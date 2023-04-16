import React from "react";
import { Route, Routes } from "react-router-dom";
import Categories from "../Pages/categories/categories";
import Dataitems from "../Pages/dataitems/dataitems";
import Forgetpass from "../Pages/Forgetpassword/Forgetpass";
import Home from "../Pages/home/Home";
import Profile from "../Pages/Profile/Profile";
import SearchPage from "../Pages/searchdata/searchdata";
import SeeAllData from "../Pages/seealldata/SeeAllData";
import SignIn from "../Pages/SignIn/SignIn";
import Register from "../Pages/SignUp/SignUp";

function MainRoutes() {
  return (
    <>
      <Routes>
        <Route path="/" exact element={<Home />} />
        <Route path="/SignIn" element={<SignIn />} />
        <Route path="/SignUp" element={<Register />} />
        <Route path="/forgetpassword" element={<Forgetpass />} />
        <Route path="/Profile" element={<Profile />} />
        <Route path="/items/:id" element={<Dataitems />} />
        <Route path="/Categories/:CategorieType" element={<Categories />} />
        <Route path="search" element={<SearchPage />} />
        <Route path="SeeAllData/:SeeData" element={<SeeAllData />} />
      </Routes>
    </>
  );
}

export default MainRoutes;
