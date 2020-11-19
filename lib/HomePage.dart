import 'package:flutter/material.dart';

import 'package:medicine_reminder/Authentication/Login.dart';
import 'package:medicine_reminder/Enhancements/PreviewAuth.dart';
import 'package:medicine_reminder/Widgets/variables.dart';
import 'package:medicine_reminder/navigation2.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.grey[350],
      body: Container(
        alignment: Alignment.center,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            RaisedButton(
              textColor: Colors.white,
              color: Colors.cyan,
              child: Text(
                'Caregiver',
                style: myStyle(18),
              ),
              onPressed: () {
                navigateToSignIn(context);
              },
            ),
            RaisedButton(
              textColor: Colors.white,
              color: Colors.blueGrey,
              child: Text(
                'Patient',
                style: myStyle(18),
              ),
              onPressed: () {
                navigateToSignUp(context);
              },
            )
          ],
        ),
      ),
    );
  }
}

Future navigateToSignIn(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => AuthPage()));
}

Future navigateToSignUp(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Login()));
}
