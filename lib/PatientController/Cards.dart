import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientController/PatientDetails/PatientDetails.dart';
import 'package:medicine_reminder/PatientController/customCard.dart';

class Cards extends StatelessWidget {
  final double appBarHeight = 50.0;
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                showModalBottomSheet(
                  context: context,
                  backgroundColor: Colors.transparent,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(15.0)),
                  builder: (context) {
                    return Container(
                        margin: EdgeInsets.all(1.0),
                        // height: (MediaQuery.of(context).size.height)*.85,
                        decoration: BoxDecoration(
                          border:
                              Border.all(color: Color(0xffBB86FC), width: 1),
                          color: Color(0xff121212),
                          borderRadius: BorderRadius.circular(15.0),
                        ),
                        child: Wrap(
                          children: [
                             Stack(
                                alignment: Alignment.center,
                                children: [
                                  CustomPaint(
                                    child: Container(
                                      child: Center(
                                        child: Column(
                                          mainAxisAlignment: MainAxisAlignment.end,
                                          children: [],
                                        ),
                                      ),
                                      height: (MediaQuery.of(context).size.height)*.57,
                                      width: MediaQuery.of(context).size.width,
                                    ),
                                  ),
                                  Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                   // crossAxisAlignment: CrossAxisAlignment.center,
                                    children: [
                                      Container(
                                      width: MediaQuery.of(context).size.width / 4,
                                      height: MediaQuery.of(context).size.width / 4,
                                      padding: EdgeInsets.all(10.0),
                                      decoration: BoxDecoration(
                                      border: Border.all(color: Color(0xffbb86fe), width: 1),
                                      shape: BoxShape.circle,
                                      color: Colors.grey[800],
                                    /*  image: DecorationImage(
                                      fit: BoxFit.cover,
                                        image: AssetImage('images/man.jpg'),
                                    ), */
                                    ),
                                    ),
                                      SizedBox(height: 24,),

                                      Container(
                                        width: (MediaQuery.of(context).size.width)*.9,
                                        child: TextField(
                                          //controller: emailController,
                                          style: TextStyle(color: Color(0xfff2e7fe)),
                                          decoration: InputDecoration(
                                              labelText: 'UserName',
                                              prefixIcon: Icon(
                                                Icons.person,
                                                color: Color(0xffF2E7FE),
                                              ),
                                              labelStyle: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xffF2E7FE),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              filled: true,
                                              fillColor: Color(0xff121212),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xfff2e7fe)), ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xffBB86fc)),
                                                //  when the TextFormField in focused
                                              ) ,
                                              border: UnderlineInputBorder(
                                              )
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16,),
                                      Container(
                                        width: (MediaQuery.of(context).size.width)*.9,
                                        child: TextField(
                                          //controller: emailController,
                                          style: TextStyle(color: Color(0xfff2e7fe)),
                                          decoration: InputDecoration(
                                              labelText: 'Age',
                                              prefixIcon: Icon(
                                                Icons.calendar_view_day,
                                                color: Color(0xffF2E7FE),
                                              ),
                                              labelStyle: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xffF2E7FE),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              filled: true,
                                              fillColor: Color(0xff121212),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xfff2e7fe)), ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xffBB86fc)),
                                                //  when the TextFormField in focused
                                              ) ,
                                              border: UnderlineInputBorder(
                                              )
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 16,),
                                      Container(

                                        width: (MediaQuery.of(context).size.width)*.9,
                                        child: TextField(
                                         // controller: emailController,
                                          style: TextStyle(color: Color(0xfff2e7fe)),
                                          decoration: InputDecoration(
                                              labelText: 'Contact',
                                              prefixIcon: Icon(
                                                Icons.phone,
                                                color: Color(0xffF2E7FE),
                                              ),
                                              labelStyle: TextStyle(
                                                fontSize: 16,
                                                color: Color(0xffF2E7FE),
                                                fontWeight: FontWeight.bold,
                                              ),
                                              filled: true,
                                              fillColor: Color(0xff121212),
                                              contentPadding: EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                                              enabledBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xfff2e7fe)), ),
                                              focusedBorder: UnderlineInputBorder(
                                                borderSide: BorderSide(color: Color(0xffBB86fc)),
                                                //  when the TextFormField in focused
                                              ) ,
                                              border: UnderlineInputBorder(
                                              )
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 36,),
                                      Container(
                                        height: 40,
                                        width: (MediaQuery.of(context).size.width)*.8,
                                        decoration: BoxDecoration(
                                          color: Color(0xff292929),
                                          borderRadius: BorderRadius.all(
                                            Radius.circular(25),
                                          ),
                                          border: Border.all(
                                              color: Color(0xffBB86FC),
                                              width: 1
                                          ),
                                          boxShadow: [
                                            BoxShadow(
                                              color: Color(0xffF292929).withOpacity(0.2),
                                              spreadRadius: 3,
                                              blurRadius: 4,
                                              offset: Offset(0, 3),
                                            ),
                                          ],
                                        ),
                                        child: Center(
                                          child: Text(
                                            "Confirm",
                                            style: TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                              color: Color(0xffF2E7FE),
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),


                    ],),);
                  },
                  isScrollControlled: true,
                );
              },
              child: Container(
                  height: 175.0,
                  width: MediaQuery.of(context).size.width,
                  child: customCard(Icons.person, "Details", "Patient Bio")),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Column(
              children: <Widget>[
                InkWell(
                  child: Container(
                      height: ((MediaQuery.of(context).size.height) -
                              appBarHeight -
                              175.0) *
                          .35,
                      width: (MediaQuery.of(context).size.width) * .5,
                      child: customCard(
                          Icons.description, "Pills", "Dosage Details")),
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => ScheduleCell()));
                  },
                  child: Container(
                      height: ((MediaQuery.of(context).size.height) -
                              appBarHeight -
                              175.0) *
                          .45,
                      width: (MediaQuery.of(context).size.width) * .5,
                      child: customCard(
                        Icons.calendar_today,
                        "Schedule",
                        "Days and Range",
                      )),
                )
              ],
            ),
            Column(
              children: <Widget>[
                Container(
                    height: ((MediaQuery.of(context).size.height) -
                            appBarHeight -
                            175.0) *
                        .45,
                    width: (MediaQuery.of(context).size.width) * .5,
                    child: customCard(
                        Icons.alarm_add, "Time", "Intervals and Timings")),
                Container(
                    height: ((MediaQuery.of(context).size.height) -
                            appBarHeight -
                            175.0) *
                        .35,
                    width: (MediaQuery.of(context).size.width) * .5,
                    child: customCard(Icons.assignment, "Log", "Records")),
              ],
            )
          ],
        )
      ],
    );

  }
}



