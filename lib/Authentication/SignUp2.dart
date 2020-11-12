import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:medicine_reminder/Widgets/variables.dart';

class SignUp2 extends StatelessWidget {

  @override
  Widget build(BuildContext context) {

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    TextEditingController userNameController = TextEditingController();

    registerUser(){
      FirebaseAuth.instance
          .createUserWithEmailAndPassword(
          email: emailController.text, password: passwordController.text)
          .then((signeduser) {
        userCollection.doc(signeduser.user.uid).set({
          'username': userNameController.text,
          'password': passwordController.text,
          'email': emailController.text,
          'uid': signeduser.user.uid,
        });
      });
      Navigator.pop(context);
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Text(
          "Sign up with",
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
          height: 16,
        ),
        TextFormField(
            validator: (val){
              return val.isEmpty || val.length < 4 ? "Invalid Username":null;
            },
            controller: userNameController,
          decoration: InputDecoration(
            prefixIcon: Icon(Icons.person, color: Color(0xFF1C1C1C).withOpacity(0.7),),
            hintText: 'Username',
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
          height: 16,
        ),

        TextFormField(
          validator: (val){
            return RegExp(
                r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
                .hasMatch(val) ? null : "Invalid Email";
          },
          controller: emailController,
          decoration: InputDecoration(
            hintText: 'Email',
            prefixIcon: Icon(Icons.email, color: Color(0xFF1C1C1C).withOpacity(0.7),),
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
          height: 16,
        ),

        TextFormField(
          obscureText: true,
          validator: (val){
            return val.length < 6 ? "Enter a stronger Password" : null;
          },
          controller: passwordController,
          decoration: InputDecoration(
            hintText: 'Password',
            prefixIcon: Icon(Icons.lock, color: Color(0xFF1C1C1C).withOpacity(0.7),),
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
          height: 24,
        ),

          InkWell(
            onTap: ()=>registerUser(),
            child: Container(
            height: 40,
            decoration: BoxDecoration(
              color: Color(0xFF1C1C1C),
              borderRadius: BorderRadius.all(
                Radius.circular(25),
              ),
              boxShadow: [
                BoxShadow(
                  color: Color(0xffBE95C4).withOpacity(0.2),
                  spreadRadius: 3,
                  blurRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
            ),
              child:  Center(
                child: Text(
                "Sign Up",
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
          height: 24,
        ),
      ],
    );
  }
}