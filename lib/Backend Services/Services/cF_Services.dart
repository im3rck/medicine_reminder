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
  FirestoreServices.test();

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
  createTimedSchedule(newScheduleModel schedule){
    _db.collection('users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/alalalalldldlaslalsalsllsllaslsd/TimedSchedules')
        .doc(schedule.scheduleId)
        .set(schedule.toMap(),SetOptions(merge: true));
  }
  createRepeatedSchedule(RepeatedScheduleModel schedule){
    _db.collection('users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/alalalalldldlaslalsalsllsllaslsd/RepeatedSchedules')
        .doc(schedule.scheduleId)
        .set(schedule.toMap(),SetOptions(merge: true));
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
  deletePatient(String value){
    _db .collection('/users/${user.uid}/patients')
        .doc(value)
        .delete();
  }
  delete(){
    _db.collection('users')
        .doc('uOzQ4baX4CbRy3vnSKCyCJGi7sw1')
        .update({'email': FieldValue.delete(),'username': FieldValue.delete(),'uid': FieldValue.delete(),'password': FieldValue.delete()});
  }

  mockDelete(String value) {
     _db .collection('/users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/alalalalldldlaslalsalsllsllaslsd/RepeatedSchedules')
        .where('medName', isEqualTo: value)
        .snapshots().forEach((element) {
            element.docs.forEach((target) {
              var data = target.data();
              _db .collection('/users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/alalalalldldlaslalsalsllsllaslsd/RepeatedSchedules')
                  .doc(data['scheduleId'])
                  .delete();
          });
    });
     _db .collection('/users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/alalalalldldlaslalsalsllsllaslsd/TimedSchedules')
         .where('medName', isEqualTo: value)
         .snapshots().forEach((element) {
       element.docs.forEach((target) {
         var data = target.data();
         _db .collection('/users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/alalalalldldlaslalsalsllsllaslsd/TimedSchedules')
             .doc(data['scheduleId'])
             .delete();
       });
     });

  }
  mockDeleteSchedule(String value) {
    _db .collection('/users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/alalalalldldlaslalsalsllsllaslsd/TimedSchedules')
        .doc(value)
        .delete();

  }



  Stream<List<newScheduleModel>> getTimedSchedules(String patientToken){
    return _db
        .collection('/users/${currentUserId}/patients/${patientToken}/TimedSchedules')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => newScheduleModel.fromJson(doc.data()))
        .toList());
  }
  Stream<List<newScheduleModel>> getMockSchedules(String value){

    return _db
        .collection('/users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/${value}/TimedSchedules')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => newScheduleModel.fromJson(doc.data()))
        .toList());
  }
  Stream<List<RepeatedScheduleModel>> getMockRepeatedSchedules(String value){
    return _db
        .collection('/users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/${value}/RepeatedSchedules')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => RepeatedScheduleModel.fromJson(doc.data()))
        .toList());
  }
  Stream<List<newScheduleModel>> getMockDailySchedules(String value){

    return _db
        .collection('/users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/${value}/TimedSchedules')

        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => newScheduleModel.fromJson(doc.data()))
        .toList());
  }
  Stream<List<RepeatedScheduleModel>> getMockDailyRepeatedSchedules(String value){
    return _db
        .collection('/users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/${value}/RepeatedSchedules')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => RepeatedScheduleModel.fromJson(doc.data()))
        .toList());
  }

  Stream<List<newScheduleModel>> getRepeatedSchedules(String patientToken){
    return _db
        .collection('/users/${currentUserId}/patients/${patientToken}/RepeatedSchedules')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => newScheduleModel.fromJson(doc.data()))
        .toList());
  }

  Stream<List<MedicineDB>> getMedicineFromDataBase(){
    return _db
        .collection('/Medicines')
        .snapshots()
        .map((snapshot) => snapshot.docs
        .map((doc) => MedicineDB.fromJson(doc.data()))
        .toList());
  }

}

