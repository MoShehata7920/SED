const passport=require('passport')
const GoogleStrategy = require("passport-google-oauth2").Strategy;
const User=require('../models/user')
const mongoose=require('mongoose')
const dataCryption = require('../helpers/dataprotector');


passport.use(
    new GoogleStrategy(

      {
        clientID: process.env.CLIENT_ID, 
        clientSecret: process.env.CLIENT_SECRET,
        callbackURL: "/auth/google/redirect",
        passReqToCallback: true,
      },

      (request, accessToken, refreshToken, profile, done) => {
        User.findOne({ $or: [{ email: profile._json.email },
          { googleId: profile._json.sub }] }).then((user) => {       // checking if user already exists
          if (user) {                                               // this means user already exist and registered before 
            done( null, user);
          } else {   
            const isVerified = profile._json.email_verified;                                                // creating a new user and saving it into our DB
            new User({
              // fullName:dataCryption.encryption (profile.displayName),
              fullName : profile.displayName,
              email: profile.email,
              googleId: profile.id,
              isVerified,
              // phone: dataCryption.encryption(profile._json.sub)
              'personalInfo.phone' : profile._json.sub
            })
              .save()
              .then((user) => {
                done(null, user);
              })
              .catch((err) => {
                console.log('Passport cought error'+err);
                return done(err);
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