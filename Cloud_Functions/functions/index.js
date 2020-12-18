const functions = require('firebase-functions');

// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
 exports.TestRun = functions.https.onRequest((request, response) => {
   functions.logger.info("Trial Log", {structuredData: true});
   response.send("Sup?");
 });
