import"./Userinfo.css";
import React from "react";
import "./user.png"
import { FaMapMarkerAlt} from "react-icons/fa";
import { BsPencil } from "react-icons/bs";




function Userinfo(){



    
    return(
        <>
         <div className="userinfo" >
         <div className="presonalinfo">
                <div className="photo">
                 <img src={require('./user.png')} alt="" />
                 
                 
                </div>
                <div className="pio">
                    <h6>Mohamed Adel</h6>
                    <p><i><FaMapMarkerAlt/></i> Tanta,Gharbiya</p>
                   
                    
                </div>
                <div>
                    <button className="btn btn-light"><i><BsPencil/></i> edite profile </button>
                </div>
            </div>

            <div className="forminfo">
                <div className="Maininfo">
                        <div className="mb-3">
                            <label for="exampleFormControlInput1" className="form-label"> User Name </label>
                            <input type="text" className="form-control"  placeholder="user name" readOnly></input>
                        </div>
                        <div className="mb-3">
                            <label for="exampleFormControlInput1" className="form-label"> Email address </label>
                            <input type="email" className="form-control"  placeholder="name@example.com"></input>
                        </div> 
                        <div className="mb-3">
                            <label for="exampleFormControlInput1" className="form-label"> Password </label>
                            <input type="password" className="form-control"  placeholder="******"></input>
                        </div>
                </div>
                <div className="secondinfo">
                        <div className="mb-3">
                            <label for="exampleFormControlInput1" className="form-label"> Mobile Phone </label>
                            <input type="text" className="form-control"  placeholder="+20"></input>
                        </div>
                        <div className="mb-3">
                            <label for="exampleFormControlInput1" className="form-label"> Location </label>
                            <input type="email" className="form-control"  placeholder=""></input>
                        </div> 
                        <div className="mb-3">
                            <label for="exampleFormControlInput1" className="form-label"> Postal Code </label>
                            <input type="password" className="form-control"  placeholder=""></input>    
                        </div>
                        <div className="change">
                            <button className="btn btn-light" > Save Changes </button>
                            <button className="btn btn-light" > Cancel  </button>
                        </div>  
                </div >
            </div>
           
        </div>
        

        
        
        
        </>
    )
}
export default Userinfo;
