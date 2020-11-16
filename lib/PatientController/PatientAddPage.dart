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
      backgroundColor: Color(0xff121212),
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
          SizedBox(height: 16.0),
        Stack(
          children: [
            Container(
              height: MediaQuery.of(context).size.height,
              decoration: BoxDecoration(
                color: Color(0xff292929),
              boxShadow: [
            BoxShadow(
              color: Color(0xffbb86fe).withOpacity(0.2),
              spreadRadius: 3,
              blurRadius: 4,
              offset: Offset(0, 3),
              ),
                ],
                borderRadius: BorderRadius.only(topLeft: Radius.circular(20.0), topRight: Radius.circular(20.0)),
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