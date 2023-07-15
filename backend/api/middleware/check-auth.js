const jwt = require('jsonwebtoken');

const verifyToken = (req, res, next) => {
  try {
    const token = req.headers.authorization.split(' ')[1];

    const decoded = jwt.verify(token, process.env.SECRET_KEY);
    req.user = decoded;
    next();
  } catch (error) {
    console.log(error);
    res.status(403).json({ status: 0, message: 'Invalid Token' });
  }
};

const verifyTokenWithReturn = (header) => {
  try {
    const token = header.split(' ')[1];
    const decoded = jwt.verify(token, process.env.SECRET_KEY);
    return decoded;
  } catch (error) {
    console.log(error);
    return null;
  }
};

const verifyTokenAndAdmin = (req, res, next) => {
  verifyToken(req, res, () => {
    if (req.user.isAdmin) {
      next();
    } else {
      res.status(403).json({ status: 0, message: 'You are not allowed to do that' });
    }
  });
};

const verifyTokenAndAuthorization = (req, res, next) => {
  verifyToken(req, res, () => {
    if (req.params.id === req.user._id || req.user.isAdmin) {
      next();
    } else {
      res.status(403).json({ status: 0, message: 'You are not allowed to do that' });
    }
  });
};

module.exports = {
  verifyToken,
  verifyTokenAndAdmin,
  verifyTokenAndAuthorization,
  verifyTokenWithReturn,
};
