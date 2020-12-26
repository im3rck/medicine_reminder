import 'dart:math';
import 'package:auto_size_text/auto_size_text.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_icons/flutter_icons.dart';
import 'package:intl/intl.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';
import 'package:medicine_reminder/PatientList/FullPatientDetails/FullPatientDetails.dart';
import 'package:medicine_reminder/PatientList/datafile.dart';
import 'package:medicine_reminder/Enhancements/FadeAnimation/FadeAnimation.dart';
String imageUrl;

class HomeScreen extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  double xOffset = 230;
  double yOffset = 130;
  double scaleFactor = 0.6;
  bool isDrawerOpen = true;

  bool searched = false;
  bool found = false;
 // String searchText;
 // TextEditingController searchController = TextEditingController();

  Column buildColumn(List<Map> list) {
    return Column(
        mainAxisSize: MainAxisSize.max,
        children: list
            .map((element) => Padding(
                  padding: const EdgeInsets.all(12.0),
                  child: GestureDetector(
                    onTap: () {
                      (isDrawerOpen)
                          ? setState(() {
                              xOffset = 0;
                              yOffset = 0;
                              scaleFactor = 1;
                              isDrawerOpen = false;
                            })
                          : Navigator.of(context).push(FadeRoute(
                          builder: (context) => BottomNavBar(element['contactNo'])
                      ));
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
                                    borderRadius: BorderRadius.circular(20),
                                    border: Border.all(
                                        color: Color(0xffBB86Fe), width: 1),
                                    //  boxShadow: shadowList,
                                  ),
                                ),
                                Align(
                                  child: Hero(
                                    tag: element['index'] == null
                                        ? ''
                                        : element['index'],
                                    child: imageUrl == null
                                        ? Image.asset(
                                            'assets/images/usertrans.png')
                                        : Image.network(imageUrl),
                                  ),
                                )
                              ],
                            ),
                          ),
                          Flexible(
                              child: Container(
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  child: AutoSizeText(
                                    element['name'] == null
                                        ? ''
                                        : element['name'],
                                    maxLines: 1,
                                    style: new TextStyle(
                                        color: Color(0xfff2e7fe),
                                        fontFamily: 'Circular',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 24),
                                  ),
                                ),
                                Divider(
                                  color: Color(0xffbb86fe),
                                  thickness: 1.0,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      margin: EdgeInsets.fromLTRB(10, 0, 0, 10),
                                      child: Text(
                                        (element['age']).toString() + 'Years',
                                        style: new TextStyle(
                                            color: Color(0xfff2e7fe),
                                            fontFamily: 'Circular',
                                            fontWeight: FontWeight.bold,
                                            fontSize: 15.0),
                                      ),
                                    ),
                                    Container(
                                      height: (MediaQuery.of(context).size.height)*.04,
                                        margin:
                                            EdgeInsets.fromLTRB(10, 0, 10, 10),
                                        child: ((element['gender'] == null
                                                    ? ''
                                                    : element['gender']) ==
                                                'Male'
                                            ? SvgPicture.asset(
                                                'assets/images/male.svg',
                                                height: 25.0,
                                                width: 25.0,
                                                allowDrawingOutsideViewBox:
                                                    true,
                                              )
                                            : (element['gender'] == null
                                                        ? ''
                                                        : element['gender']) ==
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
                                  margin: EdgeInsets.fromLTRB(10, 10, 20, 10),
                                  alignment: Alignment.centerLeft,
                                  child: Text(
                                    element['rel'] == null
                                        ? ''
                                        : element['rel'],
                                    style: new TextStyle(
                                        color: Color(0xfff2e7fe),
                                        fontFamily: 'Circular',
                                        fontWeight: FontWeight.bold,
                                        fontSize: 15.0),
                                  ),
                                ),
                              ],
                            ),
                            margin: EdgeInsets.only(top: 20, bottom: 20),
                            decoration: BoxDecoration(
                              color: Color(0xff292929),
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
            .toList());
  }

  void searchPatients(String searchText) {
    List names = Patientdata.map((items) => items['name']).toList();
    String searchedName = searchText;
    int i = 0;
    for (String key in names) {
      if ((searchedName.toLowerCase()).compareTo(key.toLowerCase()) == 0) {
        Map map = {
          'index': Patientdata[i]['index'],
          'name': Patientdata[i]['name'],
          'age': Patientdata[i]['age'],
          'gender': Patientdata[i]['gender'],
          'rel': Patientdata[i]['rel'],
        };
        Search.add(map);
        setState(() {
          found = true;
        });
      }
      i++;
    }
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
                            icon: Transform.rotate(
                              angle: pi / 2,
                              child: Icon(
                                Feather.bar_chart_2,
                                color: Color(0xffbb86fe),
                                size: 30,
                              ),
                            ),
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
                  color: (isDrawerOpen ? Colors.grey[800] : Color(0xFF292929)),
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
                    // IconButton(
                    //   icon: Icon(
                    //     Icons.settings,
                    //     color: (isDrawerOpen
                    //         ? Color(0xff292929)
                    //         : Color(0xFFf2e7fe).withOpacity(0)),
                    //   ),
                    //   onPressed: () {
                    //   //   Navigator.push(
                    //   //       context, MaterialPageRoute(builder: (context) => SettingsPage()));
                    //   // },
                    // ),
                    // SizedBox(width: 5),
                    Center(
                      child: SizedBox(
                        width: 100,
                        child: TextField(
                          style: TextStyle(
                              color: Color(0xffffffff),
                              fontFamily: 'Circular',
                              fontWeight: FontWeight.bold,
                              fontSize: 15.0),
                          onChanged: (String val) {
                            setState(() {
                              found = false;
                            });
                            if (val == '')
                              setState(() {
                                searched = false;
                                found = false;
                              });
                            Search.clear();
                          },
                          onSubmitted: (value){
                            setState(() {
                              searched = true;
                            });
                            searchPatients(value);
                          },
                          //controller: searchController,
                          textAlign: TextAlign.center,
                          decoration: InputDecoration(
                              hintText: 'Search'+ "...",
                              hintStyle: TextStyle(
                                  color: Color(0xfff2e7fe).withOpacity(0.8),
                                  fontFamily: 'Circular',
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16.0),
                              border: InputBorder.none),
                        ),
                      ),
                    ),
                    IconButton(
                      icon: Icon(Icons.search, color: Color(0xfff2e7fe)),
                      onPressed: () {
                        // setState(() {
                        //   searched = true;
                        // });
                        //searchPatients();
                      },
                    ),
                  ],
                ),
              ),
              // searched ? showEmpty : buildColumn(testData),

              searched
                  ? (found
                      ? buildColumn(Search)
                      : Text('No data Found !',
                          style: TextStyle(
                              fontFamily: 'Circular',
                              fontSize: 20,
                              color: Colors.white,
                              fontWeight: FontWeight.bold)))
                  : buildColumn(Patientdata),

              // Column(
              //     mainAxisSize: MainAxisSize.max,
              //     children: testData
              //         .map((element) =>
              //         Padding(
              //           padding: const EdgeInsets.all(12.0),
              //           child: GestureDetector(
              //             onTap: () {
              //               if (isDrawerOpen) {
              //                 setState(() {
              //                   xOffset = 0;
              //                   yOffset = 0;
              //                   scaleFactor = 1;
              //                   isDrawerOpen = false;
              //                 });
              //               } else {
              //                 Navigator.push(
              //                     context,
              //                     MaterialPageRoute(
              //                         builder: (context) =>
              //                             BottomNavBar(element['contactNo'])));
              //               }
              //             },
              //             child: Container(
              //               height: 200,
              //               margin: EdgeInsets.fromLTRB(20, 0, 20, 20),
              //               child: Row(
              //                 children: [
              //                   Expanded(
              //                     child: Stack(
              //                       children: [
              //                         Container(
              //                           decoration: BoxDecoration(
              //                             color: Color(0xff292929),
              //                             borderRadius:
              //                             BorderRadius.circular(20),
              //                             border: Border.all(
              //                                 color: Color(0xffBB86Fe),
              //                                 width: 1),
              //                             //  boxShadow: shadowList,
              //                           ),
              //                         ),
              //                         Align(
              //                           child: Hero(
              //                             tag: element['index'],
              //                             child: imageUrl == null
              //                                 ? Image.asset(
              //                                 'assets/images/usertrans.png')
              //                                 : Image.network(imageUrl),
              //                           ),
              //                         )
              //                       ],
              //                     ),
              //                   ),
              //                   Flexible(
              //                       child: Container(
              //                         child: Column(
              //                           children: [
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(
              //                                   10, 10, 20, 10),
              //                               child: AutoSizeText(
              //                                 element['name'],
              //                                 maxLines: 1,
              //                                 style: new TextStyle(
              //                                     color: Color(0xfff2e7fe),
              //                                     fontFamily: 'Circular',
              //                                     fontWeight: FontWeight.bold,
              //                                     fontSize: 24),
              //                               ),
              //                             ),
              //                             Divider(
              //                               color: Color(0xffbb86fe),
              //                               thickness: 1.0,
              //                             ),
              //                             Row(
              //                               mainAxisAlignment:
              //                               MainAxisAlignment.spaceBetween,
              //                               children: [
              //                                 Container(
              //                                   margin: EdgeInsets.fromLTRB(
              //                                       10, 0, 0, 10),
              //                                   child: Text(
              //                                     (element['age']).toString() +
              //                                         " years",
              //                                     style: new TextStyle(
              //                                         color: Color(0xfff2e7fe),
              //                                         fontFamily: 'Circular',
              //                                         fontWeight:
              //                                         FontWeight.bold,
              //                                         fontSize: 15.0),
              //                                   ),
              //                                 ),
              //                                 Container(
              //                                     margin: EdgeInsets.fromLTRB(
              //                                         10, 0, 10, 10),
              //                                     child: (element['gender'] ==
              //                                         'Male'
              //                                         ? SvgPicture.asset(
              //                                       'assets/images/male.svg',
              //                                       height: 25.0,
              //                                       width: 25.0,
              //                                       allowDrawingOutsideViewBox:
              //                                       true,
              //                                     )
              //                                         : element['gender'] ==
              //                                         'Female'
              //                                         ? SvgPicture.asset(
              //                                       'assets/images/female.svg',
              //                                       height: 25.0,
              //                                       width: 25.0,
              //                                       allowDrawingOutsideViewBox:
              //                                       true,
              //                                     )
              //                                         : SvgPicture.asset(
              //                                       'assets/images/other.svg',
              //                                       height: 25.0,
              //                                       width: 25.0,
              //                                       allowDrawingOutsideViewBox:
              //                                       true,
              //                                     )))
              //                               ],
              //                             ),
              //                             Container(
              //                               margin: EdgeInsets.fromLTRB(
              //                                   10, 10, 20, 10),
              //                               alignment: Alignment.centerLeft,
              //                               child: Text(
              //                                 element['rel'],
              //                                 style: new TextStyle(
              //                                     color: Color(0xfff2e7fe),
              //                                     fontFamily: 'Circular',
              //                                     fontWeight: FontWeight.bold,
              //                                     fontSize: 20.0),
              //                               ),
              //                             ),
              //                           ],
              //                         ),
              //                         margin:
              //                         EdgeInsets.only(top: 20, bottom: 20),
              //                         decoration: BoxDecoration(
              //                           color: Color(0xff292929),
              //                           // boxShadow: shadowList,
              //                           borderRadius: BorderRadius.only(
              //                               topRight: Radius.circular(20),
              //                               bottomRight: Radius.circular(20)),
              //                           border: Border.all(
              //                               color: (isDrawerOpen
              //                                   ? Color(0xff292929)
              //                                   : Color(0xFFbb86fe)),
              //                               width: (isDrawerOpen ? 2 : 1)),
              //                         ),
              //                       ))
              //                 ],
              //               ),
              //             ),
              //           ),
              //         ))
              //         .toList()),

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
