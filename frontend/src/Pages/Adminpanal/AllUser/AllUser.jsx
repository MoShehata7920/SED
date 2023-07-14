import Userinfo from "../../Profile/Userinfo/Userinfo";

export default function AllUser() {
  return (
    <>
      <section>
        <Userinfo />
      </section>
      <section className=" container-fluid mt-2 mb-2">
        <div className="  border border-2 ">
          <table class="table">
            <thead>
              <tr>
                <th scope="col">#</th>
                <th scope="col">All Details</th>
                <th scope="col">Name</th>
                <th scope="col">Email</th>
                <th scope="col">Product_NUM</th>
                <th scope="col">Action</th>
              </tr>
            </thead>
            <tbody>
              <tr>
                <th scope="row">1</th>
                <td>
                  <button className="btn btn-primary">Show</button>
                </td>
                <td>Abdelrhman ezzat saad</td>
                <td>abdo.ezzat2323@gmail.com</td>
                <td>3</td>
                <td>
                  <button className="btn btn-primary">Remove</button>
                </td>
              </tr>
              <tr>
                <th scope="row">2</th>
                <td>
                  {" "}
                  <button className="btn btn-primary">Show</button>
                </td>
                <td>Abdelrhman ezzat saad</td>
                <td>abdo.ezzat2323@gmail.com</td>
                <td>3</td>
                <td>
                  <button className="btn btn-primary">Remove</button>
                </td>
              </tr>
              <tr>
                <th scope="row">3</th>
                <td>
                  {" "}
                  <button className="btn btn-primary">Show</button>
                </td>
                <td>Abdelrhman ezzat saad</td>
                <td>abdo.ezzat2323@gmail.com</td>
                <td>3</td>
                <td>
                  <button className="btn btn-primary">Remove</button>
                </td>
              </tr>
            </tbody>
          </table>
        </div>
      </section>
    </>
  );
}
