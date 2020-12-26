import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientController/Cards/Medicine/scheduleData.dart';
import 'package:weekday_selector/weekday_selector.dart';



IntAsDay(int day) {
  print('Received integer: $day. Corresponds to day: ${intDayToEnglish(day)}');
}

String intDayToEnglish(int day) {
  if (day % 7 == DateTime.monday % 7) return 'Monday';
  if (day % 7 == DateTime.tuesday % 7) return 'Tuesday';
  if (day % 7 == DateTime.wednesday % 7) return 'Wednesday';
  if (day % 7 == DateTime.thursday % 7) return 'Thursday';
  if (day % 7 == DateTime.friday % 7) return 'Friday';
  if (day % 7 == DateTime.saturday % 7) return 'Saturday';
  if (day % 7 == DateTime.sunday % 7) return 'Sunday';
  throw '🐞 This should never have happened: $day';
}

class SelectedDaysUpdateExample extends StatefulWidget {
  @override
  _SelectedDaysUpdateExampleState createState() =>
      _SelectedDaysUpdateExampleState();
}

class _SelectedDaysUpdateExampleState extends State<SelectedDaysUpdateExample> {
  final values = List.filled(7, false);

  @override
  Widget build(BuildContext context) {
    print(valuesToEnglishDays(values, true));
    daysList = valuesToEnglishDays(values, true);
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: <Widget>[
        Text(
            'The days that are currently selected are: ${valuesToEnglishDays(values, true)}.'),
        WeekdaySelector(
          selectedFillColor: Color(0xffbb86fe),
          color: Color(0xfff2e7fe),
          fillColor: Color(0xff292929),
          selectedColor: Color(0xff121212),
          onChanged: (v) {
            setState(() {
              values[v % 7] = !values[v % 7];
            });
          },
          selectedElevation: 15,
          elevation: 5,
          values: values,
        ),
      ],
    );
  }
}



String valuesToEnglishDays(List<bool> values, bool searchedValue) {
  final days = <String>[];
  for (int i = 0; i < values.length; i++) {
    final v = values[i];
    // Use v == true, as the value could be null, as well (disabled days).
    if (v == searchedValue) days.add(intDayToEnglish(i));
  }
  if (days.isEmpty) return 'Sunday,Monday,Tuesday,Wednesday,Thursday,Friday,Saturday';
  return days.join(',');
}


final x = DateTime.monday;

const valuesSundayTuesdayThursday = <bool>[
  true,
  false,
  true,
  false,
  true,
  false,
  false,
];

const valuesSaturdaySunday = <bool>[
  // Sunday
  true,
  // Monday-Friday
  false,
  false,
  false,
  false,
  false,
  // Saturday
  true,
];










final monday = DateTime.monday;