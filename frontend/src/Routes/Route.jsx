import React from "react";
import { Route, Routes } from "react-router-dom";
import Categories from "../Pages/categories/categories";
import Dataitems from "../Pages/dataitems/dataitems";
import Forgetpass from "../Pages/Forgetpassword/Forgetpass";
import Home from "../Pages/home/Home";
import Favourit from "../Pages/Profile/Favourit/Favourit";
import Order from "../Pages/Profile/Order/Order";
import Profile from "../Pages/Profile/Profile/Profile";
import MyAccount from "../Pages/Profile/Settings/Myaccount/MyAccount";
import Settings from "../Pages/Profile/Settings/Settings";
import Userinfo from "../Pages/Profile/Userinfo/Userinfo";
import Watchlist from "../Pages/Profile/Watchlist/Watchlist";
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
        <Route path="/Profile" element={<Profile />}>
          <Route path="/Profile/userinfo" element={<Userinfo />}></Route>
          <Route path="/Profile/favourit" element={<Favourit />}></Route>
          <Route path="/Profile/watchlist" element={<Watchlist />}></Route>
          <Route path="/Profile/myorders" element={<Order />}></Route>
          <Route path="/Profile/settings" element={<Settings />}></Route>
          <Route
            path="/Profile/settings/myaccount"
            element={<MyAccount />}
          ></Route>
          <Route path="/Profile/settings/myadds" element=""></Route>
          <Route path="/Profile/settings/langages" element=""></Route>
          <Route path="/Profile/settings/themes" element=""></Route>
          <Route path="/Profile/settings/notification" element=""></Route>
          <Route path="/Profile/settings/share" element=""></Route>
          <Route path="/Profile/settings/help" element=""></Route>
          <Route path="/Profile/settings/aboutus" element=""></Route>
        </Route>
        <Route path="/items/:id" element={<Dataitems />} />
        <Route path="/Categories/:CategorieType" element={<Categories />} />
        <Route path="search" element={<SearchPage />} />
        <Route path="SeeAllData/:SeeData" element={<SeeAllData />} />
      </Routes>
    </>
  );
}

export default MainRoutes;
