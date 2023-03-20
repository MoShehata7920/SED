var CryptoJS = require("crypto-js");


// Encrypt
exports.encryptData=(data)=>{
    return CryptoJS.AES.encrypt(JSON.stringify(data), process.env.SECRET_KEY).toString();
};

// Decrypt
exports.decryptdData=(data)=>{
    var bytes = CryptoJS.AES.decrypt(data,process.env.SECRET_KEY);
    return JSON.parse(bytes.toString(CryptoJS.enc.Utf8));
};
