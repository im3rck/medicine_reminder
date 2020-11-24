//Details in the opened card

import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import 'demo_data.dart';
import 'patientMain.dart';

class FlightDetails extends StatelessWidget {
  final BoardingPassData boardingPass;
  final TextStyle titleTextStyle = TextStyle(
      fontFamily: 'OpenSans',
      fontSize: 11,
      height: 1,
      letterSpacing: .2,
      fontWeight: FontWeight.w600,
      color: Color(0xffafafaf),
      package: App.pkg);
  final TextStyle contentTextStyle =
      TextStyle(fontFamily: 'Oswald', fontSize: 16, height: 1.8, letterSpacing: .3, color: Color(0xff083e64), package: App.pkg);

  FlightDetails(this.boardingPass);

  @override
  Widget build(BuildContext context) => Container(
        decoration: BoxDecoration(
          color: Color(0xff292929),
          borderRadius: BorderRadius.circular(4.0),
        ),
        width: double.infinity,
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            /*Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text('Gate'.toUpperCase(), style: titleTextStyle),
                  Text(boardingPass.gate, style: contentTextStyle),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text('Zone'.toUpperCase(), style: titleTextStyle),
                  Text(boardingPass.zone.toString(), style: contentTextStyle),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text('Seat'.toUpperCase(), style: titleTextStyle),
                  Text(boardingPass.seat, style: contentTextStyle),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text('Class'.toUpperCase(), style: titleTextStyle),
                  Text(boardingPass.flightClass, style: contentTextStyle),
                ]),
              ],
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text('Medicine Name : '.toUpperCase(), style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 14,
                    color: Color(0xffF2E7FE).withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),),//titleTextStyle),
                  Text('Paracetamol'/*boardingPass.flightNumber*/, style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 16,
                    color: Colors.white,
                    //fontWeight: FontWeight.w600,
                    fontWeight: FontWeight.bold,
                    height: 2, letterSpacing: .5,
                  ),),//contentTextStyle),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text('Quantity : '.toUpperCase(), style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 14,
                    color: Color(0xffF2E7FE).withOpacity(0.6),
                    fontWeight: FontWeight.w700,
                  ),),//titleTextStyle),
                  Text('2 units'/*DateFormat('MMM d, H:mm').format(boardingPass.departs).toUpperCase()*/, style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 2, letterSpacing: .5,
                  ),),//contentTextStyle),
                ]),
                Column(crossAxisAlignment: CrossAxisAlignment.start, children: <Widget>[
                  Text('Consume At'.toUpperCase(), style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 14,
                    color: Color(0xffF2E7FE).withOpacity(0.6),
                    fontWeight: FontWeight.w600,
                  ),),//titleTextStyle),
                  Text(DateFormat('MMM d, H:mm').format(boardingPass.arrives).toUpperCase(), style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                    height: 2, letterSpacing: .5,
                  ),),//contentTextStyle)
                ]),
              ],
            ),
          ],
        ),
      );
}
