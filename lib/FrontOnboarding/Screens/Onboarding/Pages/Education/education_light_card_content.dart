import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_reminder/FrontOnboarding/Constants.dart';
import 'package:medicine_reminder/FrontOnboarding/Screens/Onboarding/Widgets/icon_container.dart';


class EducationLightCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconContainer(
          icon: FontAwesomeIcons.notesMedical,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: FontAwesomeIcons.clock,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: FontAwesomeIcons.prescriptionBottleAlt,
          padding: kPaddingM,
        ),
      ],
    );
  }
}