import { useEffect } from "react";
import { useState } from "react";
import axios from "axios";

function SignUp() {
  const [count, setcount] = useState([]);
  // const changeCount = () => {
  //   setcount(Math.random());
  // };
  async function getdataa() {
    let respond = await axios.get("");
    console.log();
    setcount();
  }
  useEffect(() => {
    getdataa();
  }, []);
  return (
    <>
      <div>
        {getdataa.map((movie, index) => (
          <div key={index}></div>
        ))}
      </div>
    </>
  );
}

export default SignUp;
