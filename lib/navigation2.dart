import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_reminder/Authentication/Login.dart';
import 'package:medicine_reminder/PhasePage.dart';
import 'package:flutter/material.dart';

class Navigation2Page extends StatefulWidget{
  @override
  _Navigation2PageState createState() => _Navigation2PageState();
}

class _Navigation2PageState extends State<Navigation2Page>{
  bool isSigned = false;
  @override
  initState() {
    super.initState();
    FirebaseAuth.instance.authStateChanges().listen((user) {
      if(user != null){
        setState(() {
          isSigned = true;
        });
      } else {
        setState(() {
          isSigned = false;
        });
      }
    });
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  isSigned == false ? Login() : PhasePage() );
  }
}

