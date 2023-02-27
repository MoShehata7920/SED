const passportSetup=require('../config/passport-setup')
const passport=require('passport')
const router=require('express').Router()

router.get('/',(req,res)=>{
    res.send("<button><a href='/google/auth'>Login With Google</a></button>")
})

router.get('/auth' , passport.authenticate('google', { scope:
    [ 'email', 'profile' ]
}));
router.get('/auth/callback',passport.authenticate('google',{failureRedirect:'/'}),(req,res)=>{
    res.send(req.user)
})
router.get('/logout',(req,res)=>{
    req.logout()
    res.redirect('/')
})

module.exports=router;