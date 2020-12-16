import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/FrontOnboarding/Constants.dart';
import 'package:medicine_reminder/FrontOnboarding/Widgets/Logo.dart';
import 'package:medicine_reminder/Authentication/Login/widgets/fade_slide_transition.dart';
class Header extends StatelessWidget {
  final Animation<double> animation;

  const Header({
    @required this.animation,
  }) : assert(animation != null);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: kPaddingL),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          // Logo(
          //   color: kBlue,
          //   size: 48.0,
          // ),
          FadeSlideTransition(
            animation: animation,
            additionalOffset: 0.0,
            child: Text(
              'Welcome to MedReminder',
              style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.w700,
                color: Color(0xffBB86FC),
                height: 2,
              ),
            ),
          ),
          const SizedBox(height: kSpaceS),
          // FadeSlideTransition(
          //   animation: animation,
          //   additionalOffset: 16.0,
          //   child: Text(
          //     'Est ad dolor aute ex commodo tempor exercitation proident.',
          //     style: Theme.of(context)
          //         .textTheme
          //         .subtitle1
          //         .copyWith(color: kBlack.withOpacity(0.5)),
          //   ),
          // ),
        ],
      ),
    );
  }
}
