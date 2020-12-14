import 'dart:async';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientScreen/Notif2Patient/ui/widgets/liquid.dart';
import 'package:medicine_reminder/PatientScreen/demo.dart';
class HomeView extends StatefulWidget {
  @override
  _HomeViewState createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> with TickerProviderStateMixin {
  AnimationController _animationController;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      body: Padding(
        padding: const EdgeInsets.all(40.0),
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Text(
              "Marked as Taken",
              style: TextStyle(
                  color: Color(0xffbb86fe),
                  fontSize: 30,
                  fontFamily: 'Circular',
                  fontWeight: FontWeight.w900),
            ),
            Liquid(
              isFlipped: true,
              controller: _animationController,
            ),
            Liquid(
              isFlipped: false,
              controller: _animationController,
            ),
          ],
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    _animationController = AnimationController(
      vsync: this,
      duration: Duration(
        milliseconds: 1000,
      ),
    );

    //startTime();
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }
}
