const nodemailer=require('nodemailer')
const mailtrap=require('mailtrap')

exports.generateOTP = () => {
    let otp=''
    for (let index = 0; index <= 3; index++) {
        const randomValue = Math.round(Math.random()*9)
        otp +=randomValue
    }
    return otp
}

exports.mailTransport = () =>  //{
     nodemailer.createTransport({
       host: "sandbox.smtp.mailtrap.io",
       port: 2525,
       auth: {
         user: process.env.MAILTRAP_USERNAME,
         pass:process.env.MAILTRAP_PASSWORD,
       },
     });
//}