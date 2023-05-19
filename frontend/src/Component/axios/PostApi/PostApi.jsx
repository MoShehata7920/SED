import { useState, useEffect } from "react";
import axios from "axios";
import { decrypt } from "n-krypta";
export const UseAxiosPost = (url, formData) => {
  const secret = process.env.REACT_APP_SECRET_KEY;
  const storedEncryptedData =
    localStorage.getItem("encryptedToken") ?? "nothing";
  const decryptedData = decrypt(storedEncryptedData, secret);
  const API_KEY = process.env.REACT_APP_API_KEY;
  const [data, setData] = useState(null);
  const [response, setResponse] = useState("");
  const [ErrorMessage, setErrorMessage] = useState("");
  const HandelPostApi = async () => {
    let request = await axios
      .post(`${API_KEY}${url}`, formData, {
        headers: {
          Authentication: `Bearer ${decryptedData}`,
        },
      })

      .then((response) => {
        setResponse(response.data.message);
        setData(response.data.token);
      })
      .catch((error) => {
        // check for the response property of the error object
        if (error.response) {
          // set the error message state variable with the error message
          setErrorMessage(error.response.data.message);
        }
      });
  };

  return { response, data, ErrorMessage, HandelPostApi };
};
