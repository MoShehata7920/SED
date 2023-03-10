const Images = require('../models/appImages');        // could be renamed to appImages for to be easy to remember/differentiate
const mongoose = require('mongoose');

mongoose.set('strictQuery', true);
mongoose.connect('mongodb+srv://admin:admin@cluster0.qoxzbzd.mongodb.net/?retryWrites=true&w=majority',{ useNewUrlParser: true, useUnifiedTopology: true } ).then(()=>{console.log('Connected Successfully To SED Database')})


const images = [
    new Images({
        imageLocation: "carousel",
        image: "https://th.bing.com/th/id/R.084fd0c25ad58bad8bb52f76e10bd580?rik=DT6I4IYRKNCqmg&pid=ImgRaw&r=0"
    }),
    new Images({
        imageLocation: "carousel",
        image: "https://th.bing.com/th/id/R.c034c6cef5b4eb2d6a93dfa550b8d6dd?rik=n1fHSTD7Xv9Ucg&pid=ImgRaw&r=0"
    }),
    new Images({
        imageLocation: "carousel",
        image: "https://th.bing.com/th/id/R.ecc0a326f9d4f209ef4db88fa20147bf?rik=Hlz25dfYoeKsIA&pid=ImgRaw&r=0"
    }),
    new Images({
        imageLocation: "carousel",
        image: "https://th.bing.com/th/id/R.fcd5baf17474e6c7c0ed64c12881b2d1?rik=1ACHNsHbShLLrw&pid=ImgRaw&r=0"
    }),
    new Images({
        imageLocation: "carousel",
        image: "https://th.bing.com/th/id/R.abe3c612e64ec16c928b63525e24ef87?rik=uiFoZnHYw6TVzA&pid=ImgRaw&r=0"
    }),
    new Images({
        imageLocation: "sections",
        image: "https://eg.jumia.is/cms/Ramadan-23/General-UNs/Entertainment/xwfa.png",
        SectionId: 1
    }),
    new Images({
        imageLocation: "sections",
        image: "https://eg.jumia.is/cms/Ramadan-23/Motherday/installments/hh8.gif",
        SectionId: 2
    }),
    new Images({
        imageLocation: "sections",
        image: "https://eg.jumia.is/cms/Ramadan-23/Banks/INST6.gif",
        SectionId: 3
    }),

];

var done = 0;

for (var i = 0; i < images.length; i++) {
    images[i].save().
        then(doc => {
            done++
            console.log('added');
            if ( done === images.length ) {
                mongoose.disconnect();
            };
        }).catch(err => {
            console.log(err);
            mongoose.disconnect();
        });
};
