import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/UI/Medicine_Details.dart';

class FromMedicineList extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        backgroundColor: Color(0xff292929),
        iconTheme: IconThemeData(
          color: Color(0xFFbb86fe),
        ),
        centerTitle: true,
        title: Text(
          "Reminder Details",
          style: TextStyle(
            fontFamily: 'Circular',
            fontSize: 18,
            color: Color(0xffF2E7FE),
            fontWeight: FontWeight.bold,
          ),
        ),
        elevation: 5.0,
      ),
      body: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width) * .05, vertical: (MediaQuery.of(context).size.width) * .05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: <Widget>[
                        Card(
                          color: Colors.white,
                          elevation: 20.0,
                          child: Container(
                            width: (MediaQuery.of(context).size.width)*.4,
                            color: Colors.white,
                          ),
                        ),
                        SizedBox(
                          width: 15,
                        ),
                        Column(
                          children: <Widget>[
                            Hero(
                              tag: "1",
                              child: Material(
                                color: Colors.transparent,
                                child: MainInfoTab(
                                  fieldTitle: "Medicine Name",
                                  fieldInfo: "Panadol",
                                ),
                              ),
                            ),
                            MainInfoTab(
                              fieldTitle: "Dosage",
                              fieldInfo: 5 == 0
                                  ? "Not Specified"
                                  : 5.toString() + " mg",
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 45,
                  ),
                  Container(
                    child: ListView(
                      shrinkWrap: true,
                      children: <Widget>[
                        ExtendedInfoTab(
                          fieldTitle: "Medicine Type",
                          fieldInfo: "Test Type" == "None"
                              ? "Not Specified"
                              : "Test Type",
                        ),
                        Container(
                          child: Row(
                            //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "Time Intervals",
                                      style: TextStyle(
                                        fontFamily: 'Circular',
                                        fontSize: 16,
                                        color: Color(0xffbb86fe),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              SizedBox(width: (MediaQuery.of(context).size.width)*.25,),
                              Column(
                                children: [
                                  Padding(
                                    padding: EdgeInsets.only(bottom: 8.0),
                                    child: Text(
                                      "Schedule Type",
                                      style: TextStyle(
                                        fontFamily: 'Circular',
                                        fontSize: 16,
                                        color: Color(0xffbb86fe),
                                        fontWeight: FontWeight.w700,
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        )
                      ],
                    ),
                  )
                ],
              ),
            ),

          ),
        ],
      ),
    );
  }
}
