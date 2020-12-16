import 'package:flutter/material.dart';
import 'dart:math';
import 'package:flutter/scheduler.dart';
import 'package:medicine_reminder/Enhancements/PreviewAuth.dart';
import 'package:medicine_reminder/PatientScreen/QrGen.dart';

import 'Launch.dart';
import 'package:medicine_reminder/Authentication/Login/login.dart';
class ContentCard extends StatefulWidget {
  final String color;
  final Color altColor;
  final String title;
  final String subtitle;

  ContentCard({this.color, this.title = "", this.subtitle, this.altColor})
      : super();

  @override
  _ContentCardState createState() => _ContentCardState();
}

class _ContentCardState extends State<ContentCard> {
  Ticker _ticker;
  double opacityLevel = 1.0;
  String token;

  @override
  void initState() {
    _ticker = Ticker((d) {
      setState(() {});
    })
      ..start();
    super.initState();
  }

  @override
  void dispose() {
    _ticker.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    var time = DateTime.now().millisecondsSinceEpoch / 2000;
    var scaleX = 1.2 + sin(time) * .05;
    var scaleY = 1.2 + cos(time) * .07;
    var offsetY = 20 + cos(time) * 20;
    double height = MediaQuery.of(context).size.height;
    return Stack(
      alignment: Alignment.center,
      fit: StackFit.expand,
      children: <Widget>[
        Transform(
          transform: Matrix4.diagonal3Values(scaleX, scaleY, 1),
          child: Transform.translate(
            offset: Offset(-(scaleX - 1) / 2 * size.width,
                -(scaleY - 1) / 2 * size.height + offsetY),
            child: Image.asset('images/bcg-${widget.color}.png',
                fit: BoxFit.cover, package: App.pkg),
          ),
        ),
        Container(
          alignment: Alignment.center,
          child: Padding(
            padding: const EdgeInsets.only(top: 75.0, bottom: 25.0),
            child: Column(
              children: <Widget>[
                //Top Image
                Expanded(
                  flex: 3,
                  child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 20.0),
                      child: Image.asset('assets/images/screen-${widget.color}.png',
                          fit: BoxFit.contain, package: App.pkg)),
                ),

                //Slider circles
                Container(
                    height: 14,
                    child: Image.asset('assets/images/S-${widget.color}.png',
                        package: App.pkg)),

                //Bottom content
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 18.0),
                    child: _buildBottomContent(),
                  ),
                ),
              ],
            ),
          ),
        )
      ],
    );
  }

  Widget _buildBottomContent() {
    double height = MediaQuery.of(context).size.height;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        Text(widget.title,
            textAlign: TextAlign.center,
            style: TextStyle(
                height: 1.2,
                fontSize: 30.0,
                fontFamily: 'Circular',
                color: (widget.color == 'Yellow'
                    ? Color(0xFF121212)
                    : Colors.white),
                package: App.pkg)),
        Text(widget.subtitle,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14.0,
                fontWeight: FontWeight.w300,
                fontFamily: 'Circular',
                color: (widget.color == 'Yellow'
                    ? Color(0xFF121212)
                    : Colors.white),
                package: App.pkg)),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 36.0),
          child: AnimatedOpacity(
            duration: Duration(seconds: 1),
            opacity: 1.0, //_changeOpacity(),
            child: (widget.color == 'Yellow'
                ? Text('')
                : Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => (widget.color == 'Red'
                                    ? QrGen()
                                    : Login(
                                  screenHeight: height
                                ))));
                        //Navigator.pop(context);
                      },
                      child: Container(
                        height: 40,
                        width: (MediaQuery.of(context).size.width) * .8,
                        decoration: BoxDecoration(
                          color: (widget.color == 'Red'
                              ? Color(0xff456BFF)
                              : (widget.color == 'Blue'
                                  ? Color(0xff121212)
                                  : Color(0xffF2E7FE))),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          border: Border.all(
                              color: (widget.color == 'Blue'
                                  ? Color(0xff456BFF)
                                  : Color(0xff121212)),
                              width: 2),
                          boxShadow: [
                            BoxShadow(
                              color: (widget.color == 'Red'
                                  ? Color(0xff456BFF)
                                  : (widget.color == 'Blue'
                                      ? Color(0xff121212)
                                      : Color(0xffF2E7FE))),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text(
                            "Continue",
                            style: TextStyle(
                              fontSize: 20,
                              fontWeight: FontWeight.bold,
                              color: (widget.color == 'Yellow'
                                  ? Color(0xff121212)
                                  : Color(0xffF2E7FE)),
                            ),
                          ),
                        ),
                      ),
                    ),
                )),
          ),
        )
      ],
    );
  }
}
