const product = require('../models/Product');
const category = require('../models/categories');
const images = require('../models/appImages');

exports.getHomePage = async (req, res, next) => {
    const page = 1
    const perPage = 10;

    try {
        const carouselPromise = images.find({ imageFor: 'carousel' })
            .select('Image')
            .lean()
            .exec();
        const categoriesPromise = category.find({})
            .select('Name Image')
            .lean()
            .exec();
        const sellPromise = product.find({ productFor: 'sale' })
            .limit(perPage)
            .select('name description price image seller createdAt')
            .lean()
            .exec();
        const donatePromise = product.find({ productFor: 'donation' })
            .limit(perPage)
            .select('name description price image seller createdAt')
            .lean()
            .exec();
        const exchangePromise = product.find({ productFor: 'exchange' })
            .limit(perPage)
            .select('name description price image seller createdAt')
            .lean()
            .exec();
        const sectionsPromise = images.find({ imageFor: 'sections' })
            .select('Image SectionId')
            .lean()
            .exec();

        const [carousel, categories, sellItems, donateItems, exchangeItems, sections] =
            await Promise.all([
                carouselPromise,
                categoriesPromise,
                sellPromise,
                donatePromise,
                exchangePromise,
                sectionsPromise,
            ]);

        res.status(200).json({
            carousel,
            categories,
            sellItems,
            donateItems,
            exchangeItems,
            sections,
            status: 0,
            message: 'Successfully loaded data',
        });
    } catch (error) {
        console.error(error);
        res.status(500).json({ status: 1, message: 'Internal server error' });
    }
};
