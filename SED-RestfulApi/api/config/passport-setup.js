const passport = require('passport');
const GoogleStrategy = require('passport-google-oauth20');
const User = require('../models/User');
const dataCryption = require('../helpers/dataprotector');



passport.use(
    new GoogleStrategy(

        {
            clientID: process.env.clientID,
            clientSecret: process.env.clientSecret,
            callbackURL: "/auth/google/redirect",
            passReqToCallback: true,
        },

        async (request, accessToken, refreshToken, profile, done) => {
            try {
                console.log(profile._json)
                const user = await User.findOne({
                    $or: [{ email: profile._json.email },
                    { googleId: profile._json.sub }]
                });
                if (user) {
                    done(null, user);
                } else {
                    const encryptedFirstName = dataCryption.encryptData(profile._json.given_name);
                    const encryptedLastName = dataCryption.encryptData(profile._json.family_name);
                    const userName = profile._json.given_name + '_' + profile._json.family_name + '$123';
                    const isVerified = profile._json.email_verified;
                    const email= profile._json.email

                    const newUser = await new User({
                        firstName: encryptedFirstName,
                        lastName: encryptedLastName,
                        userName,
                        phone: dataCryption.encryptData(profile._json.sub),
                        email,
                        isVerified,
                        googleId: profile._json.sub
                    }).save();

                    done(null, newUser);
                }
            } catch (error) {
                return done(error);
            }
        }

    )
);



passport.serializeUser((user, done) => {      // pass user info to fn and it store just user id into cookies
    done(null, user.id);
});

passport.deserializeUser((id, done) => {      // gets user info by its id from cookies
    User.findById(id).then((user) => {
        done(null, user);
    });
});
