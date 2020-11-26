import 'package:flutter/material.dart';

import 'package:medicine_reminder/Timer/SelectDay/SingleSelection.dart';
import 'package:medicine_reminder/Timer/SelectTime/DayList.dart';
import 'package:medicine_reminder/Timer/SelectTime/constructor.dart';

class SelectDay extends StatefulWidget {
  @override
  _SelectDayState createState() => _SelectDayState();
}

class _SelectDayState extends State<SelectDay> {
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
    print(returnedIndices);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Flexible(child: SingleSelection(updateIndices: getIndices)),
            ],
          ),
        ],
      ),
    );
  }
}
