import { Link } from "react-router-dom";
import "./Home.css";

export default function Home() {
  return (
    <>
      <div className="App">
        <button>
          <Link to="SignIn">hello</Link>
        </button>
      </div>
    </>
  );
}
