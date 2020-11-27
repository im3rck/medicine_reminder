import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientList/datafile.dart';

import 'package:medicine_reminder/Timer/SelectDay/SingleSelection.dart';

class SelectDay extends StatefulWidget {
  @override
  _SelectDayState createState() => _SelectDayState();
}

class _SelectDayState extends State<SelectDay> {
  List<int> returnedIndices = [0, 1, 2, 3, 4, 5, 6];

  void getIndices(List<int> list) {
    setState(() {
      returnedIndices = list;
    });
  }

  void _setText() {
    Map map = {'days': returnedIndices};
    scheduleDays.add(map);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Flexible(child: SingleSelection(updateIndices: getIndices)),
          FloatingActionButton.extended(
            onPressed: () {
              Navigator.pop(context);
              _setText();
            },
            backgroundColor: Color(0xff292929),
            foregroundColor: Color(0xffbb86fe),
            label: Text(
              "Done",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Circular',
                fontWeight: FontWeight.bold,
                color: Color(0xffF2E7FE),
              ),
            ),
          )
        ],
    );
  }
}
