const CryptoJS = require('crypto-js');

exports.encryption = (information) => {
  const encryptedInfo = CryptoJS.AES.encrypt(information, process.env.cryptoJS_Key).toString();
  return encryptedInfo;
};

exports.decryption = (encryptedInfo) => {
  const decryptedInfo = CryptoJS.AES.decrypt(encryptedInfo, process.env.cryptoJS_Key).toString(CryptoJS.enc.Utf8);
  return decryptedInfo;
};
