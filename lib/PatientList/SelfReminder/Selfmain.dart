import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Global_Bloc.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/UI/HomePage.dart';
import 'package:provider/provider.dart';

class MedicineReminder extends StatefulWidget {
  @override
  _MedicineReminderState createState() => _MedicineReminderState();
}

class _MedicineReminderState extends State<MedicineReminder> {
  GlobalBloc globalBloc;

  void initState() {
    globalBloc = GlobalBloc();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Provider<GlobalBloc>.value(
      value: globalBloc,
      child: MaterialApp(
        /*theme: ThemeData(
          primarySwatch: Colors.black,
          brightness: Brightness.dark,
        ),*/
        home: HomePage(),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}