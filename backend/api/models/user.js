const mongoose=require('mongoose')


const userSchema= mongoose.Schema({
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
        //required:true               // to enable google oauth and validation will be from front-end for now
    },

    isAdmin:{
        type:Boolean,
        default:false
    },

    googleId: { type : String } ,

    verified : {
        type:Boolean,
        default:false,
        required:true
    } ,
    reset_password_token:{
        type:String
    },
    reset_password_expires:{
        type:Date
    }

    // personalInfo:{                         // for next level 'to be updated in user profile'
    //     phone:{type:Number,default:""},
    //     government:{type : String ,default:""},
    //     address:{type:String,default:""}
    // }

} , {timestamps:true} )


module.exports=mongoose.model('User',userSchema)