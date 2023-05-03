import React from "react";
import { Navigate, Route, Routes } from "react-router-dom";
import AddItem from "../Pages/additems/AddItem";
import Categories from "../Pages/categories/categories";
import Dataitems from "../Pages/dataitems/dataitems";
import Forgetpass from "../Pages/Forgetpassword/Forgetpass";
import Home from "../Pages/home/Home";
import Favourit from "../Pages/Profile/Favourit/Favourit";
import Profile from "../Pages/Profile/Profile/Profile";
import Product from "../Pages/Profile/Product/Product";
import MyAccount from "../Pages/Profile/Settings/Myaccount/MyAccount";
import Settings from "../Pages/Profile/Settings/Settings";
import Userinfo from "../Pages/Profile/Userinfo/Userinfo";
import Watchlist from "../Pages/Profile/Watchlist/Watchlist";
import SearchPage from "../Pages/searchdata/searchdata";
import SeeAllData from "../Pages/seealldata/SeeAllData";
import SignIn from "../Pages/SignIn/SignIn";
import Register from "../Pages/SignUp/SignUp";
import MyAdds from "../Pages/Profile/Settings/MyAdds/MyAdds";
import Languages from "../Pages/Profile/Settings/Langages/Langagues";
import Themes from "../Pages/Profile/Settings/Themes/Themes";
import Notification from "../Pages/Profile/Settings/Notification/Notification";
import Share from "../Pages/Profile/Settings/Share/Share";
import Help from "../Pages/Profile/Settings/Help/Help";
import Aboutus from "../Pages/Profile/Settings/Aboutus/Aboutus";
import SellerInfo from "../Pages/SellerInfo/SellerInfo";

function MainRoutes() {
  const storedToken = localStorage.getItem("usertoken");
  return (
    <>
      <Routes>
        <Route path="/" exact element={<Home />} />
        <Route
          path="/SignIn"
          element={storedToken ? <Navigate replace to={"/"} /> : <SignIn />}
        />
        <Route
          path="/SignUp"
          element={storedToken ? <Navigate replace to={"/"} /> : <Register />}
        />
        <Route path="/forgetpassword" element={<Forgetpass />} />
        <Route
          path="/Profile"
          element={storedToken ? <Profile /> : <Profile />}
        >
          <Route path="/Profile/userinfo" element={<Userinfo />}></Route>
          <Route path="/Profile/favourit" element={<Favourit />}></Route>
          <Route path="/Profile/watchlist" element={<Watchlist />}></Route>
          <Route path="/Profile/myProduct" element={<Product />}></Route>
          <Route path="/Profile/settings" element={<Settings />}></Route>
          <Route
            path="/Profile/settings/myaccount"
            element={<MyAccount />}
          ></Route>
          <Route
            path="/Profile/settings/myadds/:ProductId"
            element={<MyAdds />}
          ></Route>
          <Route
            path="/Profile/settings/langages"
            element={<Languages />}
          ></Route>
          <Route path="/Profile/settings/themes" element={<Themes />}></Route>
          <Route
            path="/Profile/settings/notification"
            element={<Notification />}
          ></Route>
          <Route path="/Profile/settings/share" element={<Share />}></Route>
          <Route path="/Profile/settings/help" element={<Help />}></Route>
          <Route path="/Profile/settings/aboutus" element={<Aboutus />}></Route>
        </Route>
        <Route path="/items/:id" element={<Dataitems />} />
        <Route path="/Categories/:CategorieType" element={<Categories />} />
        <Route path="/search" element={<SearchPage />} />
        <Route path="/SeeAllData/:SeeData" element={<SeeAllData />} />
        <Route path="/AddItems" element={<AddItem />} />

        <Route path="/SellerInfo/:SellerId" element={<SellerInfo />} />
      </Routes>
    </>
  );
}

export default MainRoutes;

{
  /* <Navigate replace to={"/SignIn"} /> */
}
