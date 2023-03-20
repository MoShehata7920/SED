const jwt = require('jsonwebtoken');

module.exports = (req, res, next) => {
    try {
        const token = req.headers.authorization.split(' ')[1];
        const decodedToken = jwt.verify(token, process.env.SECRET_KEY);
        req.userData = decodedToken;
        next();
    } catch {
        res.status(401).json({ message: 'error authenticating' });
    }
};
