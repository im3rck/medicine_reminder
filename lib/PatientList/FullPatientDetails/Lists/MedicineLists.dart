import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientController/Cards/customCard.dart';
import 'package:medicine_reminder/PatientController/MedicineList/MedicineList.dart';

class MedicineList extends StatefulWidget {
  @override
  _PatientInfoState createState() => _PatientInfoState();
}

class _PatientInfoState extends State<MedicineList> {
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
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: _buildAppBar(),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          SizedBox(
            height: 50.0,
          ),
          Center(
            child: Container(
              height: (MediaQuery.of(context).size.height) * .6,
              width: (MediaQuery.of(context).size.width) * .9,
              child: Card(
                color: Color(0xff292929),
                elevation: 20.0,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10.0)),
                margin: EdgeInsets.all(7.0),
                child: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff292929),
                    //border: Border.all(color: Color(0xffbb86fe), width: 1),
                    borderRadius: BorderRadius.circular(10.0),
                    boxShadow: [
                      BoxShadow(
                        color: Color(0xff121212).withOpacity(0.2),
                        spreadRadius: 3,
                        blurRadius: 4,
                        offset: Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      InkWell(
                        onTap: () {
                          _medicineList();
                        },
                        child: Container(
                            height: (MediaQuery.of(context).size.height)*.28,
                            width: (MediaQuery.of(context).size.width) * .8,
                            child: customCard(Icons.assignment, "Medicine", "List")),
                      ),
                      InkWell(
                        onTap: () {
                          _medicineList();
                        },
                        child: Container(
                            height: (MediaQuery.of(context).size.height)*.28,
                            width: (MediaQuery.of(context).size.width) * .8,
                            child: customCard(Icons.assignment, "Schedule", "List")),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )
    );
  }
  Widget _buildAppBar() {
    Color appBarIconsColor = Color(0xFF292929);
    return AppBar(
      shadowColor: Color(0xff292929),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Color(0xffBB86Fe)),
        onPressed: (){
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Icon(Icons.more_horiz, color: Color(0xffBB86Fe), size: 28),
        )
      ],
      brightness: Brightness.light,
      backgroundColor: Color(0xFF292929),
      elevation: 10.0,
      title: Container(
        width: double.infinity,
        alignment: Alignment.center,

        child:

        Text(
          'Medicine Lists', textAlign: TextAlign.center,
          style:
          TextStyle(
            fontFamily: 'Circular',
            fontSize: 20,
            letterSpacing: 0.5,
            color: Color(0xffbb86fe),
            fontWeight: FontWeight.bold,
          ),),

      ),
    );
  }
}
