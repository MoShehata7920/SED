import React, { useState } from "react";
import { Navigate, Route, Routes } from "react-router-dom";
import Categories from "../Pages/categories/categories";
import Dataitems from "../Pages/dataitems/dataitems";
import Forgetpass from "../Pages/Forgetpassword/Forgetpass";
import Home from "../Pages/home/Home";
import Favourit from "../Pages/Profile/Favourit/Favourit";
import Profile from "../Pages/Profile/Profile/Profile";
import Product from "../Pages/Profile/Product/Product";
import MyAccount from "../Pages/Profile/Myaccount_Editing/MyAccount";
import SearchPage from "../Pages/searchdata/searchdata";
import SeeAllData from "../Pages/seealldata/SeeAllData";
import SignIn from "../Pages/SignIn/SignIn";
import Register from "../Pages/SignUp/SignUp";
import MyAdds from "../Pages/Profile/MyAdds/MyAdds";
import Notification from "../Pages/Profile/Notification/Notification";
import SellerInfo from "../Pages/SellerInfo/SellerInfo";
import ProductEditing from "../Pages/Profile/Product_Editing/Product_Editing";
import Change_Password from "../Pages/Profile/Change_Password/Change_password";
import Email_verfication_code from "../Component/Email_verification_code/Email_verification_code";
import Reset_pass_code from "../Component/Reset_pass_cod/Reset_pass_code";
import ResetPassword from "../Component/Reset_password/Reset_password";
import Chat from "../Pages/Chat/Chat";
import { getTokendeta } from "../Component/axios/tokendata/Token_Data";
import AddItem from "../Pages/Profile/additems/AddItem";
import Email_verfication from "../Component/Email_verification/Email_verifixation";
function MainRoutes() {
  const [isPageOneCompleted, setIsPageOneCompleted] = useState(false);
  const [isPageTowCompleted, setIsPageTowCompleted] = useState(false);
  const handlePageOneCompletion = () => {
    setIsPageOneCompleted(true);
  };
  const handlePageTowCompletion = () => {
    setIsPageTowCompleted(true);
  };
  const Tokendata = getTokendeta();
  const storedToken = localStorage.getItem("encryptedToken");
  return (
    <>
      <Routes>
        <Route path="/" exact element={<Home />} />
        <Route
          path="/SignIn"
          element={
            localStorage.getItem("encryptedToken") ? (
              <Navigate replace to={"/"} />
            ) : (
              <SignIn />
            )
          }
        />
        <Route path="/chat" element={<Chat />} />
        <Route
          path="/Email_verfication"
          element={
            storedToken ? (
              <Email_verfication />
            ) : (
              <Navigate replace to={"/SignIn"} />
            )
          }
        />
        <Route
          path="/Email_verfication_code"
          element={
            storedToken ? (
              <Email_verfication_code />
            ) : (
              <Navigate replace to={"/SignIn"} />
            )
          }
        />
        <Route
          path="/SignUp"
          element={storedToken ? <Navigate replace to={"/"} /> : <Register />}
        />
        <Route
          path="/forgetpassword"
          element={<Forgetpass onComplete={handlePageOneCompletion} />}
        />
        <Route
          path="/Reset_pass_code"
          element={
            isPageOneCompleted ? (
              <Reset_pass_code onComplete={handlePageTowCompletion} />
            ) : (
              <Navigate replace to={"/forgetpassword"} />
            )
          }
        />
        <Route
          path="/Reset_password"
          element={
            isPageTowCompleted ? (
              <ResetPassword onComplete={handlePageTowCompletion} />
            ) : (
              <Navigate replace to={"/Reset_pass_code"} />
            )
          }
        />

        <Route path="/Profile" element={storedToken ? <Profile /> : <SignIn />}>
          <Route
            path="/Profile/AddItems"
            element={
              Tokendata == false ? (
                <Navigate replace to={"/Email_verfication"} />
              ) : (
                <AddItem />
              )
            }
          />
          <Route
            path="/Profile/ChangePassword/:UserID"
            element={<Change_Password />}
          ></Route>
          <Route path="/Profile/favourit" element={<Favourit />}></Route>
          <Route
            path="/Profile/myProduct/:UserID"
            element={<Product />}
          ></Route>

          <Route
            path="/Profile/myaccount/:UserID"
            element={<MyAccount />}
          ></Route>
          <Route path="/Profile/myadds/:ProductId" element={<MyAdds />}></Route>
          <Route
            path="/Profile/notification"
            element={<Notification />}
          ></Route>
        </Route>
        <Route path="/items/:id" element={<Dataitems />} />
        <Route path="/Categories/:CategorieType" element={<Categories />} />
        <Route path="/search" element={<SearchPage />} />
        <Route path="/SeeAllData/:SeeData" element={<SeeAllData />} />

        <Route
          path="/SellerInfo/:SellerId/:ProductID"
          element={<SellerInfo />}
        />
        <Route
          path="/Product_Editing/:Product_id"
          element={<ProductEditing />}
        />
      </Routes>
    </>
  );
}

export default MainRoutes;
