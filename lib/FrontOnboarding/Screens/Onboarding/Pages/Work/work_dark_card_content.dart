import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_reminder/FrontOnboarding/Constants.dart';



class WorkDarkCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.person_pin,
              color: kWhite,
              size: 32.0,
            ),
          ],
        ),
        const SizedBox(height: kSpaceM),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: <Widget>[
            Icon(
              Icons.person,
              color: kWhite,
              size: 34.0,
            ),
            Icon(
              FontAwesomeIcons.handHoldingMedical ,
              color: kWhite,
              size: 36.0,
            ),
            Icon(
              Icons.group,
              color: kWhite,
              size: 34.0,
            ),
          ],
        ),
      ],
    );
  }
}