const express=require('express')
require('dotenv').config()
const mongoose=require('mongoose')
const PORT=process.env.PORT || 8080
const morgan = require('morgan')
const app=express()
const cors = require('cors')
app.use(morgan('dev'))
app.use(cors())
app.use(express.json())

//static middleware  for product images 
app.use('/uploads',express.static('uploads'))

//google auth part
const passport=require('passport')
const cookieSession=require('cookie-session')
    //initializing cookies        
app.use(cookieSession({
    maxAge:6 * 60 * 60 * 1000 ,           // 6 hors = 6 h x 60min x 60sec x 1000 cuz it millisecond   
    keys:[process.env.COOKIES_KEY3]    
}))
    //passport middlewares
app.use(passport.initialize());
app.use(passport.session());


//mongoose Connection
mongoose.set('strictQuery', true)        //  suppressing the warning of the new coming update in mongoose 7 
mongoose.connect(process.env.MONGO_URL).then(()=>{console.log('Connected Successfully To SED Database')})

//importing routes files
const usersRoute=require('./api/routes/users')
const productsRoute=require('./api/routes/products')
const authRoute=require('./api/routes/auth')     

//forwarding routes
app.use('/api/users',usersRoute)
app.use('/api/products',productsRoute)
app.use('/google',authRoute)                    


app.get('',(req,res)=>{
    res.send('Hello Eagles <3 ')
})


//handling general error in the request       // must be after all routings
app.use((req,res,next)=>{
    const error=new Error('Not Found')
    error.status=404
    next(error)
})

app.use((error,req,res)=>{
    console.log(error.message);
    res.status(error.status || 500).json({error : 'Not Found'})
})


app.listen(PORT,()=>{
    console.log(`The Server Is Working And listening to Port ${PORT}`);
})