import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_reminder/PatientList/FullPatientDetails/FullPatientDetails.dart';
import 'package:medicine_reminder/PatientList/datafile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 0;
  double yOffset = 0;
  double scaleFactor = 1;
  var b;
  List c = [];

  bool isDrawerOpen = false;
  query()  {
    FirebaseFirestore _newDb = FirebaseFirestore.instance;
    _newDb
        .collection('/users/uOzQ4baX4CbRy3vnSKCyCJGi7sw1/patients')
        .get()
        .then((QuerySnapshot querySnapshot) => {
    querySnapshot.docs.forEach((doc) {
    print(doc['patientName']);
    Map a = {
      'patientToken': doc['patientToken'],
      'patientName': doc['patientName'],
      'age':doc['age'],
      'gender':doc['gender'],
      'contactNo':doc['contactNo'],
      'relationship' : doc['relationship'],
      'index' : 123
    };
    c.add(a);
    print("Hello: $c");
    }) });

  return c;
  }
  @override
  Widget build(BuildContext context) {
    DateTime now = DateTime.now();
    String formattedDate = DateFormat('kk:mm \n EEE d MMM').format(now);
    return GestureDetector(
      onTap: () {
        if (isDrawerOpen) {
          setState(() {
            xOffset = 0;
            yOffset = 0;
            scaleFactor = 1;
            isDrawerOpen = false;
          });
        } else {}
      },
      child: AnimatedContainer(
        height: double.infinity,
        transform: Matrix4.translationValues(xOffset, yOffset, 0)
          ..scale(scaleFactor)
          ..rotateY(isDrawerOpen ? -0.5 : 0),
        duration: Duration(milliseconds: 250),
        // margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        decoration: BoxDecoration(
          color: (isDrawerOpen ? Colors.grey[850] : Color(0xFF121212)),
          borderRadius: BorderRadius.circular(isDrawerOpen ? 40 : 0.0),
          border: Border.all(
            color: (isDrawerOpen ? Color(0xffBB86FC) : Color(0xFF292929)),
          ),
        ),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SizedBox(
                height: 50,
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    isDrawerOpen
                        ? IconButton(
                            icon: Icon(
                              Icons.arrow_back_ios,
                              color: (isDrawerOpen
                                  ? Color(0xffbb86fe)
                                  : Color(0xFFbb86fe)),
                            ),
                            onPressed: () {
                              setState(() {
                                xOffset = 0;
                                yOffset = 0;
                                scaleFactor = 1;
                                isDrawerOpen = false;
                              });
                            },
                          )
                        : IconButton(
                            icon: Icon(Icons.menu, color: Color(0xffbb86fe)),
                            onPressed: () {
                              setState(() {
                                xOffset = 230;
                                yOffset = 150;
                                scaleFactor = 0.6;
                                isDrawerOpen = true;
                              });
                            }),
                    Container(
                      alignment: Alignment.center,
                      child: Text(
                        formattedDate,
                        textAlign: TextAlign.center,
                        style: new TextStyle(
                            color: (isDrawerOpen
                                ? Color(0xfff2e7fe).withOpacity(0.6)
                                : Color(0xfff2e7fe)),
                            fontFamily: 'Circular',
                            fontWeight: FontWeight.bold,
                            fontSize: 25.0),
                      ),
                    ),
                    SizedBox(
                      height: 50,
                      width: 50,
                    ),
                  ],
                ),
              ),
              Container(
                height: 50.0,
                padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                margin: EdgeInsets.symmetric(vertical: 20, horizontal: 20),
                decoration: BoxDecoration(
                  color: (isDrawerOpen ? Colors.grey : Color(0xFF292929)),
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                      color: (isDrawerOpen
                          ? Color(0xff292929)
                          : Color(0xFFbb86fe)),
                      width: (isDrawerOpen ? 2 : 1)),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    IconButton(
                      icon: Icon(
                        Icons.settings,
                        color: (isDrawerOpen
                            ? Color(0xff292929)
                            : Color(0xFFf2e7fe)),
                      ),
                      onPressed: () {},
                    ),
                    Text(
                      'Search my list',
                      style: new TextStyle(
                          color: Color(0xfff2e7fe),
                          fontFamily: 'Circular',
                          fontWeight: FontWeight.bold,
                          fontSize: 15.0),
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Color(0xfff2e7fe)),
                      onPressed: () {},
                    ),
                  ],
                ),
              ),

              Column(
                  mainAxisSize: MainAxisSize.max,
                  children: query().map<Widget>((element) =>
                      Padding(
                            padding: const EdgeInsets.all(12.0),
                            child: GestureDetector(
                              onTap: () {
                                if (isDrawerOpen) {
                                  setState(() {
                                    xOffset = 0;
                                    yOffset = 0;
                                    scaleFactor = 1;
                                    isDrawerOpen = false;
                                  });
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              BottomNavBar(element['contactNo'])));
                                }
                              },
                              child: Container(
                                height: 200,
                                margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Stack(
                                        children: [
                                          Container(
                                            decoration: BoxDecoration(
                                              color: Color(0xff292929),
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  color: Color(0xffBB86FC),
                                                  width: 1),
                                              //  boxShadow: shadowList,
                                            ),
                                            // margin: EdgeInsets.only(top: 10),
                                          ),
                                         Align(
                                            child: Hero(
                                                tag: element['index'],
                                                child: Image.asset(
                                                    'assets/images/cat.png')),
                                          )
                                        ],
                                      ),
                                    ),
                                    Flexible(
                                        child: Container(
                                      child: Column(
                                        children: [
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 10, 20, 10),
                                            child: AutoSizeText(
                                              element['patientName'],
                                              maxLines: 1,
                                              style: new TextStyle(
                                                  color: Color(0xff292929),
                                                  fontFamily: 'Circular',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 30),
                                            ),
                                          ),
                                          Divider(
                                            color: Color(0xff121212),
                                            thickness: 2.0,
                                          ),
                                          Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Container(
                                                margin: EdgeInsets.fromLTRB(
                                                    10, 0, 0, 10),
                                                child: Text(
                                                  (element['age']).toString() +
                                                      " years",
                                                  style: new TextStyle(
                                                      color: Color(0xff292929),
                                                      fontFamily: 'Circular',
                                                      fontWeight:
                                                          FontWeight.bold,
                                                      fontSize: 15.0),
                                                ),
                                              ),
                                              Container(
                                                  margin: EdgeInsets.fromLTRB(
                                                      10, 0, 10, 10),
                                                  child: (element['gender'] ==
                                                          'Male'
                                                      ? SvgPicture.asset(
                                                          'assets/images/male.svg',
                                                          height: 25.0,
                                                          width: 25.0,
                                                          allowDrawingOutsideViewBox:
                                                              true,
                                                        )
                                                      : element['gender'] ==
                                                              'Female'
                                                          ? SvgPicture.asset(
                                                              'assets/images/female.svg',
                                                              height: 25.0,
                                                              width: 25.0,
                                                              allowDrawingOutsideViewBox:
                                                                  true,
                                                            )
                                                          : SvgPicture.asset(
                                                              'assets/images/other.svg',
                                                              height: 25.0,
                                                              width: 25.0,
                                                              allowDrawingOutsideViewBox:
                                                                  true,
                                                            )))
                                            ],
                                          ),
                                          Container(
                                            margin: EdgeInsets.fromLTRB(
                                                10, 10, 20, 10),
                                            alignment: Alignment.centerLeft,
                                            child: Text(
                                              element['relationship'],
                                              style: new TextStyle(
                                                  color: Color(0xff292929),
                                                  fontFamily: 'Circular',
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20.0),
                                            ),
                                          ),
                                        ],
                                      ),
                                      margin:
                                          EdgeInsets.only(top: 20, bottom: 20),
                                      decoration: BoxDecoration(
                                        color: Color(0xffffffffff)
                                            .withOpacity(0.6),
                                        // boxShadow: shadowList,
                                        borderRadius: BorderRadius.only(
                                            topRight: Radius.circular(20),
                                            bottomRight: Radius.circular(20)),
                                        border: Border.all(
                                            color: (isDrawerOpen
                                                ? Color(0xff292929)
                                                : Color(0xFFbb86fe)),
                                            width: (isDrawerOpen ? 2 : 1)),
                                      ),
                                    ))
                                  ],
                                ),
                              ),
                            ),
                          ))
                      .toList()),

              // Container(
              //   //color: Color(0xff292929),
              //   /*decoration: BoxDecoration(
              //
              //   borderRadius: BorderRadius.only(
              //       topLeft: Radius.circular(20.0),
              //       topRight: Radius.circular(20.0)),
              // ),*/
              //   height: 600,
              //   child: ListView.builder(
              //     shrinkWrap: true,
              //     itemBuilder: (BuildContext context, int index) {
              //       return

              //     },
              //     itemCount: patientData.length,
              //   ),
              // ),

              SizedBox(
                height: 30,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
