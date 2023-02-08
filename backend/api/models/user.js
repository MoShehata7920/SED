const mongoose=require('mongoose')


const userSchema= mongoose.Schema({
    id:mongoose.Schema.Types.ObjectId ,

    email:{
        type:String   ,
        required:true ,
        unique:true   ,
        match:/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/  
    },

    fullName:{
        type:String,
        required:true,
        match: /^([a-zA-Z ]){2,30}$/             // Full Name Validation aA to zZ and between 2 and 30 char
    },

    password:{
        type:String,
        required:true
    }

} , {timestamps:true} )


module.exports=mongoose.model('User',userSchema)