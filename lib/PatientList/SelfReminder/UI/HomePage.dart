import 'package:flutter/material.dart';
import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Global_Bloc.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Models/Medicine.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/UI/Medicine_Details.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/UI/New_Entry/New_Entry.dart';
import 'package:provider/provider.dart';

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff292929),
        elevation: 0.0,
      ),
      body: Container(
        color: Color(0xFF121212),
        child: Column(
          children: <Widget>[
            Flexible(
              flex: 3,
              child: TopContainer(),
            ),
            SizedBox(
              height: 10,
            ),
            Flexible(
              flex: 7,
              child: Provider<GlobalBloc>.value(
                child: BottomContainer(),
                value: _globalBloc,
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        elevation: 10,
        backgroundColor: Color(0xFF292929),
        child: Icon(
          Icons.add,
          color: Color(0xffbb86fe),
        ),
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => NewEntry(),
            ),
          );
        },
      ),
    );
  }
}

class TopContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc globalBloc = Provider.of<GlobalBloc>(context);
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(
          bottomLeft: Radius.elliptical(50, 27),
          bottomRight: Radius.elliptical(50, 27),
        ),
        boxShadow: [
          BoxShadow(
            blurRadius: 5,
            color: Color(0xffbb86fe),
            offset: Offset(0, 3.5),
          )
        ],
        color: Color(0xFf292929),
      ),
      width: double.infinity,
      child: Column(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.only(
              bottom: 10,
            ),
            child: Text(
              AppLocalizations.of(context).translate('Self_Reminder'),
              style:  TextStyle(
                fontFamily: 'Circular',
                fontSize: 36,
                color: Color(0xffF2E7FE),
                fontWeight: FontWeight.w600,
              ),
            ),
          ),
          Divider(
            color: Color(0xFFBb86fe),
          ),
          Padding(
            padding: EdgeInsets.only(top: 12.0),
            child: Center(
              child: Text(
                AppLocalizations.of(context).translate('Number of Reminders'),
                style:  TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 16,
                  color: Color(0xffF2E7FE),
                ),
              ),
            ),
          ),
          StreamBuilder<List<Medicine>>(
            stream: globalBloc.medicineList$,
            builder: (context, snapshot) {
              return Padding(
                padding: EdgeInsets.only(top: 16.0, bottom: 5 ),
                child: Center(
                  child: Text(
                    !snapshot.hasData ? '0' : snapshot.data.length.toString(),
                    style:  TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 28,
                      color: Color(0xffF2E7FE),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }
}

class BottomContainer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);
    return StreamBuilder<List<Medicine>>(
      stream: _globalBloc.medicineList$,
      builder: (context, snapshot) {
        if (!snapshot.hasData) {
          return Container();
        } else if (snapshot.data.length == 0) {
          return Container(
            color: Color(0xFF121212),
            child: Center(
              child: Text(
                AppLocalizations.of(context).translate('infoText'),
                textAlign: TextAlign.center,
                style:  TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 20,
                  color: Color(0xffF2E7FE).withOpacity(0.5),
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          );
        } else {
          return Container(
            color: Color(0xFF121212),
            child: GridView.builder(
              padding: EdgeInsets.only(top: 12),
              gridDelegate:
              SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2),
              itemCount: snapshot.data.length,
              itemBuilder: (context, index) {
                return MedicineCard(snapshot.data[index]);
              },
            ),
          );
        }
      },
    );
  }
}

class MedicineCard extends StatelessWidget {
  final Medicine medicine;

  MedicineCard(this.medicine);

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
        Icons.error,
        color: Color(0xFF3EB16F),
        size: size,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.all(10.0),
      child: InkWell(
        highlightColor: Color(0xff121212),
        splashColor: Color(0xff121212),
        onTap: () {
          Navigator.of(context).push(
            PageRouteBuilder<Null>(
              pageBuilder: (BuildContext context, Animation<double> animation,
                  Animation<double> secondaryAnimation) {
                return AnimatedBuilder(
                    animation: animation,
                    builder: (BuildContext context, Widget child) {
                      return Opacity(
                        opacity: animation.value,
                        child: MedicineDetails(medicine),
                      );
                    });
              },
              transitionDuration: Duration(milliseconds: 500),
            ),
          );
        },
        child: Card(
          elevation: 10.0,
          color: Color(0xff121212),
          child: Container(
            decoration: BoxDecoration(
              color: Color(0xff292929),
              borderRadius: BorderRadius.circular(15),
            ),
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: <Widget>[
                  makeIcon(50.0),
                  Hero(
                    tag: medicine.medicineName,
                    child: Material(
                      color: Colors.transparent,
                      child: Text(
                        medicine.medicineName,
                        style: TextStyle(
                          fontFamily: 'Circular',
                          fontSize: 20,
                          color: Color(0xffF2E7FE),
                          fontWeight: FontWeight.w500,
                        ),
                      ),
                    ),
                  ),
                  Text(
                    medicine.interval == 1
                        ? "Every " + medicine.interval.toString() + " hour"
                        : "Every " + medicine.interval.toString() + " hours",
                    style: TextStyle(
                      fontFamily: 'Circular',
                      fontSize: 16,
                      color: Color(0xffF2E7FE).withOpacity(0.7),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}