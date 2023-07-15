const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth2').Strategy;
const User = require('../models/user');
const mongoose = require('mongoose');
const dataCryption = require('../helpers/dataprotector');

passport.use(
  new GoogleStrategy(
    {
      clientID: process.env.CLIENT_ID,
      clientSecret: process.env.CLIENT_SECRET,
      callbackURL: '/auth/google/redirect',
      passReqToCallback: true,
    },
    async (request, accessToken, refreshToken, profile, done) => {
      try {
        const user = await User.findOne({
          $or: [{ email: profile._json.email }, { googleId: profile._json.sub }],
        });

        if (user) {
          done(null, user);
        } else {
          const isVerified = profile._json.email_verified;
          const newUser = new User({
            fullName: profile.displayName,
            email: profile.email,
            googleId: profile.id,
            isVerified,
            phone: dataCryption.encryption(profile._json.sub),
          });

          const savedUser = await newUser.save();
          done(null, savedUser);
        }
      } catch (err) {
        console.log('Passport caught an error:', err);
        return done(err);
      }
    }
  )
);

passport.serializeUser((user, done) => {
  done(null, user._id);
});

passport.deserializeUser(async (id, done) => {
  try {
    const user = await User.findById(id);
    done(null, user);
  } catch (err) {
    done(err, null);
  }
});
