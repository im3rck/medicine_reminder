import 'package:flutter/material.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:medicine_reminder/PatientController/PatientAddPage.dart';
import 'package:medicine_reminder/PatientController/customCard.dart';
import 'package:medicine_reminder/PatientList/configuration.dart';

class DrawerScreen extends StatefulWidget {
  @override
  _DrawerScreenState createState() => _DrawerScreenState();
}

class _DrawerScreenState extends State<DrawerScreen> {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xff121212),
      padding: EdgeInsets.only(top: 50, bottom: 70, left: 10),
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
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  Text('Active Status',
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold))
                ],
              )
            ],
          ),
          InkWell(
            onTap: (){
              Navigator.push(
                  context, MaterialPageRoute(builder: (context) => PatientAddPage()));
            },
            child: Container(
              alignment: Alignment.centerLeft,
                height: ((MediaQuery.of(context).size.height) -
                    50.0 -
                    175.0) *
                    .35,
                width: (MediaQuery.of(context).size.width) *.85,
                child: Card(
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
                  margin: EdgeInsets.all(5.0),
                  color: Color(0xffbb86fc),
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff121212),
                      border: Border.all(
                          color: Color(0xffBB86FC),
                          width: 1
                      ),
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
                    child: Padding(
                      padding: const EdgeInsets.all(24.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Icon(FontAwesomeIcons.plus, color: Color(0xfff2e7fe), size: 30.0),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Text("Add",style: TextStyle(
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                                color: Color(0xfff2e7fe),
                                height: 2,
                              ),),
                              SizedBox(height: 1.0,),
                              Text("New Patient", style: TextStyle(
                                fontSize: 14,
                                color: Color(0xfff2e7fe).withOpacity(0.6),
                                height: 2,
                              ),)
                            ],
                          )
                        ],
                      ),
                    ),
                  ),



                ),),
          ),
         /* Column(
            children: drawerItems
                .map((element) => Padding(
                      padding: const EdgeInsets.all(18.0),
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
                                  fontWeight: FontWeight.bold,
                                  fontSize: 20))
                        ],
                      ),
                    ))
                .toList(),
          ),*/
          Row(
            children: [
              Icon(
                Icons.settings,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Settings',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
              ),
              SizedBox(
                width: 10,
              ),
              Container(
                width: 2,
                height: 20,
                color: Colors.white,
              ),
              SizedBox(
                width: 10,
              ),
              Text(
                'Log out',
                style:
                    TextStyle(color: Colors.white, fontWeight: FontWeight.bold,fontSize: 20),
              )
            ],
          )
        ],
      ),
    );
  }
}
