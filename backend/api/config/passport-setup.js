const passport=require('passport')
const GoogleStrategy = require("passport-google-oauth2").Strategy;
const User=require('../models/user')
const mongoose=require('mongoose')


passport.use(
    new GoogleStrategy(

      {
        clientID: process.env.CLIENT_ID, 
        clientSecret: process.env.CLIENT_SECRET,
        callbackURL: "/google/auth/callback",
        passReqToCallback: true,
      },

      (request, accessToken, refreshToken, profile, done) => {
        User.findOne({ googleId: profile.id }).then((user) => {       // checking if user already exists
          if (user) {                                               // this means user already exist and registered before 
            // console.log(user);
            done( null, user);
          } else {                                                   // creating a new user and saving it into our DB
            new User({
              fullName: profile.displayName,
              email: profile.email,
              googleId: profile.id,
            })
              .save()
              .then((user) => {
                done(null, user);
              })
              .catch((err) => {
                console.log('Passport cought error'+err);
              });
          }
        });
      }
    )
  );
  

  
  passport.serializeUser((user, done) => {      // pass user info to fn and it store just user id into cookies
    done(null, user._id);
  });
  
  passport.deserializeUser((id, done) => {      // gets user info by its id from cookies
    User.findById(id).then((user) => {
      done(null, user);
    });
  });