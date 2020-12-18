import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';
import 'CardData.dart';

enum SummaryTheme { dark, light }

Duration _duration = Duration(seconds: 10);

class FrontCard extends StatelessWidget {
  final ScheduleModel miniDetails;
  final SummaryTheme theme;
  final bool isOpen;

  const FrontCard(
      {Key key,
      this.miniDetails,
      this.theme = SummaryTheme.light,
      this.isOpen = false})
      : super(key: key);



  TextStyle get bodyTextStyle => TextStyle(
        color: Color(0xffF2E7FE),
        fontSize: 13,
        fontFamily: 'Oswald',
      );

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: _getBackgroundDecoration(),
      width: double.infinity,
      height: double.infinity,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: <Widget>[
            _buildLogoHeader(),
            _buildSeparationLine(),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 18.0),
              child: Align(
                  alignment: Alignment.center,
                  child: isOpen ? SizedBox():Text(
                    miniDetails.medName.toUpperCase(),
                    style: bodyTextStyle.copyWith(fontSize: 42),
                  ),
              ),
            ),
            _buildBottomIcon()
          ],
        ),
      ),
    );
  }

  // Fill the medicine pic here
  _getBackgroundDecoration() {
    if (theme == SummaryTheme.light)
      return BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        color: Color(0xff292929),
      );
    if (theme == SummaryTheme.dark)
      return BoxDecoration(
        borderRadius: BorderRadius.circular(4.0),
        //pull medicine image from database and put it here
        image: DecorationImage(
            image: AssetImage('images/App_logo_plain.png'), fit: BoxFit.cover),
      );
  }

  _buildLogoHeader() {
    if (theme == SummaryTheme.light)
      return Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 4.0),
                child: Image.asset('images/pill.png', width: 10),
              ),
              Text(
                'MedReminder'.toUpperCase(),
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 16,
                  color: Color(0xffF2E7FE),
                  letterSpacing: 1.5,
                  fontWeight: FontWeight.bold,
                ),
              )
            ],
          ),
          Padding(
            padding: EdgeInsets.all(5),
            child: SlideCountdownClock(
              duration: _duration,
              slideDirection: SlideDirection.Down,
              separator: "-",
              textStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xffbb86fe),
              ),
              separatorTextStyle: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Color(0xfff2e7fe),
              ),
              padding: EdgeInsets.all(5),
              decoration: BoxDecoration(
                  color: Color(0xff292929), shape: BoxShape.rectangle),
              onDone: () {},
            ),
          ),
        ],
      );
    if (theme == SummaryTheme.dark)
      return Padding(
        padding: const EdgeInsets.only(top: 2.0),
        //child: Image.asset('images/logo_white.png', height: 12, package: App.pkg),
      );
  }

  Widget _buildSeparationLine() {
    return Container(
      width: double.infinity,
      height: 1,
      color: Color(0xffbb86fe),
    );
  }


  Widget _buildBottomIcon() {
    IconData icon;
    if (theme == SummaryTheme.light) icon = Icons.keyboard_arrow_down;
    if (theme == SummaryTheme.dark) icon = Icons.keyboard_arrow_up;
    return Icon(
      icon,
      color: Color(0xffF2E7FE),
      size: 18,
    );
  }
}



// The Airplane Transition ( Not needed Anymore )

// class _AnimatedSlideToRight extends StatefulWidget {
//   final Widget child;
//   final bool isOpen;
//
//   const _AnimatedSlideToRight({Key key, this.child, @required this.isOpen})
//       : super(key: key);
//
//   @override
//   _AnimatedSlideToRightState createState() => _AnimatedSlideToRightState();
// }
//
// class _AnimatedSlideToRightState extends State<_AnimatedSlideToRight>
//     with SingleTickerProviderStateMixin {
//   AnimationController _controller;
//
//   @override
//   void initState() {
//     super.initState();
//     _controller = AnimationController(
//         duration: Duration(milliseconds: 1700), vsync: this);
//   }
//
//   @override
//   void dispose() {
//     _controller.dispose();
//     super.dispose();
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     if (widget.isOpen) _controller.forward(from: 0);
//     return SlideTransition(
//       position: Tween(begin: Offset(-2, 0), end: Offset(1, 0)).animate(
//           CurvedAnimation(curve: Curves.easeOutQuad, parent: _controller)),
//       child: widget.child,
//     );
//   }
// }
