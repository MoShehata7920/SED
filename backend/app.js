const express=require('express')
require('dotenv').config()
const mongoose=require('mongoose')
const PORT=process.env.PORT || 8080

const app=express()

//mongoose Connection
mongoose.set('strictQuery', true)        //  suppressing the warning of the new coming update in mongoose 7 
mongoose.connect(process.env.MONGO_URL).then(()=>{console.log('Connected Successfully To SED Database')})


app.get('',(req,res)=>{
    res.send('Hello Eagles <3 ')
})

app.listen(PORT,()=>{
    console.log(`The Server Is Working And listening to Port ${PORT}`);
})