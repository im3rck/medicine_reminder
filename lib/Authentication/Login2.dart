import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class Login2 extends StatefulWidget {
  @override
  _Login2State createState() => _Login2State();
}

class _Login2State extends State<Login2> {
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          SizedBox(height: 80,),
          Text(
            "Welcome to",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C1C1C),
              height: 2,
            ),
          ),
          Text(
            "MedReminder",
            style: TextStyle(
              fontSize: 36,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C1C1C),
              letterSpacing: 2,
              height: 1,
            ),
          ),

          SizedBox(
            height: 46,
          ),

          TextField(
            controller: emailController,
            decoration: InputDecoration(
              hintText: 'Email',
              prefixIcon: Icon(Icons.email, color: Color(0xFF1C1C1C).withOpacity(0.8),),
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color(0xFF1C1C1C).withOpacity(0.6),
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Color(0xffECECEA),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),
          SizedBox(
            height: 20,
          ),

          TextField(
            controller: passwordController,
            decoration: InputDecoration(
              hintText: 'Password',
              prefixIcon: Icon(Icons.lock, color: Color(0xFF1C1C1C).withOpacity(0.8),),
              hintStyle: TextStyle(
                fontSize: 16,
                color: Color(0xFF1C1C1C).withOpacity(0.6),
                fontWeight: FontWeight.bold,
              ),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(25),
                borderSide: BorderSide(
                  width: 0,
                  style: BorderStyle.none,
                ),
              ),
              filled: true,
              fillColor: Color(0xffECECEA),
              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
            ),
          ),

          SizedBox(
            height: 26,
          ),

          InkWell(
            onTap: () {
              try {
                FirebaseAuth.instance.signInWithEmailAndPassword(
                    email: emailController.text,
                    password: passwordController.text);
              } catch (e) {
                SnackBar snackBar = SnackBar(content: Text("Invalid Credentials"));
                Scaffold.of(context).showSnackBar(snackBar);
              }
            },
            child: Container(
              height: 40,
              decoration: BoxDecoration(
                color: Color(0xFF1C1C1C),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff515151).withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child:  Center(
                child: Text(
                  "Log In",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFF3D657),
                  ),
                ),
              ),
            ),
          ),

          SizedBox(
            height: 16,
          ),

          Text(
            "Forgot Password?",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
              color: Color(0xFF1C1C1C),
              height: 1,
            ),
          ),
        ],
    );
        }
}