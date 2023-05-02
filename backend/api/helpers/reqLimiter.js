const rateLimit = require('express-rate-limit')

// setting limiting for request mainly 100 request per hour

const limiter = rateLimit({
	windowMs:  60 * 60 *1000, // 60 minutes = 1 hour
	max: 100 , // Limit each IP to 100 requests per 1 hour
	standardHeaders: true, // Return rate limit info in the `RateLimit-*` headers
	legacyHeaders: false, // Disable the `X-RateLimit-*` headers
})


module.exports={limiter}