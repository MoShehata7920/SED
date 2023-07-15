import "./AllUser.css";
import AdminInfo from "../../../Component/AdminInfo/AdminInfo";
import { UseAxiosGet } from "../../../Component/axios/GetApi/GetApi";
import Paginate from "../../../Component/pagination/Paginate";
import { useState } from "react";
import { Link } from "react-router-dom";
export default function AllUser() {
  let [currentpageNum, setcurrentpageNum] = useState(1);
  // let totalpageNum = data ? data.totalPageNumber : 1;
  let totalpageNum = 1;
  const paginate = (pageNumber) => {
    if ("") {
      setcurrentpageNum(1);
    } else {
      setcurrentpageNum(pageNumber);
    }
    console.log("current", currentpageNum);
  };
  const GetApi = `/users/getallusers`;
  const { data, isPending, error } = UseAxiosGet(GetApi);
  let datauser = data ? data.users : [];

  return (
    <>
      <section>
        <AdminInfo />
      </section>
      <section className=" container-fluid mt-2 mb-2">
        <div className="  border border-2 ">
          <table class="table">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">All Details</th>
                <th scope="col">Image</th>
                <th scope="col">Name</th>
                <th scope="col">Email</th>
                <th scope="col">Phone Number</th>
              </tr>
            </thead>
            <tbody>
              {datauser.map((Users, index) => (
                <tr>
                  <th scope="row">{index + 1}</th>
                  <Link to={`/Admin/Users_Data/${Users._id}`}>
                    <td>
                      <button className="btn btn-primary">Show</button>
                    </td>
                  </Link>
                  <td className=" AdminUseerinfo_Img_hight">
                    <img
                      src={Users.userImage}
                      alt=""
                      className=" w-100 h-100  rounded-circle  "
                    />
                  </td>
                  <td>{Users.fullName}</td>
                  <td>{Users.email}</td>
                  {Users.phone > 12 ? <td>{Users.phone}</td> : <td> </td>}
                </tr>
              ))}
            </tbody>
          </table>
        </div>
        <div className=" d-flex justify-content-center mt-4 ">
          <Paginate paginate={paginate} totalpageNum={totalpageNum} />
        </div>
      </section>
    </>
  );
}
