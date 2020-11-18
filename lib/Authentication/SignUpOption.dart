import 'package:flutter/material.dart';


class SignUpOption extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    Color baseColor = Color(0xFFF2F2F2);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[

        SizedBox(
          height: 24,
        ),
        Text(
          "New user?",
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.bold,
            color: Color(0xfff2e7fe),
            height: 1,
          ),
        ),
        SizedBox(
          height: 16,
        ),
        Container(
          height: 40,
          decoration: BoxDecoration(
            color: Colors.grey[850],//Color(0xFF121212),
            borderRadius: BorderRadius.all(
              Radius.circular(25),
            ),
           /* border: Border.all(
              color: Color(0xffBB86FC)
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
          child:  Center(
            child: Text(
              "Sign Up",
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
                color: Color(0xFFF2E7FE),
              ),
            ),
          ),
        ),

      ],
    );
  }
}