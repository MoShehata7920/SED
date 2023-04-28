const pushNotificationController = require("../controllers/pushNotificationController");
const express = require("express");
const router = express. Router ();
router.post('/send', pushNotificationController.sendNotification);
module.exports = router;