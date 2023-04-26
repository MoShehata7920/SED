import { Link, useParams } from "react-router-dom";
import { useState } from "react";
export default function Paginate({ paginate }) {
  const [pageNum, setpageNum] = useState(1);
  const pageNumber = [];
  for (let i = 1; i <= 5; i++) {
    pageNumber.push(i);
  }
  return (
    <>
      <nav aria-label="Page navigation example">
        <ul class="pagination">
          <li class="page-item">
            <Link
              to={`#`}
              onClick={() => {
                paginate(pageNum - 1);
                window.scrollTo(0, 0);
              }}
              class="page-link"
            >
              Previous
            </Link>
          </li>

          {pageNumber.map((number) => (
            <li key={number} class="page-item">
              <Link
                to={`#`}
                onClick={() => {
                  window.scrollTo(0, 0);
                  paginate(number);
                  setpageNum(number);
                }}
                class="page-link"
              >
                {number}
              </Link>
            </li>
          ))}
          <li class="page-item">
            <Link
              to={`#`}
              onClick={() => {
                paginate(pageNum + 1);
                window.scrollTo(0, 0);
              }}
              class="page-link"
            >
              Next
            </Link>
          </li>
        </ul>
      </nav>
    </>
  );
}
