import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/Enhancements/PreviewAuth.dart';
import 'package:medicine_reminder/LaunchScreen/demo.dart';
// import 'package:medicine_reminder/Authentication/Login.dart';
// import 'package:medicine_reminder/HomePage.dart';
import 'package:medicine_reminder/PatientController/PatientAddPage.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';
import 'package:medicine_reminder/PatientController/PatientDetails/PatientDetails.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';
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
  String token = await Token();
  print('New token : ');
  print(token);
  runApp(MyApp(token));
}

class MyApp extends StatelessWidget {
  MyApp(String token);
  String token;
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Digital Medical Assistant',

       home: GooeyEdgeDemo(token)//PhasePage()//PatientAddPage(),//App(),//HomePage(),

    );
  }
}

Future<String> Token (){
  Future<String> fcmToken = FirebaseMessaging().getToken();
  return(fcmToken);
}
