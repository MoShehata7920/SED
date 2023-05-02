import React from "react";
import "./Themes.css";



function Themes(){


    return(
        <>
         <div className="container d-flex justify-content-center ">
            <div className="row col-6 vh-100 flex-column align-items-center justify-content-center ">
                <div className="row  col-lg-8 col-sm-12  mt-5 border border-dark rounded-3   ">
                    <div className="themes-title row  text-left ">
                        <div>
                        <h3>Themes</h3>
                        </div>
                    </div>

                    <div className="row d-flex justify-content-around"> 
                        <div className="col-lg-2 col-sm-4 ">
                            <div class="themes-check form-check form-switch mt-5">
                                <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault"></input>
                                <label class="form-check-label" for="flexSwitchCheckDefault">Dark</label>
                            </div>

                        </div>
                        <div className="col-lg-2 col-sm-4 "> 
                            <div class="themes-check form-check form-switch mt-5">
                                <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault"></input>
                                <label class="form-check-label" for="flexSwitchCheckDefault">Light</label>      
                            </div>
                        </div>               
                    </div>

                </div>           
            </div>            
         </div>
        </>
    )

}
export default Themes;
