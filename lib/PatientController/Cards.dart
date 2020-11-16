import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientController/customCard.dart';

class Cards extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            customCard(),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[customCard(),customCard(),],
            ),
            Column(
              children: <Widget>[customCard(),customCard(),],
            )
          ],
        )
      ],
    );
  }
}