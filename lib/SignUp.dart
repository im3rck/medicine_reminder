import 'package:medicine_reminder/Login.dart';
import 'package:medicine_reminder/Widgets/variables.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class SignUp extends StatefulWidget{
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp>{
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[350],
        body: Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Text("Register", style: myStyle(28,Colors.grey[700],FontWeight.w700),
              ),
              SizedBox(height: 150,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                    controller: userNameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white30,
                      filled: true,
                      labelText: 'Username',
                      prefixIcon: Icon(Icons.person, color: Colors.blueGrey,),
                      labelStyle: myStyle(16,Colors.blueGrey),
                    )
                ),
              ),
              SizedBox(height: 8,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                    controller: emailController,
                    decoration: InputDecoration(
                      fillColor: Colors.white30,
                      filled: true,
                      labelText: 'Email',
                      prefixIcon: Icon(Icons.email, color: Colors.blueGrey,),
                      labelStyle: myStyle(16,Colors.blueGrey),
                    )
                ),
              ),
              SizedBox(height: 8,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                    controller: passwordController,
                    decoration: InputDecoration(
                      fillColor: Colors.white30,
                      filled: true,
                      labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.blueGrey,),
                      labelStyle: myStyle(16,Colors.blueGrey),
                    )
                ),
              ),
              SizedBox(height: 16,),

              SizedBox(height: 40,),
              InkWell(
                onTap: ()=>registerUser(),
                child: Container(
                    width: MediaQuery.of(context).size.width / 4,
                    margin: EdgeInsets.only(left: 200),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      // borderRadius: BorderRadius.circular(30),
                    ),
                    child:  Center(
                      child: Text("Sign Up",style: myStyle(18, Colors.white, FontWeight.w400),),
                    )
                ),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Already have an account?",style: myStyle(17),),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>Login())),
                    child: Text("Login",style: TextStyle(
                      color: Colors.blueGrey,
                      fontSize: 17,
                      decoration: TextDecoration.underline,
                    ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        )

    );

  }
}