import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_reminder/SignUp.dart';
import 'package:medicine_reminder/Widgets/variables.dart';
import 'package:flutter/material.dart';

class Login extends StatefulWidget{
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login>{
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

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
              Text("Login", style: myStyle(28,Colors.grey[700],FontWeight.w700),
              ),
              SizedBox(height: 150,),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: emailController,
                    decoration: InputDecoration(
                      fillColor: Colors.white30,
                      filled: true,
                      // labelText: 'Email',
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
                      //labelText: 'Password',
                      prefixIcon: Icon(Icons.lock, color: Colors.blueGrey,),
                      labelStyle: myStyle(16),
                    )
                ),
              ),
              SizedBox(height: 40,),
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
                    width: MediaQuery.of(context).size.width / 4,
                    margin: EdgeInsets.only(left: 200),
                    height: 50,
                    decoration: BoxDecoration(
                      color: Colors.blueGrey,
                      // borderRadius: BorderRadius.circular(30),
                    ),
                    child:  Center(
                      child: Text("Login",style: myStyle(18, Colors.white, FontWeight.w400),),
                    )
                ),
              ),
              SizedBox(height: 16,),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Don't have an account?",style: myStyle(17),),
                  SizedBox(width: 10),
                  InkWell(
                    onTap: ()=>Navigator.push(context, MaterialPageRoute(builder: (context)=>SignUp())),
                    child: Text("Register Now",style: TextStyle(
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