import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientController/Cards.dart';
class PatientAddPage extends StatefulWidget{
  @override
  _PatientAddPageState createState() => _PatientAddPageState();
}

class _PatientAddPageState extends State<PatientAddPage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xfff77f00),
      body: ListView(
      children: <Widget>[
        Padding(
            padding: EdgeInsets.only(top: 15.0, left: 10.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.arrow_back_ios),
                color: Colors.white,
                onPressed: (){},
              ),

            ],
          ),
        ),
        SizedBox(height: 20.0),
        Padding(
          padding: EdgeInsets.only(left: 40.0),
          child: Row(
            children: <Widget>[
              Text('New',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontSize: 25.0)),
              SizedBox(width: 10.0),
              Text('Patient',
                  style: TextStyle(
                      fontFamily: 'Montserrat',
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 25.0))
            ],
          ),
        ),
          SizedBox(height: 20.0),
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.only(topLeft: Radius.circular(75.0)),
              ),
            ),
            Cards(),
          ],
        )
      ],
      ),
    );
  }
}