const mongoose=require('mongoose')
const bcrypt=require('bcrypt')

const emailVerificationSchema=mongoose.Schema({
    owner:{
        type:   mongoose.Schema.Types.ObjectId,
        ref :    'User' ,
        required:true
    },
    token:{
        type:String,
        required:true
    },
    createdAt:{
        type : Date,
        expires : 3600 * 2 , // expires after 2 hour 
        default : Date.now()
    }
})

emailVerificationSchema.pre('save',async function(next){            
    if( this.isModified('token')){                     // if created a token or modified it will be encrypted
        this.token=await bcrypt.hash(this.token, 8)
    }
    next()
})

emailVerificationSchema.methods.compareToken=async function(token){
    const result=await bcrypt.compareSync(token,this.token)
    return result
}

module.exports=mongoose.model('EmailVerification',emailVerificationSchema)