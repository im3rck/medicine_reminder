import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/Authentication/Login2.dart';
import 'package:medicine_reminder/Authentication/LoginOption.dart';
import 'package:medicine_reminder/Authentication/SignUp2.dart';
import 'package:medicine_reminder/Authentication/SignUpOption.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';
import 'package:medicine_reminder/Authentication/Login/login.dart';

class AuthPage extends StatefulWidget{
  @override
  _AuthPageState createState() => _AuthPageState();
}
bool login = true;

class _AuthPageState extends State<AuthPage>{
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return FutureBuilder(
      future: _initialization,
      builder: (context,snapshot){
        if(snapshot.hasError){
          return Scaffold(
            body: Center(
              child: Text("Error: ${snapshot.error}")
            )
          );
        }
        if(snapshot.connectionState == ConnectionState.done){
          return StreamBuilder<Object>(
              stream: FirebaseAuth.instance.authStateChanges(),
            builder: (context, snapshot) {
                if(snapshot.connectionState == ConnectionState.active){
                  User user = snapshot.data;
                  if(user == null){
                    print("Big Happy");
                    return Login(

                        screenHeight: height
                    );
                  }
                  else {
                    print("Big sed");
                    return PhasePage();
                  }

                }
                return AnimatedContainer(duration: Duration(seconds: 3));
                //return Text("");//"Randombs";// Scaffold(
                    //body: Center(
                      //  child: Text("Connecting to the app...")
                    //)
                //);
                //return Container();
            }
          );
        }
        return Scaffold(
          body: Center(
            child: Text("Connecting to the app...")
          )
        );
      }

    );
  }
}

