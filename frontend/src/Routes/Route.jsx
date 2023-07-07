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
import MyAccount from "../Pages/Profile/Myaccount/MyAccount";
import Settings from "../Pages/Profile/Settings/Settings";
import Userinfo from "../Pages/Profile/Userinfo/Userinfo";
import SearchPage from "../Pages/searchdata/searchdata";
import SeeAllData from "../Pages/seealldata/SeeAllData";
import SignIn from "../Pages/SignIn/SignIn";
import Register from "../Pages/SignUp/SignUp";
import MyAdds from "../Pages/Profile/MyAdds/MyAdds";
import Languages from "../Pages/Profile/Settings/Langages/Langagues";
import Themes from "../Pages/Profile/Settings/Themes/Themes";
import Notification from "../Pages/Profile/Notification/Notification";
import Share from "../Pages/Profile/Settings/Share/Share";
import Help from "../Pages/Profile/Settings/Help/Help";
import Aboutus from "../Pages/Profile/Settings/Aboutus/Aboutus";
import SellerInfo from "../Pages/SellerInfo/SellerInfo";
import ProductEditing from "../Pages/Profile/Product_Editing/Product_Editing";
import Change_Password from "../Pages/Profile/Change_Password/Change_password";
import Email_verfication from "../Component/Email_verification/Email_verification";
import Reset_pass_code from "../Component/Reset_pass_cod/Reset_pass_code";
import ResetPassword from "../Component/Reset_password/Reset_password";
import Chat from "../Pages/Chat/Chat";

function MainRoutes() {
  const storedToken = localStorage.getItem("encryptedToken");
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
        <Route path="/Email_verfication" element={<Email_verfication />} />
        <Route path="/forgetpassword" element={<Forgetpass />} />
        <Route path="/Reset_pass_code" element={<Reset_pass_code />} />
        <Route path="/Reset_password" element={<ResetPassword />} />
        <Route path="/Profile" element={storedToken ? <Profile /> : <SignIn />}>
          <Route path="/Profile/userinfo" element={<Userinfo />}></Route>
          <Route
            path="/Profile/ChangePassword/:UserID"
            element={<Change_Password />}
          ></Route>
          <Route path="/Profile/favourit" element={<Favourit />}></Route>
          <Route
            path="/Profile/myProduct/:UserID"
            element={<Product />}
          ></Route>
          <Route path="/Profile/settings" element={<Settings />}></Route>
          <Route
            path="/Profile/settings/myaccount/:UserID"
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

        <Route
          path="/SellerInfo/:SellerId/:ProductID"
          element={<SellerInfo />}
        />
        <Route
          path="/Product_Editing/:Product_id"
          element={<ProductEditing />}
        />
      </Routes>
      {
        <Chat
          senderId="649845a077bf4e6af700cac5"
          conversationId="64984e216bf1cc9ec20ded1d"
        />
      }
    </>
  );
}

export default MainRoutes;
