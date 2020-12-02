import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/FrontOnboarding/Constants.dart';



class IconContainer extends StatelessWidget {
  final IconData icon;
  final double padding;

  const IconContainer({
    @required this.icon,
    @required this.padding,
  })  : assert(icon != null),
        assert(padding != null);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(padding),
      decoration: BoxDecoration(
        color: Color(0xfff2e7fe).withOpacity(0.25),
        shape: BoxShape.circle,
      ),
      child: Icon(
        icon,
        size: 32.0,
        color: kWhite,
      ),
    );
  }
}