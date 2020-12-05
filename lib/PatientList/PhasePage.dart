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
  //List<Map> patientData = [];
  initState()  {
     query();
    super.initState();
  }
  query() async {
    testData=[];
    FirebaseFirestore _newDb = FirebaseFirestore.instance;
    await _newDb
        .collection('/users/uOzQ4baX4CbRy3vnSKCyCJGi7sw1/patients')
        .get()
        .then((QuerySnapshot querySnapshot) =>
    {
      querySnapshot.docs.forEach((doc) {
        Map a = {
          'patientToken': doc['patientToken'],
          'name': doc['patientName'],
          'age': doc['age'],
          'gender': doc['gender'],
          'contactNo': doc['contactNo'],
          'rel': doc['relationship'],
          'index': doc['index']
        };
        testData.add(a);
      })});
    print("THIS IS NOT A TEST: ${testData}");
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [DrawerScreen(),
         HomeScreen()
        ],
      ),
    );
  }
}
