import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_reminder/FrontOnboarding/Constants.dart';



class CommunityDarkCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.only(top: kPaddingL),
          child: Icon(
            FontAwesomeIcons.clock,
            color: kWhite,
            size: 32.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(bottom: kPaddingL),
          child: Icon(
            FontAwesomeIcons.prescriptionBottle, color: Color(0xffbb86fe),
            size: 36.0,
          ),
        ),
        Padding(
          padding: const EdgeInsets.only(top: kPaddingL),
          child: Icon(
            FontAwesomeIcons.calendarCheck,
            color: kWhite,
            size: 32.0,
          ),
        ),
      ],
    );
  }
}