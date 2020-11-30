import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/FrontOnboarding/Constants.dart';
import 'package:medicine_reminder/FrontOnboarding/Widgets/Logo.dart';




class Header extends StatelessWidget {
  final VoidCallback onSkip;

  const Header({
    @required this.onSkip,
  }) : assert(onSkip != null);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Logo(
          color: kWhite,
          size: 32.0,
        ),
        GestureDetector(
          onTap: onSkip,
          child: Text(
            'Skip',
            style:
            TextStyle(
              fontSize: 16,
              fontFamily: 'Circular',
              color: Color(0xffF2E7FE).withOpacity(0.5),
            ),
          ),
        ),
      ],
    );
  }
}