const admin = require('firebase-admin');
const functions = require('firebase-functions');
admin.initializeApp();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//
 exports.TrialRun = functions.https.onRequest((request, response) => {
   functions.logger.info("Trial Log", {structuredData: true});
   response.send("Hello");
 });

exports.sendNotifications = functions.firestore.document('users/{docID}/patients/{PatientID}').onCreate(
  async (snapshot) => {
   // var k ='a';
//    if(snapshot===null){
//    k="No data";
//    }
//    else{
   // k= String(snapshot.data().patientName);
//    }
    // console.log(String(snapshot.data().patientName))
    const payload = {
      notification: {
        title: "Hello " +(String(snapshot.data().patientName)),
        body:  'Welcome to MedReminder, Click to continue'
	},
      data:{
	click_action: 'FLUTTER_NOTIFICATION_CLICK',
	//careGiverId: CareGiverId
	}
    };
    //const tokens = ['cyjQztQqSDuv2K_wFO6at2:APA91bGOiMN84_c2ukYDcF-NYbwUSRUX0Ya6vHmHAtx2j9UAr0dxYSjyITodHvKP_px6sCARZvTE_VgYnFL2zhP72fBWw30k-95_SXsqtiFKUtI0KpCFW2QVRyUYnyCNOvbzf5yAy8vF'];
       //tokens=['cYdUQVWJRPCuLt8KTY9s-h:APA91bHJ1KAra3cKthq5w-CGjEpCWgZY-l3QEehYUbdKEvUWgRgJ-TDgyqOFgHF81VNqdcxZGluheeLm7QjA0Eoaxb-2I7jl0HW5lbU7toFbPBBkYWhdgIdN2mclxRdr2k0mDUgfuQo-']
	  tokens =[]
	  tokens.push(String(snapshot.data().patientToken));

//
//    if (tokens.length > 0) {
//      // Send notifications to all tokens.
      const response = await admin.messaging().sendToDevice(tokens, payload);
//      await cleanupTokens(response, tokens);
//      console.log('Notifications have been sent and tokens cleaned up.');

//    }
  });