import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientController/Cards/addedList.dart';
import 'package:medicine_reminder/PatientController/Cards/details.dart';
import 'package:medicine_reminder/PatientController/Cards/Medicine/medicine.dart';
import 'package:medicine_reminder/PatientController/Connection/Connection.dart';

class Cards extends StatefulWidget {
  Cards(this.token);
  final String token;
  @override
  _CardsState createState() => _CardsState();
}

Future navigateToSubPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Connection()));
}

class _CardsState extends State<Cards> {
  final double appBarHeight = 50.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Details(widget.token),
            Medicines(),
            AddedList(),
          ],
        ),
      ],
    );
  }
}
