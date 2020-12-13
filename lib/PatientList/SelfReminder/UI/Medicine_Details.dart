import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Global_Bloc.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Models/Medicine.dart';
import 'package:provider/provider.dart';


class MedicineDetails extends StatelessWidget {
  final Medicine medicine;

  MedicineDetails(this.medicine);

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        backgroundColor: Color(0xff292929),
        iconTheme: IconThemeData(
          color: Color(0xFFbb86fe),
        ),
        centerTitle: true,
        title: Text("Reminder Details",
          //AppLocalizations.of(context).translate('Reminder Details'),
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
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: (MediaQuery.of(context).size.width) * .05, vertical: (MediaQuery.of(context).size.width) * .05),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: <Widget>[
                  MainSection(medicine: medicine),
                  SizedBox(
                    height: 15,
                  ),
                  ExtendedSection(medicine: medicine),
                  Padding(
                    padding: EdgeInsets.only(
                      left: MediaQuery.of(context).size.height * 0.06,
                      right: MediaQuery.of(context).size.height * 0.06,
                      top: 25,
                    ),
                    child: InkWell(
                      onTap: () {
                        openAlertBox(context, _globalBloc);
                      },
                      child: Container(
                        height: (MediaQuery.of(context).size.width) * .2,
                        width: (MediaQuery.of(context).size.width) * .8,
                        decoration: BoxDecoration(
                          color: Color(0xff121212),
                          borderRadius: BorderRadius.all(
                            Radius.circular(25),
                          ),
                          border: Border.all(
                              color: Color(0xffBB86FC), width: 1),
                          boxShadow: [
                            BoxShadow(
                              color:
                              Color(0xffF292929).withOpacity(0.2),
                              spreadRadius: 3,
                              blurRadius: 4,
                              offset: Offset(0, 3),
                            ),
                          ],
                        ),
                        child: Center(
                          child: Text( "Delete",
                           // AppLocalizations.of(context).translate('Delete'),
                            style: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Circular',
                              fontWeight: FontWeight.bold,
                              color: Color(0xffF2E7FE),
                            ),
                          ),
                        ),
                      ),
                    ),
                    ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  openAlertBox(BuildContext context, GlobalBloc _globalBloc) {
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            backgroundColor: Color(0xff292929),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(30.0),
              ),
            ),
            contentPadding: EdgeInsets.only(top: 10.0),
            content: Container(
              width: (MediaQuery.of(context).size.width)*.5,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                mainAxisSize: MainAxisSize.min,
                children: <Widget>[
                  Padding(
                    padding: EdgeInsets.all(18),
                    child: Center(
                      child: Text(
                        "Delete this Reminder?",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Circular',
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF2E7FE),
                        ),
                      ),
                    ),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: <Widget>[
                      GestureDetector(
                        onTap: () {
                          _globalBloc.removeMedicine(medicine);

                          Navigator.popUntil(
                            context,
                            ModalRoute.withName('/'),

                          );
                        },
                        child: InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.743,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Color(0xFF292929),
                              borderRadius: BorderRadius.only(
                                bottomLeft: Radius.circular(30.0),
                              ),
                            ),
                            child: Text(
                              "Yes",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Circular',
                                fontWeight: FontWeight.bold,
                                color: Color(0xffbb86fe),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.of(context).pop();
                        },
                        child: InkWell(
                          child: Container(
                            width: MediaQuery.of(context).size.width / 2.743,
                            padding: EdgeInsets.only(top: 15.0, bottom: 15.0),
                            decoration: BoxDecoration(
                              color: Color(0xff292929),
                              borderRadius: BorderRadius.only(
                                  bottomRight: Radius.circular(30.0)),
                            ),
                            child: Text(
                              "No",
                              style: TextStyle(
                                fontSize: 18,
                                fontFamily: 'Circular',
                                fontWeight: FontWeight.bold,
                                color: Color(0xffbb86fe),
                              ),
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
          );
        });
  }
}
// _globalBloc.removeMedicine(medicine);
//                       Navigator.of(context).pop()

class MainSection extends StatelessWidget {
  final Medicine medicine;

  MainSection({
    Key key,
    @required this.medicine,
  }) : super(key: key);

  Hero makeIcon(double size) {
    if (medicine.medicineType == "Bottle") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe900, fontFamily: "Ic"),
          color: Color(0xFFbb86fe),
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Pill") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe901, fontFamily: "Ic"),
          color: Color(0xFFbb86fe),
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Syringe") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe902, fontFamily: "Ic"),
          color: Color(0xFFbb86fe),
          size: size,
        ),
      );
    } else if (medicine.medicineType == "Tablet") {
      return Hero(
        tag: medicine.medicineName + medicine.medicineType,
        child: Icon(
          IconData(0xe903, fontFamily: "Ic"),
          color: Color(0xFFbb86fe),
          size: size,
        ),
      );
    }
    return Hero(
      tag: medicine.medicineName + medicine.medicineType,
      child: Icon(
        Icons.local_hospital,
        color: Color(0xFFbb86fe),
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(
        children: <Widget>[
          makeIcon(175),
          SizedBox(
            width: 15,
          ),
          Column(
            children: <Widget>[
              Hero(
                tag: medicine.medicineName,
                child: Material(
                  color: Colors.transparent,
                  child: MainInfoTab(
                    fieldTitle: AppLocalizations.of(context).translate('Medicine_Name'),
                    fieldInfo: medicine.medicineName,
                  ),
                ),
              ),
              MainInfoTab(
                fieldTitle: AppLocalizations.of(context).translate('Dosage'),
                fieldInfo: medicine.dosage == 0
                    ? "Not Specified"
                    : medicine.dosage.toString() + " mg",
              )
            ],
          )
        ],
      ),
    );
  }
}

class MainInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;

  MainInfoTab({Key key, @required this.fieldTitle, @required this.fieldInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.35,
      height: 100,
      child: ListView(
        padding: EdgeInsets.only(top: 15),
        shrinkWrap: true,
        children: <Widget>[
          Text(
            fieldTitle,
            style: TextStyle(
              fontFamily: 'Circular',
              fontSize: 16,
              color: Color(0xffbb86fe),
              fontWeight: FontWeight.w600,
            ),
          ),
          Text(
            fieldInfo,
            style: TextStyle(
              fontFamily: 'Circular',
              fontSize: 20,
              color: Color(0xffF2E7FE),
              fontWeight: FontWeight.w700,
            ),
          ),
        ],
      ),
    );
  }
}

class ExtendedSection extends StatelessWidget {
  final Medicine medicine;

  ExtendedSection({Key key, @required this.medicine}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView(
        shrinkWrap: true,
        children: <Widget>[
          ExtendedInfoTab(
            fieldTitle: AppLocalizations.of(context).translate('Type'),
            fieldInfo: medicine.medicineType == "None"
                ? "Not Specified"
                : medicine.medicineType,
          ),
          ExtendedInfoTab(
            fieldTitle: "Dosage Interval",
            //AppLocalizations.of(context).translate('Dosage Interval'),
            fieldInfo: "Every " +
                medicine.interval.toString() +
                " hours  | " +
                " ${medicine.interval == 24 ? "One time a day" : (24 / medicine.interval).floor().toString() + " times a day"}",
          ),
          ExtendedInfoTab(
              fieldTitle: AppLocalizations.of(context).translate('Starting Time'),
              fieldInfo: medicine.startTime[0] +
                  medicine.startTime[1] +
                  ":" +
                  medicine.startTime[2] +
                  medicine.startTime[3]),
        ],
      ),
    );
  }
}

class ExtendedInfoTab extends StatelessWidget {
  final String fieldTitle;
  final String fieldInfo;

  ExtendedInfoTab(
      {Key key, @required this.fieldTitle, @required this.fieldInfo})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: 18.0),
      child: Container(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            Padding(
              padding: EdgeInsets.only(bottom: 8.0),
              child: Text(
                fieldTitle,
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 16,
                  color: Color(0xffbb86fe),
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
            Text(
              fieldInfo,
              style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 16,
                color: Color(0xffF2E7FE),
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}