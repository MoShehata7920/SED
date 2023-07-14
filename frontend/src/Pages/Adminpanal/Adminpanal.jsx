import { Link, Outlet } from "react-router-dom";
import Footer from "../../Component/footer/Footer";
// import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
export default function AdminPanal() {
  // const GetApi = `/users/get`;
  // const { data, isPending, error } = UseAxiosGet(GetApi);
  // let datauser = data ? data.user : "";
  return (
    <>
      <section>
        <div>
          <Outlet></Outlet>
        </div>
      </section>
      <section>
        <Footer />
      </section>
    </>
  );
}
