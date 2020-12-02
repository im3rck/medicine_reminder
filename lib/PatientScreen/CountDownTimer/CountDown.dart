import 'package:flutter/material.dart';
import 'package:slide_countdown_clock/slide_countdown_clock.dart';


class CountDownTimer extends StatefulWidget {


  final String title="Title";

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<CountDownTimer> {
  GlobalKey<ScaffoldState> _scaffoldKey = GlobalKey();
  Duration _duration = Duration(seconds: 10);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      key: _scaffoldKey,
      appBar: AppBar(title: Text(widget.title)),
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text('Slide direction Up'),
            SlideCountdownClock(
              duration: Duration(days: 0, minutes: 1),
              slideDirection: SlideDirection.Up,
              separator: ":",
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              shouldShowDays: true,
              onDone: () {
                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
              },
            ),
            _buildSpace(),
            Text('Slide direction Down'),
            SlideCountdownClock(
              duration: _duration,
              slideDirection: SlideDirection.Down,
              separator: ":",
              textStyle: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              onDone: () {
                _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
              },
            ),
            _buildSpace(),
            Text('Use box Decoration'),
            Padding(
              padding: EdgeInsets.all(10),
              child: SlideCountdownClock(
                duration: _duration,
                slideDirection: SlideDirection.Up,
                separator: "-",
                textStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffbb86fe),
                ),
                separatorTextStyle: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                  color: Color(0xfff2e7fe),
                ),
                padding: EdgeInsets.all(10),
                decoration: BoxDecoration(color: Color(0xff292929), shape: BoxShape.rectangle),
                onDone: () {
                  _scaffoldKey.currentState.showSnackBar(SnackBar(content: Text('Clock 1 finished')));
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildSpace() {
    return SizedBox(height: 50);
  }
}
