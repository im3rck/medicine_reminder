import 'package:flutter/material.dart';
import 'package:medicine_reminder/FrontOnboarding/Constants.dart';



class TextColumn extends StatelessWidget {
  final String title;
  final String text;

  const TextColumn({
    @required this.title,
    @required this.text,
  })  : assert(title != null),
        assert(text != null);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Text(
          title,
          style: TextStyle(
            fontSize: 20,
            fontFamily: 'Circular',
            fontWeight: FontWeight.bold,
            color: Color(0xffF2E7FE),
        ),),
        const SizedBox(height: kSpaceS),
        Text(
          text,
          style: TextStyle(
            fontSize: 16,
            fontFamily: 'Circular',
            fontWeight: FontWeight.w500,
            color: Color(0xffF2E7FE),
          ),
        ),
      ],
    );
  }
}