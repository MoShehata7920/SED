const jwt=require('jsonwebtoken')

const verifyToken=(req,res,next)=>{
    try {
        const token=req.headers.authentication.split(' ')
        const checker=jwt.verify(token[1] , process.env.SECRET_KEY , (err,decoded)=>{
            if(err){
                res.status(403).json('Token Not Vaild')
            }
            // console.log("the decoded data : " + JSON.stringify(decoded)) 
            req.user=decoded
            next()    // to continue to the next function 

        })
    } catch (error) {
        console.log(error);
        res.status(500).json({message:"Error Authentication Failed"})
    }
}

const verifyTokenAndAdmin=(req,res,next)=>{     // a function to check if the one who tries to access something is loggedin & admin
    verifyToken(req,res,()=>{
        if(req.user.isAdmin){
            next()
        }else{
            res.status(403).json({message:'You Are Not Allowed to do that'})
        }
    })
}


module.exports={verifyToken,verifyTokenAndAdmin};