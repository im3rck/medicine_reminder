import 'package:flutter/material.dart';
import 'package:medicine_reminder/NewPatient.dart';
import 'package:medicine_reminder/PatientController/PatientDetails/PatientDetails.dart';
import 'package:medicine_reminder/PatientController/customCard.dart';


class Cards extends StatelessWidget{
  final double appBarHeight = 50.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
                InkWell(
                onTap:() {
                 // FoldingCellSimpleDemo();
                },
                child: Container(
                    height: 175.0,
                    width: MediaQuery.of(context).size.width,
                    child: customCard(Icons.person,"Details","Patient Bio")
                ),
              ),

          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                InkWell(
                  child: Container(
                      height: ((MediaQuery.of(context).size.height)-appBarHeight-175.0)*.35,
                      width: (MediaQuery.of(context).size.width)*.5,
                      child: customCard(Icons.description,"Pills","Dosage Details")
                  ),
                ),

                InkWell(
                onTap:() {
                    ScheduleCell();
                  },
                  child: Container
                    (
                      height: ((MediaQuery.of(context).size.height)-appBarHeight-175.0)*.45,
                      width: (MediaQuery.of(context).size.width)*.5,
                      child: customCard(Icons.calendar_today,"Schedule","Days and Range",)),
                )],
            ),
            Column(
              children: <Widget>[

                Container(
                    height: ((MediaQuery.of(context).size.height)-appBarHeight-175.0)*.45,
                    width: (MediaQuery.of(context).size.width)*.5,
                    child: customCard(Icons.alarm_add,"Time","Intervals and Timings")),

                Container(
                    height: ((MediaQuery.of(context).size.height)-appBarHeight-175.0)*.35,
                    width: (MediaQuery.of(context).size.width)*.5,
                    child: customCard(Icons.assignment,"Log","Records")),],
            )
          ],
        )
      ],
    );
  }
}