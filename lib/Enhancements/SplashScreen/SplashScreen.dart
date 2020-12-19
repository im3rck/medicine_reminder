import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:medicine_reminder/Enhancements/FadeAnimation/FadeAnimation.dart';
import 'package:medicine_reminder/FrontOnboarding/FrontMainOnboarding.dart';
import 'package:medicine_reminder/LaunchScreen/GooeyEdge.dart';
import 'package:medicine_reminder/PatientList/PhasePage.dart';
import 'package:rive/rive.dart';
import 'dart:async';
import 'package:medicine_reminder/LaunchScreen/demo.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SplashScreen extends StatefulWidget {
  @override
  _NEWState createState() => _NEWState();
}

class _NEWState extends State<SplashScreen> {
  Future checkFirstSeen() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    bool _seen = (prefs.getBool('seen') ?? false);

    if (_seen) {
      Navigator.of(context).push(FadeRoute(
          builder: (context) => GooeyEdgeDemo()
      ));
    } else {
      prefs.setBool('seen', true);
      Navigator.of(context).push(FadeRoute(
          builder: (context) => App()
      ));
    }
  }
  Artboard _riveArtboard;
  RiveAnimationController _controller;
  double opacityLevel = 1.0;
  @override
  void initState() {
    super.initState();
    Timer(
      Duration(milliseconds: 1500),
          () {
            // Navigator.pushReplacement(context, MaterialPageRoute(
            //     builder: (context) => PhasePage(),),
            // );
            checkFirstSeen();
      },
    );
    // Load the animation file from the bundle, note that you could also
    // download this. The RiveFile just expects a list of bytes.
    rootBundle.load('assets/Rive/pill4.riv').then(
          (data) async {
        final file = RiveFile();

        // Load the RiveFile from the binary data.
        if (file.import(data)) {
          // The artboard is the root of the animation and gets drawn in the
          // Rive widget.
          final artboard = file.mainArtboard;
          // Add a controller to play back a known animation on the main/default
          // artboard.We store a reference to it so we can toggle playback.
          artboard.addController(_controller = SimpleAnimation('Bounce Load'));
          setState(() => _riveArtboard = artboard);
        }
      },
    );
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff292929), //Color(0xFF3196ae),
      body: Center(
        child: Container(
          height: (MediaQuery.of(context).size.height)*.2,
          width: (MediaQuery.of(context).size.width)*.4,
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
            child: _riveArtboard == null
                ? const SizedBox()
                : Rive(artboard: _riveArtboard),
          ),
        ),
      ),
    );
  }
}
