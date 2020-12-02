import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_reminder/PatientController/Cards/Cards.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';

class PatientAddPage extends StatefulWidget {
  @override
  _PatientAddPageState createState() => _PatientAddPageState();
}

class _PatientAddPageState extends State<PatientAddPage> {
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
                  icon: Icon(Icons.arrow_back_ios, color: Color(0xffbb86fe),),
                  color: Color(0xffbb86fe),
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => PhasePage()));
                  },
                ),
                IconButton(
                    icon: FaIcon(FontAwesomeIcons.qrcode, color: Color(0xffbb86fe),),
                    splashColor: Color(0xfff2e7fe),
                    onPressed: null)
              ],
            ),
          ),
          //SizedBox(height: 10.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Text('New',
                  style: TextStyle(
                      color: Color(0xfff2e7fe),
                      fontWeight: FontWeight.bold,
                      fontFamily: 'Circular',
                      fontSize: 25.0) //customize color here
                  ),
              SizedBox(width: 10.0),
              Text('Patient',
                  style: TextStyle(
                      fontFamily: 'Circular',
                      color: Color(0xfff2e7fe),
                      fontWeight: FontWeight.w500,
                      fontSize: 25.0))
            ],
          ),
          SizedBox(height: 30.0),
          Stack(
            children: [
              Container(
                width: double.infinity,
                 height: (MediaQuery.of(context).size.height) * .8,
                decoration: BoxDecoration(
                  color: Color(0xff292929),

                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20.0),
                      topRight: Radius.circular(20.0)),
                ),
              ),
              Container(
                  height: (MediaQuery.of(context).size.height)*.8,
                  child: Cards())
            ],
          )
        ],
      ),
    );
  }
}
