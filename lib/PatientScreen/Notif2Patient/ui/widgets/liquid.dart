import 'dart:async';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicine_reminder/PatientScreen/Notif2Patient/core/viewmodels/home_model.dart';
import 'package:medicine_reminder/PatientScreen/Notif2Patient/ui/shared/globals.dart';
import 'package:lottie/lottie.dart';
import 'package:medicine_reminder/PatientScreen/demo.dart';
import 'package:neumorphic/neumorphic.dart';
import 'package:provider/provider.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';


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

    final double height = 200;

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

                    ),
                    ValueDelegate.color(const ['**', 'Shape 1', 'Fill 1'],
                        value: Global.bgColor),

                  ],
                ),
              ),
            ),

            widget.isFlipped
                ? Container(
              decoration: BoxDecoration(
                color: Color(0xffbb86fe),
                borderRadius: BorderRadius.all(
                  Radius.circular(15.0),
                ),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  SizedBox(height: (MediaQuery.of(context).size.height)*.09),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text("Name: ",style: TextStyle(
                          fontFamily: 'Circular',
                          fontSize: 20.0,
                          color: Color(0xff292929), fontWeight: FontWeight.w700),),
                      Text("Panadol",style: TextStyle(
                          fontFamily: 'Circular',
                          fontSize: 24.0,
                          color: Color(0xff292929), fontWeight: FontWeight.w700),),
                    ],
                  ),
                ],
              ),
            )
                : Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Text("Dosage: ",style: TextStyle(
                                    fontSize: 20.0,
                                    fontFamily: 'Circular',
                                    color: Color(0xff292929), fontWeight: FontWeight.w700),),
                                Text("20mg",style: TextStyle(
                                    fontFamily: 'Circular',
                                    fontSize: 16.0,
                                    color: Color(0xff292929), fontWeight: FontWeight.w500),),
                              ],
                            ),

                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Text("Type: ",style: TextStyle(
                                fontSize: 20.0,
                                fontFamily: 'Circular',
                                color: Color(0xff292929), fontWeight: FontWeight.w700),),
                            Text("Syrup",style: TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 16.0,
                                color: Color(0xff292929), fontWeight: FontWeight.w500),),
                          ],
                        ),
                          ],
                        ),
                        Container(
                          height: (MediaQuery.of(context).size.height)*.1,
                          width: (MediaQuery.of(context).size.width)*.3,
                          child: GestureDetector(
                            child: Hero(
                                tag: 'imageHero',
                                child: Image.asset('assets/images/medbottle.jpg', fit: BoxFit.contain,),
                                ),
                            onTap: () {
                              Navigator.push(context, MaterialPageRoute(builder: (_) {
                                return DetailScreen();
                              }));
                            },
                          ),
                        ),
                      ],
                    ),
                            SizedBox(height: 20.0,),
                            GestureDetector(
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
                                  width: (MediaQuery.of(context).size.height)*.09,
                                  height: (MediaQuery.of(context).size.height)*.09,
                                  bevel: 16,
                                  decoration: NeumorphicDecoration(
                                    color:
                                        model.isOpening ? Global.activeColor : Color(0xffad6dfe),
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  child: Center(
                                    child: FaIcon(
                                      model.isOpening ? FontAwesomeIcons.heart : Icons.check_rounded,
                                      color: Color(0xff292929),
                                    ),
                                  ),
                                ),
                              ),
                            SizedBox(height: 30.0,)
                  ],
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

class DetailScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff292929),
      body: GestureDetector(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              margin: EdgeInsets.all(MediaQuery.of(context).size.width)*.1,
              color: Color(0xff292929),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height/2,
              child: Hero(
                tag: 'imageHero',
                child: Image.asset('assets/images/medbottle.jpg', fit: BoxFit.contain,),
              ),
            ),
          ],
        ),
        onTap: () {
          Navigator.pop(context);
        },
      ),
    );
  }
}