const express=require('express')
require('dotenv').config()
const mongoose=require('mongoose')
const PORT=process.env.PORT || 8080

const app=express()

app.get('',(req,res)=>{
    res.send('Hello Eagles <3 ')
})

app.listen(PORT,()=>{
    console.log(`The Server Is Working And listening to Port ${PORT}`);
})