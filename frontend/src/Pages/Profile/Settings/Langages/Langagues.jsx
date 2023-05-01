import React from "react";
import "./Langages.css";



function Languages(){


    return(
        <>
        <div className="container d-flex justify-content-center  ">
            <div className="row vh-100 col-8 flex-column justify-content-center align-content-center">
            <div className="row col-lg-6 col-sm-12  mt-5 border border-dark rounded-3  bg-light ">
                <div className="row  text-left">
                    <div>
                      <h3>Langauges</h3>
                    </div>
                </div>

                <div className="row d-flex justify-content-around"> 
                    <div className="col-lg-2 col-sm-4 ">
                        <div class="form-check form-switch mt-5">
                            <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault"></input>
                            <label class="form-check-label" for="flexSwitchCheckDefault">Arabic</label>
                        </div>

                    </div>
                    <div className="col-lg-2 col-sm-4 "> 
                        <div class="form-check form-switch mt-5">
                            <input class="form-check-input" type="checkbox" id="flexSwitchCheckDefault"></input>
                            <label class="form-check-label" for="flexSwitchCheckDefault">English</label>      
                        </div>
                </div>
                

            </div>
            
                  
                   
                </div>
            </div>            
        </div>
        </>
    )

}
export default Languages;
