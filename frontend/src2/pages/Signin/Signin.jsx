import axios from "axios";
import { useState } from "react";




function Signin(){


    const [user,setuser]=useState({
        email:"",
        password:""

    });

    function getuserinfo(e){
    let myuser={...user}
    myuser[e.target.name]=e.target.value;
    setuser(myuser)
 }



 async function usrsubmit(e)
          {
           e.preventDefault()
           let respons= await axios.post('http://103.48.193.225:9000/customers/login',user)   
           console.log(respons)
           console.log(user);
           localStorage.setItem("usertoken",respons.token)
          } 
 
    return(
        <>
         <section className="bg-gray-50 dark:bg-gray-900">
                <div className="flex flex-col items-center justify-center px-6 py-8 mx-auto md:h-screen lg:py-0">     
                    <div className="w-full bg-white rounded-lg shadow dark:border md:mt-0 sm:max-w-md xl:p-0 dark:bg-gray-800 dark:border-gray-700">
                        <div className="p-6 space-y-4 md:space-y-6 sm:p-8">
                            
                            <h1 className="text-xl font-simibold leading-tight tracking-tight text-gray-900 md:text-2xl dark:text-white">
                                Welcome Back ! 
                            </h1>
                            <form className="space-y-4 md:space-y-6" action="#"  onSubmit={usrsubmit}>
                                <div>
                                    <label  className="block mb-2 text-sm font-medium text-gray-900 dark:text-white">Your email </label>
                                    <input type="email" name="email" id="email" className="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" placeholder="name@company.com" required=""  onChange={getuserinfo} ></input>
                                </div>      
                                <div>
                                    <label  className="block mb-2 text-sm font-medium text-gray-900 dark:text-white"> password</label>
                                    <input  name="password" id="confirm-password" placeholder="••••••••" className="bg-gray-50 border border-gray-300 text-gray-900 sm:text-sm rounded-lg focus:ring-primary-600 focus:border-primary-600 block w-full p-2.5 dark:bg-gray-700 dark:border-gray-600 dark:placeholder-gray-400 dark:text-white dark:focus:ring-blue-500 dark:focus:border-blue-500" required=""  onChange={getuserinfo}></input>
                                </div>
                                <div className="flex items-start">
                                    <div className="flex items-center h-5">
                                        <input id="terms" aria-describedby="terms" type="checkbox" className="w-4 h-4 border border-gray-300 rounded bg-gray-50 focus:ring-3 focus:ring-primary-300 dark:bg-gray-700 dark:border-gray-600 dark:focus:ring-primary-600 dark:ring-offset-gray-800" required="" ></input>
                                    </div>
                                    <div className="ml-3 text-sm">
                                        <label  className="font-light text-gray-500 dark:text-gray-300">I accept the <a className="font-medium text-primary-600 hover:underline dark:text-primary-500" href="{}">Terms and Conditions</a></label>
                                    </div>
                                </div>
                                <div className="flex justify-center">
                                <button className="relative inline-flex items-center w-3/4 justify-center p-0.5 mb-2 mr-2 overflow-hidden text-sm font-medium text-gray-900 rounded-lg group bg-gradient-to-br from-purple-600 to-blue-500 group-hover:from-purple-600 group-hover:to-blue-500 hover:text-white dark:text-white focus:ring-4 focus:outline-none focus:ring-blue-300 dark:focus:ring-blue-800" type="Submit">
                                    <span className="relative px-5 py-2  w-3/4">
                                    Sign in 
                                    </span>
                                </button>       
                                </div>            
                                <p className="text-sm font-light text-gray-500 dark:text-gray-400">
                                    Don't have an account? <a href="{}" className="font-medium text-primary-600 hover:underline dark:text-primary-500"><span className="text-blue-300 ">Sign up</span></a>
                                </p>
                            </form>
                        </div>
                    </div>
                </div>
         </section>
        </>
    )
}
export default Signin;
