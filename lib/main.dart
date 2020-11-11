import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/Authentication/Login.dart';
import 'package:medicine_reminder/Enhancements/PreviewAuth.dart';

// import 'package:medicine_reminder/2NewPatient.dart';
// import 'package:medicine_reminder/timer/SelectTime.dart';
// import 'package:medicine_reminder/enhancements/FirstPage.dart';
// import 'package:medicine_reminder/navigation.dart';
import 'package:medicine_reminder/Timer/SelectDay/SelectDay.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Medical Assistant',
      // home: AuthPage(),
      home: SelectDay(),
    );
  }
}
