import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:rive/rive.dart';
import 'package:firebase_core/firebase_core.dart';


class QrGen extends StatefulWidget {
  @override
  _QrGenState createState() => _QrGenState();
}

class _QrGenState extends State<QrGen> {


  String _fcmToken;
  void initState(){
    super.initState();
    dataToken();
  }

  dataToken() async{
    // final _initialization = await Firebase.initializeApp();
    String result = await FirebaseMessaging().getToken();
    setState(() {
      _fcmToken = result;
    });

  }

  Widget _buildAppBar() {
    Color appBarIconsColor = Color(0xFF292929);
    return AppBar(
      shadowColor: Color(0xff292929),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Color(0xffBB86Fe)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Icon(Icons.more_horiz, color: Color(0xffBB86Fe), size: 28),
        )
      ],
      brightness: Brightness.light,
      backgroundColor: Color(0xFF292929),
      elevation: 10.0,
      title: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'MedReminder',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Circular',
            fontSize: 20,
            letterSpacing: 0.5,
            color: Color(0xffbb86fe),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: _buildAppBar(),
      body:
      Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          //Image.asset('assets/images/Name_text.png',fit: BoxFit.contain),
          _fcmToken == null ?

          Text('Loading') :

          Card(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.all(7.0),
            color: Color(0xFF292929),
            elevation: 20,
            child: Container(
              decoration: BoxDecoration(
                color: Color(0xff292929),
                //border: Border.all(color: Color(0xffbb86fe), width: 1),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff121212).withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              margin: EdgeInsets.only(left: 20.0,right: 20.0),
              padding: EdgeInsets.only(left: 20.0,right: 20.0),
              child: QrImage(data: _fcmToken,foregroundColor: Color(0xffBB86FC),
                  backgroundColor: Color(0xFF292929),
                  embeddedImage: AssetImage('assets/Logo/AppLogoLiningBorder.png')
              ),

            ),
          ),
        ],
      ),

    );
  }
}
