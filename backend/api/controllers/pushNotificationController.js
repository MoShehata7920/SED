const axios = require('axios');

exports.sendNotification = async (req, res, next) => {
    try {
        // set notification data
        const data = {
            to: req.body.deviceId,
            notification: {
                title: req.body.title,
                body: req.body.body
            }
        };
        console.log(data)

        // serialize the data to JSON format
        const json = JSON.stringify(data);

        // set the authorization header with the server key
        const headers = {
            Authorization: 'key=AAAAjEJABFo:APA91bGIksE1nog3pWI8zGVKhtNE00l7h61s5uB_I8dR297TGsN1A5rsB7jlIYzB5QTzEoPmuCADo0eoEmDg91VHsGA8lhEOgyUOs0_kEa2E_YxZ6hBhv45wufJd6Epi1yGkl_x-2KZr',
            'Content-Type': 'application/json'
        };

        // send the POST request to FCM API
        const response = await axios.post('https://fcm.googleapis.com/fcm/send', json, { headers });

        // output the response to the console
        console.log(response.data);
        res.status(200).json({ message: "sent successfully" })

    } catch (error) {
        console.error(error);
        res.status(500).json({ message: error })
    }
};

