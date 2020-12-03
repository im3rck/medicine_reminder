import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/CareGiverDetails.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/PatientPrimaryDetails.dart';

class FirestoreServices{

  FirebaseFirestore _db = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;
  String currentUserId;
  PPD newPatient;
  CGD newCaregiver;

  FirestoreServices.patient(PPD patient){
    this.newPatient = patient;
    currentUserId = user.uid;
    createPatientProfile();
  }

  FirestoreServices.careGiver(CGD newCG){
    this.newCaregiver = newCG;
    newCaregiver.setUserID(currentUserId);
    createCaregiverProfile();
  }

  //Create Operations

  //Create CareGiver Profile :


  createCaregiverProfile(){
    var options = SetOptions(merge:true);

    //create a new document
    _db
        .collection('users')
        .doc(newCaregiver.userId)
        .set(newCaregiver.toMap(),options);
  }

  //Create Patient Profile :

   createPatientProfile(){
        var options = SetOptions(merge:true);

        //create a new document

        //print('New Token : ${newPatient.patientToken} , Uid ${currentUserId}');
        _db
        .collection('/users/${currentUserId}/patients')
        .doc(newPatient.patientToken)
        .set(newPatient.toMap(),options);
     //.add(newPatient.toMap());

        //Now that insertion is complete Send a notification to that user handing over our own token
        //Send data notification with our fcm token as payload

  }

  //Update

  //Read

  //Delete

  delete(){
    _db.collection('users')
        .doc('uOzQ4baX4CbRy3vnSKCyCJGi7sw1')
        .update({'email': FieldValue.delete(),'username': FieldValue.delete(),'uid': FieldValue.delete(),'password': FieldValue.delete()});
  }
}