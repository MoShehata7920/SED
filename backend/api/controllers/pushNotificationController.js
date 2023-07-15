const axios = require('axios');
// const User=require('../models/user')

exports.sendNotification = async (req, res, next) => {
    try {
      // Set notification data
      const data = {
        to: req.body.deviceId,
        notification: {
          title: req.body.title,
          body: req.body.body
        }
      };
  
      // Send the POST request to FCM API
      const response = await axios.post('https://fcm.googleapis.com/fcm/send', data, {
        headers: {
          Authorization: 'key=AAAAjEJABFo:APA91bGIksE1nog3pWI8zGVKhtNE00l7h61s5uB_I8dR297TGsN1A5rsB7jlIYzB5QTzEoPmuCADo0eoEmDg91VHsGA8lhEOgyUOs0_kEa2E_YxZ6hBhv45wufJd6Epi1yGkl_x-2KZr',
          'Content-Type': 'application/json'
        }
      });
  
      console.log(response.data);
      res.status(200).json({ message: 'Notification sent successfully' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: error });
    }
  };
  
  exports.sendNotificationToAll = async (req, res, next) => {
    try {
      // Get an array of device IDs from all users
      // const users = await User.find();
      // const deviceIds = users.map(user => user.deviceId);
  
      // Temporary array until applying deviceIds to the user schema
      const deviceIds = [
        'e8yRLPDRR_mQYbDrdNriCK:APA91bFBWiFnmmqn5lh7oK15CQSiR9Ux6szdltWiL6pgUShr8PCUyipDzoZXWMG4L3vxOn7w5RHjYvfxOA43NOJTNew4LxCusivu04ZoVByr9adoHxG036LPpWCPNY4tKYfLvIXXEaUG',
        'dYpLP6vpTOOQ2BBv1R5aKX:APA91bEqzL7HNEyPP3kpYlCDscKwXEBFYbahXcUKYMkNMSEjivA7dtNHarHGZdgme-0Ymm8lZm9P10B71KUsmusVBGHVEZE7kf_TFTg4osVWJgCBQSnoubxgbH5aruSRHNHAlL7xZC'
      ];
  
      // Set notification data
      const data = {
        registration_ids: deviceIds,
        notification: {
          title: req.body.title,
          body: req.body.body
        }
      };
  
      // Send the POST request to FCM API
      const response = await axios.post('https://fcm.googleapis.com/fcm/send', data, {
        headers: {
          Authorization: 'key=AAAAjEJABFo:APA91bGIksE1nog3pWI8zGVKhtNE00l7h61s5uB_I8dR297TGsN1A5rsB7jlIYzB5QTzEoPmuCADo0eoEmDg91VHsGA8lhEOgyUOs0_kEa2E_YxZ6hBhv45wufJd6Epi1yGkl_x-2KZr',
          'Content-Type': 'application/json'
        }
      });
  
      console.log(response.data);
      res.status(200).json({ message: 'Notification sent successfully' });
    } catch (error) {
      console.error(error);
      res.status(500).json({ message: error });
    }
  };
  