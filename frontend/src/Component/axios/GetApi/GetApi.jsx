import { useState, useEffect } from "react";
import axios from "axios";
import { decrypt } from "n-krypta";
export const UseAxiosGet = (url) => {
  const secret = process.env.REACT_APP_SECRET_KEY;
  const storedEncryptedData =
    localStorage.getItem("encryptedToken") ?? "nothing";
  const decryptedData = decrypt(storedEncryptedData, secret);
  const API_KEY = process.env.REACT_APP_API_KEY;
  const [data, setData] = useState(null);
  const [dataUser, setdataUser] = useState(null);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const getData = async () => {
      setError(null);
      setIsPending(true);

      try {
        let { data } = await axios.get(`${API_KEY}${url}`, {
          headers: {
            Authentication: `Bearer ${decryptedData}`,
          },
        });
        setIsPending(false);
        setData(data);
        //setError(null);
      } catch (err) {
        setIsPending(false);
        setData(null);
        setError("could not fetch the data");
      }
    };

    getData();
  }, [url]);

  return { data, isPending, error };
};
