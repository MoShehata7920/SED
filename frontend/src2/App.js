import "./App.css";
import React from "react";
import { Route, Routes } from "react-router-dom";
import Profile from "./Pages/Profile/Profile";
import Userinfo from "./Pages/Userinfo/Userinfo";
import Favourit from "./Pages/Favourit/Favourit";
import Watchlist from "./Pages/Watchlist/Watchlist";
import Order from "./Pages/Order/Order";
import Settings from "./Pages/Settings/Settings";







function App() {
  return (
    <>
      
    <div>

    <Routes>
       <Route path='/' element={<Profile/>}>
            <Route path='userinfo' element={<Userinfo/>}></Route>
            <Route path='favourit' element={<Favourit/>}></Route>
            <Route path='watchlist' element={<Watchlist/>}></Route>
            <Route path='myorders' element={<Order/>}></Route>
            <Route path='settings' element={<Settings/>}>
               <Route path='settings/myaccount' element=''></Route>
               <Route path='settings/myadds' element=''></Route>
               <Route path='settings/langages' element=''></Route>
               <Route path='settings/themes' element=''></Route>
               <Route path='settings/notification' element=''></Route>
               <Route path='settings/share' element=''></Route>
               <Route path='settings/help' element=''></Route>
               <Route path='settings/aboutus' element=''></Route>
            </Route>
       </Route> 
      </Routes>


    </div>
    
     

    

   


     

    
  
    


  
      
      

     
    
    
    
    </>
  
    
    
  );
}

export default App;
