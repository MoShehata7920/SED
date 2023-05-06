const jwt=require('jsonwebtoken')

const verifyToken=(req,res,next)=>{
    try {
        const token=req.headers.authentication.split(' ')
        const checker=jwt.verify(token[1] , process.env.SECRET_KEY , (err,decoded)=>{
            if(err){
                return res.status(403).json('Token Not Vaild')
            }
            req.user=decoded
            next()    // to continue to the next function 

        })
    } catch (error) {
        console.log(error);
        res.status(500).json({status:0,message:"Error Authentication Failed"})
    }
};

const verifyTokenWithReturn=(header)=>{
        const token=header.split(' ')
        const checker=jwt.verify(token[1] , process.env.SECRET_KEY , (err,decoded)=>{
            if(err){
                console.log(err);
            }
            return decoded
        })
        return checker
};

const verifyTokenAndAdmin=(req,res,next)=>{     // a function to check if the one who tries to access something is loggedin & admin
    verifyToken(req,res,()=>{
        if(req.user.isAdmin){
            next()
        }else{
            res.status(403).json({status:0,message:'You Are Not Allowed to do that'})
        }
    })
};

const verifyTokenAndAuthorization=(req,res,next)=>{
    verifyToken(req,res,()=>{
        if(req.params.id==req.user._id || req.user.isAdmin){   // checks if the same user editing his self or an admin
            next()
        }else{
            res.status(500).json({status:0,message:'You are not authorized  \' development msg: it must be you or your item to edit \' '})
        }
    })
};

module.exports={verifyToken,verifyTokenAndAdmin,verifyTokenAndAuthorization, verifyTokenWithReturn};