import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientList/datafile.dart';

import 'package:medicine_reminder/Timer/SelectDay/SingleSelection.dart';

import '../../ContentResizer.dart';
import '../../SizeConfig.dart';

class SelectDay extends StatefulWidget {
  final updateIndices;
  SelectDay({Key key, this.updateIndices}) : super(key: key);
  @override
  _SelectDayState createState() => _SelectDayState();
}

class _SelectDayState extends State<SelectDay> {
  List<int> returnedIndices = [0, 1, 2, 3, 4, 5, 6];

  void getIndices(List<int> list) {
    setState(() {
      returnedIndices = list;
    });
    Map map = {'days': returnedIndices};
    scheduleDays.add(map);
    print(scheduleDays);
  }

  void _setText() {
    Map map = {'days': returnedIndices};
    scheduleDays.add(map);
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(child: SingleSelection(updateIndices: getIndices)),
      ],
    );
  }
}
