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
  initState()  {
     query();
    super.initState();
  }
  Future query() async {
    Patientdata = [];
    FirebaseFirestore _newDb = FirebaseFirestore.instance;
    await _newDb
        .collection('/users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients')
        .get()
        .then((QuerySnapshot querySnapshot) =>
    {
      querySnapshot.docs.forEach((doc) {
        Map map = {
          'patientToken': doc['patientToken'],
          'name': doc['patientName'],
          'age': doc['age'],
          'gender': doc['gender'],
          'contactNo': doc['contactNo'],
          'rel': doc['relationship'],
          'index': doc['index'],
        };
        Patientdata.add(map);
        print("Yellow");
      })});
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
