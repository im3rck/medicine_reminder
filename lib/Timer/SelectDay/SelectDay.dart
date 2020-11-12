import 'package:flutter/material.dart';

import 'package:medicine_reminder/Timer/SelectDay/SingleSelection.dart';
import 'package:medicine_reminder/Timer/SelectTime/SelectTime.dart';
import 'package:medicine_reminder/Timer/SelectTime/DayList.dart';
import 'package:medicine_reminder/Timer/SelectTime/constructor.dart';

class SelectDay extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  List<int> returnedIndices = [0, 1, 2, 3, 4, 5, 6];

  List<DayDetails> returnedDays = <DayDetails>[
    DayDetails(dayNumber: 1, dayName: 'MONDAY'),
    DayDetails(dayNumber: 2, dayName: 'TUESDAY'),
    DayDetails(dayNumber: 3, dayName: 'WEDNESDAY'),
    DayDetails(dayNumber: 4, dayName: 'THURSDAY'),
    DayDetails(dayNumber: 5, dayName: 'FRIDAY'),
    DayDetails(dayNumber: 6, dayName: 'SATURDAY'),
    DayDetails(dayNumber: 7, dayName: 'SUNDAY')
  ];

  Future navigateToSubPage(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => DayList(returnedDays)));
  }

  void getIndices(List<int> list) {
    setState(() {
      returnedIndices = list;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        backgroundColor: Color(0xff3196ae),
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Select Day",
          style: TextStyle(fontSize: 30),
        ),
        leading: GestureDetector(
          onTap: () {
            /* Write listener code here */
          },
          child: Icon(
            Icons.arrow_back_outlined, // add custom icons also
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.short_text,
              color: Colors.white,
              size: 30,
            ),
            onPressed: () {
              print(returnedIndices);
            },
          )
        ],
      ),
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 10,
                width: double.infinity,
                color: Color(0xff3196ae),
              ),
              Flexible(child: SingleSelection(updateIndices: getIndices)),
              Container(
                height: 10,
                width: double.infinity,
                color: Colors.white,
              ),
              // Flexible(child: DayList(returnedDays))
              Flexible(child: Timer(returnedIndices))
            ],
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigation),
        backgroundColor: Color(0xff3196ae),
        onPressed: () {
          navigateToSubPage(context);
        },
      ),
    );
  }
}
