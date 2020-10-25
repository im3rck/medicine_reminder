import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/navigation.dart';

class FirstPage extends StatefulWidget{
  @override
  _FirstPageState createState() => _FirstPageState();
}

class _FirstPageState extends State<FirstPage>{
  @override
  void initState() {
    // TODO: implement initState
    Timer(Duration(seconds: 3), openOnBoard);
    super.initState();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body:  Center(
          child: Container(

            decoration: BoxDecoration(
              image: DecorationImage(
              image: AssetImage("assets/images/easy_pill.png"),
            ),
            ),
          ),
        ) );
  }
  void openOnBoard()
  {
    Navigator.push(context, MaterialPageRoute(builder: (context)=>NavigationPage()));
  }
}

