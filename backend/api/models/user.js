const mongoose=require('mongoose')


const userSchema= mongoose.Schema({
    email:{
        type:String   ,
        required:true ,
        unique:true   ,
        match:/[a-z0-9!#$%&'*+/=?^_`{|}~-]+(?:\.[a-z0-9!#$%&'*+/=?^_`{|}~-]+)*@(?:[a-z0-9](?:[a-z0-9-]*[a-z0-9])?\.)+[a-z0-9](?:[a-z0-9-]*[a-z0-9])?/  
    } ,

    fullName:{
        type:String,
        required:true,
        match: /^([a-zA-Z ]){4,30}$/             // Full Name Validation aA to zZ and between 2 and 30 char
    } ,

    password:{
        type:String,
    } ,

    isAdmin:{
        type:Boolean,
        default:false
    } ,

    googleId: { type : String } ,

    verified : {
        type:Boolean,
        default:false,
        required:true
    } ,
    reset_password_token:{
        type:String
    } ,
    reset_password_expires:{
        type:Date
    } ,

    personalInfo:{                          //  for next level 'to be updated in user profile'
        phone:{type:Number},                //  default:""
        government:{type : String},
        address:{type:String}
    } , 

    createdAt:{
        type:Date,
        default:Date.now()
    },
    updatedAt:{
        type:Date,
        default:Date.now()
    }

} )

userSchema.index({email:1});


module.exports=mongoose.model('User',userSchema)