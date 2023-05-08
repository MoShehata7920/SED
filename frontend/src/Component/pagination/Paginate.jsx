import { Link, useParams } from "react-router-dom";
import { PaginationControl } from "react-bootstrap-pagination-control";
import { useState } from "react";
export default function Paginate({ paginate, totalpageNum }) {
  const [pageNum, setpageNum] = useState(1);

  return (
    <>
      <PaginationControl
        last={true}
        page={pageNum}
        between={4}
        total={totalpageNum}
        limit={1}
        changePage={(page) => {
          paginate(page);
          setpageNum(page);
          window.scrollTo(0, 0);
        }}
        ellipsis={1}
      />
    </>
  );
}
