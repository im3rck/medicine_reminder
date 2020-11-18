import 'package:flutter/material.dart';

class LoginOption extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        Text(
          "Existing user?",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xFFF2E7Fe),
            height: 1,
          ),
        ),

        SizedBox(
          height: 16,
        ),

        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Color(0xff292929),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
            /*border: Border.all(
                color: Color(0xffBB86FC),
                width: 1
            ),*/
            boxShadow: [
              BoxShadow(
                color: Colors.black54,
                spreadRadius: 1.0,
                blurRadius: 5.0,
                offset: Offset(5.0, 5.0),
              ),
              BoxShadow(
                color: Colors.grey[800],
                spreadRadius: 1.0,
                blurRadius: 5.0,
                offset: Offset(-5.0, -5.0),
              ),
            ],
          ),
          child: Center(
            child: Text(
              "Log In",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xffF2E7FE),
              ),
            ),
          ),
        ),

      ],
    );
  }
}