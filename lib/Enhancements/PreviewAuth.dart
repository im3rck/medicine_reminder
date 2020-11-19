import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/Authentication/Login2.dart';
import 'package:medicine_reminder/Authentication/LoginOption.dart';
import 'package:medicine_reminder/Authentication/SignUp2.dart';
import 'package:medicine_reminder/Authentication/SignUpOption.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';

class AuthPage extends StatefulWidget{
  @override
  _AuthPageState createState() => _AuthPageState();
}
bool login = true;

class _AuthPageState extends State<AuthPage>{
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
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
                    return Scaffold(
                      backgroundColor: Color(0xff121212),
                      body: SingleChildScrollView(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  login = true;
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                                height: login ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height * 0.4,
                                child: CustomPaint(
                                  painter: CurvePainter(login),
                                  child: Container(
                                    padding: EdgeInsets.only(bottom: login ? 0 : 55),
                                    child: Center(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                          child: login
                                              ? Login2()
                                              : LoginOption(),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                setState(() {
                                  login = false;
                                });
                              },
                              child: AnimatedContainer(
                                duration: Duration(milliseconds: 500),
                                curve: Curves.ease,
                                height: login ? MediaQuery.of(context).size.height * 0.4 : MediaQuery.of(context).size.height * 0.6,
                                child: Container(
                                    color: Colors.transparent,
                                    padding: EdgeInsets.only(top: login ? 55 : 0),
                                    child: Center(
                                      child: SingleChildScrollView(
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                                          child: !login
                                              ? SignUp2()
                                              : SignUpOption(),
                                        ),
                                      ),
                                    )
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  }
                  else {
                    return PhasePage();
                  }

                }
                return Scaffold(
                    body: Center(
                        child: Text("Connecting to the app...")
                    )
                );
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
    /*Scaffold(
      backgroundColor: Color(0xff121212),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            GestureDetector(
              onTap: () {
                setState(() {
                  login = true;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login ? MediaQuery.of(context).size.height * 0.6 : MediaQuery.of(context).size.height * 0.4,
                child: CustomPaint(
                  painter: CurvePainter(login),
                  child: Container(
                    padding: EdgeInsets.only(bottom: login ? 0 : 55),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: login
                              ? Login2()
                              : LoginOption(),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            GestureDetector(
              onTap: () {
                setState(() {
                  login = false;
                });
              },
              child: AnimatedContainer(
                duration: Duration(milliseconds: 500),
                curve: Curves.ease,
                height: login ? MediaQuery.of(context).size.height * 0.4 : MediaQuery.of(context).size.height * 0.6,
                child: Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(top: login ? 55 : 0),
                    child: Center(
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: EdgeInsets.symmetric(horizontal: 32, vertical: 16),
                          child: !login
                              ? SignUp2()
                              : SignUpOption(),
                        ),
                      ),
                    )
                ),
              ),
            ),
          ],
        ),
      ),
    );*/
  }
}

class CurvePainter extends CustomPainter {

  bool outterCurve;

  CurvePainter(this.outterCurve);

  @override
  void paint(Canvas canvas, Size size) {
    var paint = Paint();
    paint.color = Color(0xff292929);
    paint.style = PaintingStyle.fill;

    Path path = Path();
    path.moveTo(0, 0);
    path.lineTo(0, size.height);
    path.quadraticBezierTo(size.width * 0.5, outterCurve ? size.height + 110 : size.height - 110, size.width, size.height);
    path.lineTo(size.width, 0);
    path.close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) => false;
}