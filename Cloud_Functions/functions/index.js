const admin = require('firebase-admin');
const functions = require('firebase-functions');
admin.initializeApp();

 exports.TrialRun = functions.https.onRequest((request, response) => {
   functions.logger.info("Trial Log", {structuredData: true});
   response.send("Hello");
 });

exports.sendNotifications = functions.firestore.document('users/{docID}/patients/{PatientID}').onCreate(
  async (snapshot) => {

    console.log('Hello')
    const payload = {
      notification: {
        title: "Hello " +(String(snapshot.data().patientName)),
        body:  'Welcome to MedReminder, Click to continue'
	},
      data:{
	click_action: 'FLUTTER_NOTIFICATION_CLICK',
	UID: String(snapshot.data().UID),
	caregiverToken: String(snapshot.data().caregiverToken)
	}
    };
	  tokens = []
	  tokens.push(String(snapshot.data().patientToken));

             const response = await admin.messaging().sendToDevice(tokens, payload);

  });

  exports.sendAlerts = functions.firestore.document('users/{docID}/patients/{PatientID}/logs/{logID}').onCreate(
    async (snapshot) => {
      console.log('Alert Log')
      const payload = {
        notification: {
          title: "Hello " +(String(snapshot.data().patientName)),
          body:  'Welcome to MedReminder, Click to continue'
  	},
        data:{
  	click_action: 'FLUTTER_NOTIFICATION_CLICK',
  	UID: String(snapshot.data().UID),
  	caregiverToken: String(snapshot.data().caregiverToken)
  	}
      };
  	  tokens = []
  	  tokens.push(String(snapshot.data().patientToken));

               const response = await admin.messaging().sendToDevice(tokens, payload);

    });