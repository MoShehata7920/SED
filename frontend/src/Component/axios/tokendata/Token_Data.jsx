import { decrypt } from "n-krypta";

export function getUserId() {
  const secret = process.env.REACT_APP_SECRET_KEY;
  const storedEncryptedData =
    localStorage.getItem("encryptedToken") ?? "nothing";
  const decryptedData = decrypt(storedEncryptedData, secret);
  try {
    const decodedToken = atob(decryptedData.split(".")[1]);
    const tokenData = JSON.parse(decodedToken);
    return tokenData;
  } catch (error) {
    console.log("Error decoding JWT token: ", error);
    return null;
  }
}

// const userId = getUserId();
// console.log(userId);
