import OwlCarousel from "react-owl-carousel";

import Axios from "axios";
import { useEffect, useState } from "react";

export default function Carousellider() {
  const options = {
    margin: 20,
    loop: true,
    autoplay: true,
    autoplayTimeout: 5000,
    autoplayHoverPause: true,
    responsive: {
      0: {
        items: 1,
      },
      400: {
        items: 1,
      },
      600: {
        items: 1,
      },
      700: {
        items: 1,
      },
      1000: {
        items: 1,
      },
    },
  };
  let [DetaAll, setDetaAll] = useState([]);
  async function GetcarouselDeta() {
    let respond = await Axios.get(`http://103.48.193.225:9000/home`);

    setDetaAll(respond.data.carousel.Images);
    console.log(respond.data.carousel);
  }
  useEffect(() => {
    GetcarouselDeta();
  }, []);
  return (
    <>
      <OwlCarousel className="slider-style " {...options}>
        {DetaAll.map((carous, carousindex) => (
          <div key={carousindex} className="item">
            <img className="" src={carous} alt="" />
          </div>
        ))}
      </OwlCarousel>
    </>
  );
}
