import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientController/Cards/details.dart';
import 'package:medicine_reminder/PatientController/Cards/medicine.dart';
import 'package:medicine_reminder/PatientController/Connection/Connection.dart';
import 'package:medicine_reminder/PatientController/MedicineList/MedicineList.dart';
import 'package:medicine_reminder/PatientController/Cards/customCard.dart';

double yOffset = 0;
String _selected = '';
List<String> intervalItems = [];
List<String> scheduleItems = [];

// ignore: must_be_immutable
class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

Future navigateToSubPage(context) async {
  Navigator.push(
      context, MaterialPageRoute(builder: (context) => Connection()));
}

class _CardsState extends State<Cards> {
  final double appBarHeight = 55.0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.topRight,
      children: [
        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(height: 14.0),
            Details(),
            Medicines(),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                InkWell(
                  onTap: () {
                    _medicineList();
                  },
                  child: Container(
                      height: 185.0,
                      width: (MediaQuery.of(context).size.width) * .5,
                      child: customCard(Icons.assignment, "Medicine", "List")),
                ),
                InkWell(
                  onTap: () {
                    _medicineList();
                  },
                  child: Container(
                      height: 185.0,
                      width: (MediaQuery.of(context).size.width) * .5,
                      child: customCard(Icons.assignment, "Schedule", "List")),
                ),
              ],
            ),
            SizedBox(
              width: 20,
              height: 10,
            ),
            Container(
              height: 50,
              width: (MediaQuery.of(context).size.width) * .8,
              decoration: BoxDecoration(
                color: Color(0xff121212),
                borderRadius: BorderRadius.all(
                  Radius.circular(25),
                ),
                border: Border.all(color: Color(0xffBB86FC), width: 1),
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
                    fontFamily: 'Circular',
                    fontSize: 16,
                    color: Color(0xffF2E7FE),
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ],
        ),
      ],
    );
  }

  void _medicineList() {
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
            child: PatientMedicineList());
      },
    );
  }
}

class MedicineType extends StatefulWidget {
  @override
  _MedicineTypeState createState() => _MedicineTypeState();
}

class _MedicineTypeState extends State<MedicineType> {
  List<String> _type = ['Pill', 'Bottle', 'Syringe', 'Tablet'];
  String _selectedType = '0';

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Container(
              child: Text(
                "Medicine Type:  ",
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 16,
                  color: Color(0xffF2E7FE).withOpacity(0.6),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            DropdownButton(
              iconEnabledColor: Color(0xFF3EB16F),
              dropdownColor: Color(0xff292929),
              hint: _selectedType == '0'
                  ? Text(
                      "Type",
                      style: TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 16,
                        color: Color(0xffF2E7FE),
                        fontWeight: FontWeight.bold,
                      ),
                    )
                  : null,
              elevation: 4,
              value: _selectedType == '0' ? null : _selectedType,
              items: _type.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value,
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 16,
                      color: Color(0xffF2E7FE),
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _selectedType = newVal;
                  _selected = newVal;
                });
              },
            ),
          ],
        ),
      ),
    );
  }
}

String convertTime(String minutes) {
  if (minutes.length == 1) {
    return "0" + minutes;
  } else {
    return minutes;
  }
}
