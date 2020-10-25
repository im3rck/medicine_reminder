import 'package:flutter/material.dart';
import 'package:medicine_reminder/Widgets/variables.dart';

class NewPatient extends StatefulWidget{
  @override
  _NewPatientState createState() => _NewPatientState();
}

class _NewPatientState extends State<NewPatient>{

  TextEditingController fnameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController pinController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.grey[350],
        body:  Container(
          alignment: Alignment.center,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(height: 10,),
              Text("Register a New Patient", style: myStyle(28,Colors.grey[700],FontWeight.w700),
              ),
              SizedBox(height: 150,),
            Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: fnameController,
                    decoration: InputDecoration(
                      fillColor: Colors.white30,
                      filled: true,
                      labelText: 'Full Name',
                      prefixIcon: Icon(Icons.person, color: Colors.blueGrey,),
                      labelStyle: myStyle(16,Colors.blueGrey),
                    ),
                ),
                ),
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
                   ),
              ),
            ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: pinController,
                    decoration: InputDecoration(
                      fillColor: Colors.white30,
                      filled: true,
                      labelText: 'Secure Pin',
                      prefixIcon: Icon(Icons.person, color: Colors.blueGrey,),
                      labelStyle: myStyle(16,Colors.blueGrey),
                    )
                ),
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                margin: EdgeInsets.symmetric(horizontal: 30),
                child: TextField(
                  controller: ageController,
                    decoration: InputDecoration(
                      fillColor: Colors.white30,
                      filled: true,
                      labelText: 'Age',
                      prefixIcon: Icon(Icons.person, color: Colors.blueGrey,),
                      labelStyle: myStyle(16,Colors.blueGrey),
                    )
                  ),

              ),

            ],

          ),
        ) );
  }
}
