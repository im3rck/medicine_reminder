import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicine_reminder/Enhancements/SplashScreen/core/viewmodels/home_model.dart';
import 'package:medicine_reminder/Enhancements/SplashScreen/ui/shared/globals.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_reminder/PatientScreen/demo.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';

class Liquid extends StatefulWidget {
  final bool isFlipped;
  final AnimationController controller;

  Liquid({
    @required this.isFlipped,
    @required this.controller,
  });

  @override
  _LiquidState createState() => _LiquidState();
}

class _LiquidState extends State<Liquid> {

  @override
  Widget build(BuildContext context) {
    final model = Provider.of<HomeModel>(context);

    final double height = 200.0;

    return Center(
      child: AnimatedContainer(
        duration: Duration(milliseconds: 2000),
        curve: Curves.elasticOut,
        transform: Matrix4.identity()
          ..translate(
            0.0,
            widget.isFlipped ? -model.openValue - 100 : model.openValue + 100,
          ),
        decoration: BoxDecoration(
          color: Global.bgColor,
          boxShadow: [
            BoxShadow(
              blurRadius: 30.0,
              color: !widget.isFlipped ? Color(0xff202020) : Color(0xff242424),
              offset: Offset(widget.isFlipped ? -20 : 20, widget.isFlipped ? -30 : 30),
            ),
          ],
          borderRadius: BorderRadius.all(
            Radius.circular(15.0),
          ),
        ),
        height: height,
        child: Stack(
          alignment: Alignment.center,
          children: <Widget>[
            Transform(
              transform: Matrix4.identity()
                ..scale(1.0, widget.isFlipped ? -1.0 : 1.0)
                ..translate(0.0, widget.isFlipped ? -height * 2 + 50 : -height + 50),
              child: Lottie.asset(
                'data/liquid.json',
                controller: widget.controller,
                animate: false,
                height: height,
                delegates: LottieDelegates(
                  values: [
                    ValueDelegate.color(
                      const ['**', 'Rectangle 1', 'Fill 1'],
                      value: Global.bgColor,
                      // value: Colors.red,
                    ),
                    ValueDelegate.color(const ['**', 'Shape 1', 'Fill 1'],
                        value: Global.bgColor),
                    // value: Colors.red),
                  ],
                ),
              ),
            ),
            widget.isFlipped
                ? SizedBox()
                : GestureDetector(
                    onTap: () {
                      model.openLiquidMenu(widget.controller);
                      setState(() {
                        startTime();
                      });
                    },
                    child: NeuCard(
                      curveType: model.isOpening
                          ? CurveType.emboss
                          : CurveType.concave,
                      width: 88,
                      height: 88,
                      bevel: 16,
                      decoration: NeumorphicDecoration(
                        color:
                            model.isOpening ? Global.activeColor : Color(0xff222222),
                        borderRadius: BorderRadius.circular(8),
                      ),
                      child: Icon(
                        model.isOpening ? Icons.lock_open : Icons.lock,
                        color: Color(0xffbb86fe),
                      ),
                    ),
                  ),
          ],
        ),
      ),
    );

  }
  startTime() async {
    var duration = new Duration(milliseconds: 2000);
    return new Timer(duration, route);
  }
  route() {
    Navigator.pushReplacement(context, MaterialPageRoute(
        builder: (context) => TicketFoldDemo()
    )
    );
  }
}
