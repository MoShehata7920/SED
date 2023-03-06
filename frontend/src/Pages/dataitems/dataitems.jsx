import { Link, useParams } from "react-router-dom";
import Axios from "axios";
import { useEffect, useState } from "react";

export default function Dataitems() {
  let { id } = useParams();
  console.log(id);
  let [Detaitmes, setDataitems] = useState({});

  async function Getitems(id, callback) {
    let { data } = await Axios.get(`http://103.48.193.225:9000/Items/${id}`);
    console.log(data);
    callback(data.item);
  }
  useEffect(() => {
    Getitems(id, setDataitems);
  }, []);
  return (
    <>
      <section className="w-100 h-100">
        <img
          src={Detaitmes.Image}
          className="card-img-top w-100 h-100  "
          alt="..."
        />
      </section>
    </>
  );
}
