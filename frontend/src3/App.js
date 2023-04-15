import { Route, Routes } from 'react-router-dom';
import './App.css';
import Signin from './components/Signin/Signin';
import Forgetpass from './components/Forgetpassword/Forgetpass';
import Register from './components/Register/Register';
import Home from './components/Home/Home';

function App() {
  return (
 <>
 <div>
 <Routes>
  <Route path='/' element={<Register/>}></Route>
    <Route path='/signin' element={<Signin/>}></Route>
    <Route path='/forgetpassword' element={<Forgetpass/>}></Route>
    <Route path='/home' element={<Home/>}></Route>
  </Routes>
 </div>
 

 </>
  );
}

export default App;
