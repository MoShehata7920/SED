const User = require('../models/user');

exports.resetVerification = async (req, res, next) => {
  const token = req.query.token;

  if (!token) {
    return res.status(400).json({ status: 0, message: 'Invalid Request' });
  }

  const user = await User.findOne({
    reset_password_token: token,
    reset_password_expires: { $gt: Date.now() },
  });

  if (!user) {
    return res
      .status(400)
      .json({ status: 0, message: 'The token has expired or is invalid' });
  }

  if (!user.reset_password_token || !user.reset_password_expires) {
    return res
      .status(400)
      .json({ status: 0, message: 'Something went wrong. Please request a password reset again' });
  }

  if (token !== user.reset_password_token) {
    return res.status(400).json({ status: 0, message: 'Invalid reset token' });
  }

  req.user = user;
  next();
};

exports.resetVerificationByOTP = async (req, res, next) => {
  const code = req.body.code;

  if (!code) {
    return res.status(400).json({ status: 0, message: 'Invalid Request. Please enter the reset code' });
  }

  const user = await User.findOne({
    reset_password_token: code,
    reset_password_expires: { $gt: Date.now() },
  });

  if (!user) {
    return res
      .status(400)
      .json({ status: 0, message: 'The code has expired or is invalid' });
  }

  if (!user.reset_password_token || !user.reset_password_expires) {
    return res
      .status(400)
      .json({ status: 0, message: 'Something went wrong. Please request a password reset again' });
  }

  if (code !== user.reset_password_token) {
    return res.status(400).json({ status: 0, message: 'Invalid reset token' });
  }

  req.user = user;
  next();
};
