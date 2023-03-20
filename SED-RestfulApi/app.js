
const http = require('http');
var createError = require('http-errors');
var express = require('express');
var path = require('path');
var logger = require('morgan');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
var cors=require('cors');
const session = require('express-session');
const passport = require('passport');
const hbs = require('hbs');

// load environment variables
require('dotenv').config();

require('./api/config/passport-setup');

// define Routers
var homeRouter = require('./api/routes/home');
var productsRouter = require('./api/routes/products');
var authRouter = require('./api/routes/auth');
var usersRouter=require('./api/routes/users');
var chatRouter=require('./api/routes/chat');

var app = express();

// connecting Database
(async () => {
  try {
    await mongoose.connect(process.env.Mongo_ConnectUrl, {
      useNewUrlParser: true,
      useUnifiedTopology: true
    });
    console.log('Connected to DB');
  } catch (err) {
    console.log(err);
  }
})();

// middleware chain
app.use(cors());
app.use(logger('dev'));
app.use(express.json());
app.use(express.urlencoded({ extended: false }));
app.use(bodyParser.json());
app.use(session({
  secret: process.env.SECRET_KEY,
  resave: true,
  saveUninitialized: false
}));
app.use(passport.initialize());
app.use(passport.session());
app.use(express.query());
app.use(express.static(path.join(__dirname, 'SEDimages')));
app.set('view engine', 'hbs'); // Set view engine to HBS
app.set('views', path.join(__dirname, 'views')); // Set views directory
hbs.registerPartials(path.join(__dirname, 'views/partials')); // Register partials directory
// using routers
app.use('/', homeRouter);
app.use('/products', productsRouter);
app.use('/auth', authRouter);
app.use('/users', usersRouter);
app.use('/chat', chatRouter);

// error handler
app.use(function (err, req, res, next) {
  // set locals, only providing error in development
  res.locals.message = err.message;
  res.locals.error = req.app.get('env') === 'development' ? err : {};

  // show the error
  res.status(err.status || 500).json({message: err.message});
});

// catch 404 and forward to error handler
app.use(function (req, res, next) {
  next(createError(404));
});


module.exports = app;



