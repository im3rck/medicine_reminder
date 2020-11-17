import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/HomePage.dart';

class NavigationPage extends StatefulWidget{
  @override
  _NavigationPageState createState() => _NavigationPageState();
}

class _NavigationPageState extends State<NavigationPage>{

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body:  HomePage() );
  }
}

