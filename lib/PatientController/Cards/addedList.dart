import 'package:flutter/material.dart';
import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';
import 'package:medicine_reminder/PatientController/MedicineList/MedicineList.dart';
import 'package:flutter/cupertino.dart';

import 'package:medicine_reminder/PatientController/Cards/customCard.dart';

class AddedList extends StatefulWidget {
  _AddedList createState() => _AddedList();
}

class _AddedList extends State<AddedList> {

  void _scheduleList() {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      builder: (context) {
        return Container(
            padding: EdgeInsets.all(20.0),
            // height: (MediaQuery.of(context).size.height) * .80,
            decoration: BoxDecoration(
              border: Border.all(color: Color(0xffBB86FC), width: 1),
              color: Color(0xff292929),
              borderRadius: BorderRadius.circular(15.0),
            ),
            child: PatientScheduleList());
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        // InkWell(
        //   onTap: () {
        //     _medicineList();
        //   },
        //   child: Container(
        //       height: (MediaQuery.of(context).size.height)*.25,
        //       width: (MediaQuery.of(context).size.width) * .5,
        //       child: customCard(Icons.assignment, AppLocalizations.of(context).translate('Medicine'), AppLocalizations.of(context).translate('List'))),
        // ),
        InkWell(
          onTap: () {
            _scheduleList();
          },
          child: Container(
              height: (MediaQuery.of(context).size.height)*.25,
              width: (MediaQuery.of(context).size.width),
              child: customCard(Icons.assignment, AppLocalizations.of(context).translate('Schedule'), AppLocalizations.of(context).translate('List'))),
        ),
      ],
    );
  }
}
