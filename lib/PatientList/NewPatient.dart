import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientList/datafile.dart';
import 'package:medicine_reminder/Widgets/variables.dart';

class NewPatient extends StatefulWidget {
  @override
  _NewPatientState createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController relController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  void _setText() {
    // patientData['index'] = 1;
    // patientData['name'] = fnameController.text as Map;
    // patientData['age'] = ageController.text as Map;
    // patientData['gender'] = genderController.text as Map;
    // patientData['rel'] = relController.text as Map;

    Map map = {
      'index': 1,
      'name': fnameController.text,
      'age': ageController.text,
      'gender': genderController.text,
      'rel': relController.text
    };
    patientData.add(map);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[350],
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 10,
              ),
              Text(
                "Register a New Patient",
                style: myStyle(28, Colors.grey[700], FontWeight.w700),
              ),
              SizedBox(
                height: 150,
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: fnameController,
                  decoration: InputDecoration(
                    fillColor: Colors.white30,
                    filled: true,
                    labelText: 'Full Name',
                    prefixIcon: Icon(
                      Icons.person,
                      color: Colors.blueGrey,
                    ),
                    labelStyle: myStyle(16, Colors.blueGrey),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: genderController,
                  decoration: InputDecoration(
                    fillColor: Colors.white30,
                    filled: true,
                    labelText: 'Gender',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blueGrey,
                    ),
                    labelStyle: myStyle(16, Colors.blueGrey),
                  ),
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                    controller: ageController,
                    decoration: InputDecoration(
                      fillColor: Colors.white30,
                      filled: true,
                      labelText: 'Age',
                      prefixIcon: Icon(
                        Icons.person,
                        color: Colors.blueGrey,
                      ),
                      labelStyle: myStyle(16, Colors.blueGrey),
                    )),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: relController,
                  decoration: InputDecoration(
                    fillColor: Colors.white30,
                    filled: true,
                    labelText: 'Relationship',
                    prefixIcon: Icon(
                      Icons.email,
                      color: Colors.blueGrey,
                    ),
                    labelStyle: myStyle(16, Colors.blueGrey),
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              // MaterialButton(onPressed: () {
              //   _setText();
              // })
              MaterialButton(
                  child: Text('New button'),
                  onPressed: () {
                    _setText();
                    Navigator.pop(context);
                  }
              )
            ],
          ),
        ));
  }
}
