import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/CareGiverDetails.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/PatientPrimaryDetails.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/ScheduleModel.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/MedicineDescription.dart';
import 'package:firebase_storage/firebase_storage.dart';

class FirestoreServices{
  SM newSchedule;
  FirebaseFirestore _db = FirebaseFirestore.instance;
  User user = FirebaseAuth.instance.currentUser;
  String currentUserId;
  PPD newPatient;
  CGD newCaregiver;
  String ImgUrl;

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

  FirestoreServices.dateSchedule(SM schedule){
   int quantity = 0;
   _db
       .collection('users/${currentUserId}/Medicines')
       .doc('${MedicineDescription.getId(schedule.medName)}')
       .get()
       .then((DocumentSnapshot documentSnapshot) {
     if (documentSnapshot.exists) {
          quantity=0;
     } else {
         var temp = documentSnapshot.data();
         quantity = temp['remainingQuantity'];
     }
   });
    FetchImage('MedicineImages/${MedicineDescription.getId(schedule.medName)}');
    newSchedule= SM (schedule.medName,schedule.imageUrl,quantity,schedule.time,schedule.dosage,schedule.date);
  }
  // FirestoreServices.getSchedule(){
  //   int quantity = 0;
  //   _db
  //       .collection('users/${currentUserId}/Medicines')
  //       .doc('${MedicineDescription.getId(schedule.medName)}')
  //       .get()
  //       .then((DocumentSnapshot documentSnapshot) {
  //     if (documentSnapshot.exists) {
  //       quantity=0;
  //     } else {
  //       var temp = documentSnapshot.data();
  //       quantity = temp['remainingQuantity'];
  //     }
  //   });
  //   FetchImage('MedicineImages/${MedicineDescription.getId(schedule.medName)}');
  //   newSchedule= SM (schedule.medName,schedule.imageUrl,quantity,schedule.time,schedule.dosage,schedule.date);
  // }

  FetchImage(String ImagePath)  async{
    var storage = FirebaseStorage.instanceFor(bucket: 'gs://medicine-reminder-406a5.appspot.com/');
    ImgUrl = await storage.ref(ImagePath).getDownloadURL();

  }
  FirestoreServices.daySchedule(SM schedule){
    int quantity = 0;
    _db
        .collection('users/${currentUserId}/Medicines')
        .doc('${MedicineDescription.getId(schedule.medName)}')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      if (documentSnapshot.exists) {
        quantity=0;
      } else {
        var temp = documentSnapshot.data();
        quantity = temp['remainingQuantity'];
      }
    });
    FetchImage('MedicineImages/${MedicineDescription.getId(schedule.medName)}');

  }
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
  Stream<List<PPD>> getPatientList(){
    return _db
        .collection('entries')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => PPD.fromJson(doc.data()))
        .toList());
  }
  //Delete

  delete(){
    _db.collection('users')
        .doc('uOzQ4baX4CbRy3vnSKCyCJGi7sw1')
        .update({'email': FieldValue.delete(),'username': FieldValue.delete(),'uid': FieldValue.delete(),'password': FieldValue.delete()});
  }
}