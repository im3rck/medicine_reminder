import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';
import 'GoogleAuth.dart';

class GoogleLogin extends StatefulWidget {
  @override
  _GoogleLoginState createState() => _GoogleLoginState();
}

class _GoogleLoginState extends State<GoogleLogin> {
  User user;

  void signIn() {
    signInWithGoogle().then((user) => {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => SuccessPage()))
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            signIn();
          },
          child: Container(
              width: MediaQuery.of(context).size.width / 4,
              margin: EdgeInsets.only(left: 200),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                // borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "GLogin",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              )),
        ),
      ),
    );
  }
}

class SuccessPage extends StatelessWidget {
  // final User user;
  // SuccessPage(this.user);

  void signOut() {
    signOutGoogle();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: InkWell(
          onTap: () {
            signOut();
          },
          child: Container(
              width: MediaQuery.of(context).size.width / 4,
              margin: EdgeInsets.only(left: 200),
              height: 50,
              decoration: BoxDecoration(
                color: Colors.blueGrey,
                // borderRadius: BorderRadius.circular(30),
              ),
              child: Center(
                child: Text(
                  "GLogout",
                  style: TextStyle(
                      fontSize: 18,
                      color: Colors.white,
                      fontWeight: FontWeight.w400),
                ),
              )),
        ),
      ),
    );
  }
}

