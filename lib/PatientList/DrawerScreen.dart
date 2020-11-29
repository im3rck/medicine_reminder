import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import 'package:medicine_reminder/PatientController/PatientAddPage.dart';
import 'package:medicine_reminder/PatientScreen/QrGen.dart';
import 'configuration.dart';
import 'package:qrscan/qrscan.dart' as scanner;

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  String _fcmToken = null;

  _scan() async {
    String temp = await scanner.scan();
    //String temp = await BarcodeScanner.scan();
    setState(() {
      _fcmToken = temp;
    });
    if (_fcmToken != null) {
      print("Valid");
      print(_fcmToken);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => PatientAddPage()));
    } else {
      Navigator.push(context, MaterialPageRoute(builder: (context) => QrGen()));
    }
  }

  Future navigateToSubPage(context, int index) async {
    switch (index) {
      case 0:
        // Navigator.push(
        //     context, MaterialPageRoute(builder: (context) => PatientAddPage()));
        _scan();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: double.infinity,
      color: Color(0xff121212),
      padding: EdgeInsets.only(top: 50, left: 10),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              CircleAvatar(
                radius: 25.0,
                backgroundImage:
                    NetworkImage('https://via.placeholder.com/150'),
                backgroundColor: Colors.transparent,
              ),
              SizedBox(
                width: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    'Care Giver Name',
                    style: TextStyle(
                        fontFamily: 'Circular',
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text('Active Status',
                      style: TextStyle(
                          fontFamily: 'Circular',
                          color: Colors.white, fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
          // SizedBox(
          //   width: 10,
          //   height: 120,
          // ),
          Flexible(
            child: FractionallySizedBox(
              heightFactor: 0.6,
              child: Column(
                children: drawerItems
                    .map((element) => Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: GestureDetector(
                          onTap: () {
                            navigateToSubPage(context, element['index']);
                          },
                          child: Row(
                            children: [
                              Icon(
                                element['icon'],
                                color: Colors.white,
                                size: 30,
                              ),
                              SizedBox(
                                width: 10,
                              ),
                              Text(element['title'],
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Circular',
                                      fontWeight: FontWeight.bold,
                                      fontSize: 20))
                            ],
                          ),
                        )))
                    .toList(),
              ),
            ),
          ),

          // SizedBox(
          //   width: 10,
          //   height: 180,
          // ),
          Row(
            children: [
              GestureDetector(
                  onTap: () async {
                    await FirebaseAuth.instance.signOut();
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: 10,
                        height: 20,
                      ),
                      SvgPicture.asset(
                        'assets/images/logout.svg',
                        height: 25.0,
                        width: 25.0,
                        // allowDrawingOutsideViewBox: true,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        'Log out',
                        style: TextStyle(
                            color: Colors.white,
                            fontFamily: 'Circular',
                            fontWeight: FontWeight.bold,
                            fontSize: 28),
                      )
                    ],
                  )),
              SizedBox(
                width: 10,
                height: 80,
              ),
            ],
          ),
          // Flexible(
          //     child: FractionallySizedBox(
          //       heightFactor: 0.00000000001,
          //     )
        ],
      ),
    );
  }
}
