import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientController/Cards/addedList.dart';
import 'package:medicine_reminder/PatientController/Cards/details.dart';
import 'package:medicine_reminder/PatientController/Cards/medicine.dart';
import 'package:medicine_reminder/PatientController/Connection/Connection.dart';

class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

Future navigateToSubPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Connection()));
}

class _CardsState extends State<Cards> {
  final double appBarHeight = 55.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 14.0),
            Details(),
            Medicines(),
            AddedList(),
            SizedBox(
              height: 10,
            ),
            Container(
              height: 50,
              width: (MediaQuery.of(context).size.width) * .8,
              decoration: BoxDecoration(
                color: Color(0xff121212),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                border: Border.all(color: Color(0xffBB86FC), width: 1),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xffF292929).withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Confirm",
                  style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 16,
                    color: Color(0xffF2E7FE),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }
}
