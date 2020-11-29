import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';

// import 'package:medicine_reminder/PatientScreen/Onboarding.dart';
import 'package:medicine_reminder/Timer/SelectDay/SelectDay.dart';

// import 'package:medicine_reminder/LaunchScreen/gooey_edge/lib/demo.dart';
// import 'package:medicine_reminder/2NewPatient.dart';
// import 'package:medicine_reminder/timer/SelectTime.dart';
// import 'package:medicine_reminder/enhancements/FirstPage.dart';
import 'package:medicine_reminder/navigation.dart';
import 'package:medicine_reminder/Enhancements/PreviewAuth.dart';
//import 'package:firebase_messaging/firebase_messaging.dart';

// import 'LaunchScreen/Launch.dart';


//Todo : Permissions


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  Paint.enableDithering = true;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  MyApp();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Digital Medical Assistant',
        home: PhasePage());
  }
}

