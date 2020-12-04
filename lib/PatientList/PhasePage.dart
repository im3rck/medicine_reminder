import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientList/HomeScreen.dart';
import 'package:medicine_reminder/PatientList/DrawerScreen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:medicine_reminder/PatientList/datafile.dart';

class PhasePage extends StatefulWidget {
  @override
  _PhasePageState createState() => _PhasePageState();
}

class _PhasePageState extends State<PhasePage> {
  initState() {
    query();
  }
  query() {
    FirebaseFirestore _newDb = FirebaseFirestore.instance;
    _newDb
        .collection('/users/uOzQ4baX4CbRy3vnSKCyCJGi7sw1/patients')
        .get()
        .then((QuerySnapshot querySnapshot) =>
    {
      querySnapshot.docs.forEach((doc) {
        Map a = {
          'patientToken': doc['patientToken'],
          'patientName': doc['patientName'],
          'age': doc['age'],
          'gender': doc['gender'],
          'contactNo': doc['contactNo'],
          'relationship': doc['relationship'],
          'index': doc['index']
        };
        //print(a);
        patientData.add(a);
        print("Test: ${patientData}");
      })});
    //return patientData;
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(), HomeScreen()],
      ),
    );
  }
}
