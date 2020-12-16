import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/FrontOnboarding/Constants.dart';
import 'package:medicine_reminder/Authentication/Login/widgets/custom_button.dart';
import 'package:medicine_reminder/Authentication/Login/widgets/fade_slide_transition.dart';
import 'package:medicine_reminder/Authentication/Login/widgets/custom_input_field.dart';
import 'package:neumorphic/neumorphic.dart';
class LoginForm extends StatelessWidget {
  final Animation<double> animation;

  const LoginForm({
    @required this.animation,
  }) : assert(animation != null);

  @override
  Widget build(BuildContext context) {
    var height =
        MediaQuery.of(context).size.height - MediaQuery.of(context).padding.top;
    var space = height > 650 ? kSpaceM : kSpaceS;

    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: <Widget>[
          // FadeSlideTransition(
          //   animation: animation,
          //   additionalOffset: 0.0,
          //   child: CustomInputField(
          //     label: 'Username or Email',
          //     prefixIcon: Icons.person,
          //     obscureText: true,
          //   ),
          // ),
          // SizedBox(height: space),
          // FadeSlideTransition(
          //   animation: animation,
          //   additionalOffset: space,
          //   child: CustomInputField(
          //     label: 'Password',
          //     prefixIcon: Icons.lock,
          //     obscureText: true,
          //   ),
          // ),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 2 * space,
            child: Center(
              child: Container(
                height: (MediaQuery.of(context).size.height)*.15,
                width: (MediaQuery.of(context).size.width)*.3,
                decoration: BoxDecoration(
                    color: Color(0xff292929),
                    borderRadius: BorderRadius.all(
                      Radius.circular(25),
                    ),
                    boxShadow: [
                      BoxShadow(
                          color: Color(0xff121212),
                          offset: Offset(5.0,5.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0
                      ),
                      BoxShadow(
                          color: Colors.grey[800],
                          offset: Offset(-5.0,-5.0),
                          blurRadius: 15.0,
                          spreadRadius: 1.0
                      )
                    ]
                  // border: Border.all(color: Color(0xffBB86FC), width: 1),
                ),
                child: Center(
                  child: Image(
                    image: AssetImage('assets/images/google_logo.png'),
                    height: 48.0,
                  ),
                ),
              ),
            ),
          ),
          SizedBox(height: 2 * space),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 4 * space,
            child: Text("Continue with Google", style: TextStyle(
              fontSize: 22,
              letterSpacing: 0.5,
              fontWeight: FontWeight.w700,
              color: Color(0xffBB86FC).withOpacity(0.5),
              height: 2,
            ),)
          ),
          SizedBox(height: 6 * space),
        ],
      ),
    );
  }
}
