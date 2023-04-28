const router = require('express').Router();
const products = require('../models/product');
const { Client } = require('@elastic/elasticsearch')

const client = new Client({
    cloud: {
        id: process.env.cloudID
    },
    auth: {
        username: process.env.elasticUsername,
        password: process.env.elasticPassword
    }
})


// Define the search endpoint
router.get('/', async (req, res) => {
  try {
      var query = req.query.q;
      if (!req.query.q) {
          query = ''
      }
      // Perform the search query using the $regex operator
      const results = await products
          .find({ productName: { $regex: query, $options: 'i' } })
          .select('productName -_id')
          .lean();

      // Return the search results
      res.status(200).json({ status: 0, results });
  } catch (err) {
      console.error(err);
      res.status(500).json({ status: 1, Error: err });
  }
});



// Define the search endpoint
router.get('/esearch', async (req, res) => {
    try {
      const query = req.query.q || '';
  
      const { body } = await client.search({
        index: 'myindex2',
        body: {
          query: {
            match: {
              query,
            }
          },
          size: 10,
          sort: [{ date: 'desc' }]
        }
      });
  
      res.status(200).json({ status: 0, results: body.hits.hits });
    } catch (err) {
      console.error(err);
      res.status(500).json({ status: 1, Error: err });
    }
  });
  




module.exports = router;