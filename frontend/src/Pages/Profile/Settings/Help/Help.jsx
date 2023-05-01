import React from "react";
import "./Help.css";
import { FcComments,FcPhone } from "react-icons/fc";



function Help(){


    return(
        <>
        <div className="help-container container d-flex justify-content-center ">
            <div className="row flex-column vh-100 col-10 align-content-center justify-content-center">
            <div className="row col-lg-8 d-flex  col-sm-12 border border-dark rounded-3">
                <div className="row mt-3">
                    <h3>Need Help?</h3> 
                    <p> if you have any questions or issues with our site . please feel free to contact us </p>

                </div>
                <div className="row mt-3">
                    <div className="row">
                        <div className="col-4 d-flex">
                            <div className=" d-flex col-2 mt-3">
                                <i>{<FcComments/>}</i>
                                <h4 className="m-3"> Email </h4>

                            </div>
                            <div className="col-2 m-3">

                            </div>
                        </div>
                    
                    </div>
                    <div className="row">

                    </div>

                </div>
                <div className="row mt-3 ">
                  <h6>We appreciate your feedback!</h6>
                </div>

            </div>


            </div>
          
        </div>
        </>
    )

}
export default Help;
