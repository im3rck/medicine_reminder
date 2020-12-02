import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_reminder/FrontOnboarding/Constants.dart';
import 'package:medicine_reminder/FrontOnboarding/Screens/Onboarding/Widgets/icon_container.dart';

class WorkLightCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconContainer(
          icon: Icons.alarm_add ,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: FontAwesomeIcons.bookMedical,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: FontAwesomeIcons.mobileAlt,
          padding: kPaddingS,
        ),
      ],
    );
  }
}