import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';

class SettingsPage extends StatefulWidget {
  @override
  _SettingsPageState createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff292929),
      appBar: AppBar(
        backgroundColor: Color(0xff121212),
        elevation: 1,
        leading: IconButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Color(0xffbb86fe),
          ),
        ),
      ),
      body: Container(
        padding: EdgeInsets.only(left: 16, top: 25, right: 16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            Text(
              AppLocalizations.of(context).translate('Settings'),
              style: TextStyle(
                fontSize: 25,
                color: Color(0xffbb86fe),
                fontWeight: FontWeight.bold,
              ),),
            SizedBox(
              height: 40,
            ),
            Row(
              children: [
                Icon(
                  Icons.person,
                  color: Color(0xffbb86fe),
                ),
                SizedBox(
                  width: 8,
                ),
                Text(
                  AppLocalizations.of(context).translate('Account'),
                  style: TextStyle(
                    fontSize: 16,
                    color: Color(0xfff2e7fe),
                    fontWeight: FontWeight.w600,
                  ),),
              ],
            ),
            Divider(
              height: 15,
              thickness: 2,
              color: Color(0xffbb86fe),
            ),
            SizedBox(
              height: 10,
            ),
            buildAccountOptionRow(context, "Change password"),
            buildAccountOptionRow(context, "Language"),
            buildAccountOptionRow(context, AppLocalizations.of(context).translate('Support_Us')),
            buildAccountOptionRow(context, AppLocalizations.of(context).translate('Report_a_Bug')),
            buildAccountOptionRow(context, AppLocalizations.of(context).translate('Privacy_and_Security')),
            SizedBox(
              height: 20,
            ),
            SizedBox(
              height: 10,
            ),
            // buildNotificationOptionRow("New for you", true),
            // buildNotificationOptionRow("Account activity", true),
            // buildNotificationOptionRow("Opportunity", false),
            SizedBox(
              height: 50,
            ),
            Center(
              child: Container(
                decoration: BoxDecoration(
                  color: Color(0xff292929),
                  borderRadius: BorderRadius.all(
                    Radius.circular(25),
                  ),
                ),
                child: NeumorphicButton(
                  provideHapticFeedback: true,
                  drawSurfaceAboveChild: true,
                  margin: EdgeInsets.all(5.0),
                  padding: EdgeInsets.only(top: (MediaQuery.of(context).size.height)*.03, bottom: (MediaQuery.of(context).size.height)*.03,left: (MediaQuery.of(context).size.width)*.1,right: (MediaQuery.of(context).size.width)*.1),
                  pressed: true,

                  onPressed: () async{
                    await FirebaseAuth.instance.signOut();
                    },
                  style: NeumorphicStyle(
                    border: NeumorphicBorder(
                        isEnabled: true,
                        color: Color(0xff292929)
                    ),
                    depth: 8,
                    boxShape: NeumorphicBoxShape.stadium(),
                    color: Color(0xff292929),
                    shadowDarkColor: Color(0xff121212),
                    shadowLightColor: Colors.grey[800],
                  ),
                  child: Text(
                    AppLocalizations.of(context).translate('Log_Out'),
                    style: TextStyle(
                      fontSize: 16,
                      color: Color(0xffbb86fe),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
            ),
            SizedBox(height: 20.0),
          ],
        ),
      ),
    );

  }



  GestureDetector buildAccountOptionRow(BuildContext context, String title) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: Text(title),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("Option 1"),
                    Text("Option 2"),
                    Text("Option 3"),
                  ],
                ),
                actions: [
                  FlatButton(
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: Text("Close")),
                ],
              );
            });
      },
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 8.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: TextStyle(
                fontSize: 18,
                color: Color(0xffbbf2e7fe),
                fontWeight: FontWeight.w500,
              ),
            ),
            Icon(
              Icons.arrow_forward_ios,
              color: Color(0xffbb86fe),
            ),
          ],
        ),
      ),
    );
  }
}