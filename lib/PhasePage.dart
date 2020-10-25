import 'package:flutter/material.dart';
import 'package:medicine_reminder/NewPatient.dart';
class PhasePage extends StatefulWidget{
  @override
  _PhasePageState createState() => _PhasePageState();
}

class _PhasePageState extends State<PhasePage>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: new FloatingActionButton(

            child: new Icon(Icons.add),
          //onPressed: NewPatient(),
    ),
    );
  }
}