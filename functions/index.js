// The Cloud Functions for Firebase SDK to create
// Cloud Functions and set up triggers.
const functions = require("firebase-functions");

// The Firebase Admin SDK to access Firestore.
const admin = require("firebase-admin");
admin.initializeApp();

exports.sendNewFollowerNotification = functions.firestore.document("/user-followers/{documentId}")
  .onCreate((snap, context) => {
    const newObject = snap.data();

    functions.logger.log("Sending new follower notification", context.params.documentId, newObject);

    const followedUserId = newObject.userId;

    return admin.firestore().collection("users").doc(followedUserId).get().then(doc => {

      const user = doc.data();
      const fcmToken = user.fcmToken;

      const payload = {
        notification: {
          title: "New Follower!",
          body: "Someone new has followed you! Find out who.",
        }
      };

      admin.messaging().sendToDevice(fcmToken, payload);

    });
  });

exports.testSendPushNotifications = functions.https.onRequest((req, res) => {
  // Daniel's iPhone Device FCM token for testing - changes regularly (expiry)
  const fcmToken = "cHqrt-peckKXl8JsiQ4uYv:APA91bHZsfz43iEtxDsggQnH55QedKKYk0-cIkyKc8_I173VZCJjEyvgMzUDx_sDoegEtrYwyVbk-uIM7ddz_INtWUqYXz3e-B0bUZQvATVwIssL8ZJxWmJiMBsnHCLB3mGlOVJpMMD1";

  res.send(fcmToken);

  const payload = {
    notification: {
      title: "Push Notifcation Title goes here",
      body: "Body goes here",
    }
  };

  admin.messaging().sendToDevice(fcmToken, payload);
});
