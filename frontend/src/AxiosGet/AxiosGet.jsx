import { useState, useEffect } from "react";
import axios from "axios";

export const useAxiosGet = (url) => {
  const [data, setData] = useState(null);
  const [isPending, setIsPending] = useState(false);
  const [error, setError] = useState(null);

  useEffect(() => {
    const getData = async () => {
      setError(null);
      setIsPending(true);

      try {
        let { data } = await axios.get(url);
        console.log(data);

        setIsPending(false);
        setData(data);
        //setError(null);
      } catch (err) {
        setIsPending(false);
        setData(null);
        setError("could not fetch the data");
        console.log(err.message);
      }
    };

    getData();
  }, [url]);

  return { data, isPending, error };
};
