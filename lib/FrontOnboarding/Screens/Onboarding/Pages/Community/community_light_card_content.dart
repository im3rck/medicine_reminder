import 'package:flutter/material.dart';
import 'package:medicine_reminder/FrontOnboarding/Constants.dart';
import 'package:medicine_reminder/FrontOnboarding/Screens/Onboarding/Widgets/icon_container.dart';


class CommunityLightCardContent extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        IconContainer(
          icon: Icons.person,
          padding: kPaddingS,
        ),
        IconContainer(
          icon: Icons.group,
          padding: kPaddingM,
        ),
        IconContainer(
          icon: Icons.insert_emoticon,
          padding: kPaddingS,
        ),
      ],
    );
  }
}