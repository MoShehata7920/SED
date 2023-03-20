const nodemailer = require('nodemailer')
const crypto = require('crypto')

exports.generateOTP = () => {
    return crypto.randomInt(100000, 999999).toString();
}

exports.mailTransport = () =>  //{
    nodemailer.createTransport({
        service: "hotmail",
        auth: {
            user: process.env.MYMAIL,
            pass: process.env.MAILPASSWORD
        }
    });
//}


exports.generateForgotPasswordTemplate = url => {
    return `
  <!doctype html>
  <html lang="en-US">
  
  <head>
      <meta content="text/html; charset=utf-8" http-equiv="Content-Type" />
      <title>Reset Password Email Template</title>
      <meta name="description" content="Reset Password Email Template.">
      <style type="text/css">
          a:hover {text-decoration: underline !important;}
          /* Add styles to the logo */
      .logo {
        display: block;
        margin: 20px auto;
        max-width: 200px;
        border-radius: 50%;
        overflow: hidden;
      }
      </style>
  </head>
  
  <body marginheight="0" topmargin="0" marginwidth="0" style="margin: 0px; background-color: #f2f3f8;" leftmargin="0">
      <!--100% body table-->
      <table cellspacing="0" border="0" cellpadding="0" width="100%" bgcolor="#f2f3f8"
          style="@import url(https://fonts.googleapis.com/css?family=Rubik:300,400,500,700|Open+Sans:300,400,600,700); font-family: 'Open Sans', sans-serif;">
          <tr>
              <td>
                  <table style="background-color: #f2f3f8; max-width:670px;  margin:0 auto;" width="100%" border="0"
                      align="center" cellpadding="0" cellspacing="0">
                      <tr>
                          <td style="height:80px;">&nbsp;</td>
                      </tr>
                      <tr>
                          <td style="height:20px;">&nbsp;</td>
                      </tr>
                      <tr>
                          <td>
                              <table width="95%" border="0" align="center" cellpadding="0" cellspacing="0"
                                  style="max-width:670px;background:#fff; border-radius:3px; text-align:center;-webkit-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);-moz-box-shadow:0 6px 18px 0 rgba(0,0,0,.06);box-shadow:0 6px 18px 0 rgba(0,0,0,.06);">
                                  <tr>
                                      <td style="height:40px;">&nbsp;</td>
                                  </tr>
                                  <tr>
                                      <td style="padding:0 35px;">
                                      <img class="logo"  src="https://i.pinimg.com/originals/ea/6a/73/ea6a73674b0a6ab38e171afc421ceaa1.png" title="logo" alt="logo">
                                          <h1 style="color:#1e1e2d; font-weight:500; margin:0;font-size:18px;font-family:'Rubik',sans-serif;">You have
                                              requested to reset your password</h1>
                                          <span
                                              style="display:inline-block; vertical-align:middle; margin:29px 0 26px; border-bottom:1px solid #cecece; width:100px;"></span>
                                          <p style="color:#455056; font-size:15px;line-height:24px; margin:0;">
                                              We cannot simply send you your old password. A unique link to reset your
                                              password has been generated for you. To reset your password, click the
                                              following link and follow the instructions.
                                          </p>
                                          <a href="${url}"
                                              style="background:#20e277;text-decoration:none !important; font-weight:500; margin-top:35px; color:#fff;text-transform:uppercase; font-size:14px;padding:10px 24px;display:inline-block;border-radius:50px;">Reset
                                              Password</a>
                                      </td>
                                  </tr>
                                  <tr>
                                      <td style="height:40px;">&nbsp;</td>
                                  </tr>
                              </table>
                          </td>
                      <tr>
                          <td style="height:20px;">&nbsp;</td>
                      </tr>
                      <tr>
                          <td style="text-align:center;">
                              <p style="font-size:14px; color:rgba(69, 80, 86, 0.7411764705882353); line-height:18px; margin:0 0 0;">&copy; <strong>www.sedapp.com</strong></p>
                          </td>
                      </tr>
                      <tr>
                          <td style="height:80px;">&nbsp;</td>
                      </tr>
                  </table>
              </td>
          </tr>
      </table>
      <!--/100% body table-->
  </body>
  </html>`
};


exports.generateResetedPasswordTemplate= email=>{
    return `
    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="UTF-8">
    <title>Password Reset Done</title>
    <style type="text/css">
      /* Set default font styles */
      body {
        font-family: Arial, sans-serif;
        font-size: 14px;
        line-height: 1.5;
        color: #333;
      }
      /* Center the content */
      .container {
        max-width: 600px;
        margin: 0 auto;
      }
      /* Add styles to the logo */
      .logo {
        display: block;
        margin: 20px auto;
        max-width: 200px;
        border-radius: 50%;
        overflow: hidden;
      }
      /* Add styles to the subject */
      .subject {
        font-size: 14px;
        font-weight: bold;
        margin-top: 30px;
        text-align: center;
      }
      /* Add styles to the message content */
      .message {
        margin-top: 20px;
      }
      /* Add styles to the footer */
      .footer {
        margin-top: 40px;
        font-size: 12px;
        color: #999;
        text-align: center;
      }
    </style>
  </head>
      <body>
      <div class="container">
        <img class="logo" src="https://i.pinimg.com/originals/ea/6a/73/ea6a73674b0a6ab38e171afc421ceaa1.png" alt="Logo" />
        <h4 class="subject">New Password Confirmiation</h4>
        <div class="message">
        <p>Hello,</p>
        <p>This is a confirmation that the password for your account ${email} has just been changed.</p>
        <p>Regards,</p>
        <p>The SED App Team</p>
        </div>
        <div class="footer">
        <p>Copyright © 2023 SED App.
        </p>
      </div>
        </div>
      </body>
    </html>
  `
};

exports.generateVerifyEmailTemplate=otp=>{
    return  `
    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="UTF-8">
    <title>Verification OTP for your account</title>
    <style type="text/css">
      /* Set default font styles */
      body {
        font-family: Arial, sans-serif;
        font-size: 14px;
        line-height: 1.5;
        color: #333;
      }
      /* Center the content */
      .container {
        max-width: 600px;
        margin: 0 auto;
      }
      /* Add styles to the logo */
      .logo {
        display: block;
        margin: 20px auto;
        max-width: 200px;
        border-radius: 50%;
        overflow: hidden;
      }
      /* Add styles to the subject */
      .subject {
        font-size: 14px;
        font-weight: bold;
        margin-top: 30px;
        text-align: center;
      }
      /* Add styles to the message content */
      .message {
        margin-top: 20px;
      }
      /* Add styles to the footer */
      .footer {
        margin-top: 40px;
        font-size: 12px;
        color: #999;
        text-align: center;
      }
    </style>
  </head>
      <body>
      <div class="container">
        <img class="logo" src="https://i.pinimg.com/originals/ea/6a/73/ea6a73674b0a6ab38e171afc421ceaa1.png" alt="Logo" />
        <h4 class="subject">Email Verification</h4>
        <div class="message">
        <p>Thank you for registering with SED App. As part of our security measures, we require all new users to verify their account.</p>
        <p>Your account verification ode is: ${otp}. Please enter this code on the verification page to complete the process.</p>
        <p>Note that this Code is valid for a limited time only and will expire in 1 Hour. If you do not verify your account within this time, you may need to request a new OTP.</p>
        <p>If you did not register for this service, please disregard this email and contact us immediately at [sedteam@outlook.com / 01556727311].</p>
        <p>Thank you for using SED</p>
        <p>The SED App Team</p>
        </div>
        <div class="footer">
        <p>Copyright © 2023 SED App.
        </p>
      </div>
        </div>
      </body>
    </html>
  `
};

exports.generateOtpVerifiedEmailTemplate=username=>{
    return `
    <!DOCTYPE html>
    <html>
    <head>
    <meta charset="UTF-8">
    <title>Account Verification Successful</title>
    <style type="text/css">
      /* Set default font styles */
      body {
        font-family: Arial, sans-serif;
        font-size: 14px;
        line-height: 1.5;
        color: #333;
      }
      /* Center the content */
      .container {
        max-width: 600px;
        margin: 0 auto;
      }
      /* Add styles to the logo */
      .logo {
        display: block;
        margin: 20px auto;
        max-width: 200px;
        border-radius: 50%;
        overflow: hidden;
      }
      /* Add styles to the subject */
      .subject {
        font-size: 14px;
        font-weight: bold;
        margin-top: 30px;
        text-align: center;
      }
      /* Add styles to the message content */
      .message {
        margin-top: 20px;
      }
      /* Add styles to the footer */
      .footer {
        margin-top: 40px;
        font-size: 12px;
        color: #999;
        text-align: center;
      }
    </style>
  </head>
      <body>
      <div class="container">
        <img class="logo" src="https://i.pinimg.com/originals/ea/6a/73/ea6a73674b0a6ab38e171afc421ceaa1.png" alt="Logo" />
        <h4 class="subject">Account Verification Successful</h4>
        <div class="message">
        <p>Dear ${username},</p>
        <p>We are pleased to inform you that your account has been successfully verified. You can now access all the features and services of our platform.</p>
        <p>We take security seriously and this extra step is necessary to ensure the safety of your account and data. Please keep your account details safe and secure and do not share them with anyone.</p>
        <p>If you have any questions or concerns, please do not hesitate to contact our support team at [sedteam@outlook.com / 01556727311].</p>
        <p>Thank you for choosing SED</p>
        <p>The SED App Team</p>
        </div>
        <div class="footer">
        <p>Copyright © 2023 SED App.
        </p>
      </div>
        </div>
      </body>
    </html>
  `
};