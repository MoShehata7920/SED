const pushNotificationController = require("../controllers/pushNotificationController");
const express = require("express");
const router = express. Router ();
router.post('/send', pushNotificationController.sendNotification);
router.post('/send-all', pushNotificationController.sendNotificationToAll);

module.exports = router;