const CryptoJS=require('crypto-js')
// to encrypt and decrypt data in and out of our database to be more secure
exports.encryption = (information) => 
    CryptoJS.AES.encrypt(information, process.env.cryptoJS_Key).toString()

exports.decryption = (encryptedInfo) => {
    return CryptoJS.AES.decrypt(encryptedInfo,process.env.cryptoJS_Key).toString(CryptoJS.enc.Utf8)
    }