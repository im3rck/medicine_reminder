import 'dart:math';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Common/convert_time.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Global_Bloc.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Models/Errors.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Models/Medicine.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Models/Medicine_Details.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/UI/HomePage.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/UI/New_Entry/New_Entry_Bloc.dart';
import 'package:provider/provider.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicine_reminder/Enhancements/SuccessScreen/SuccessScreen.dart';

class NewEntry extends StatefulWidget {
  @override
  _NewEntryState createState() => _NewEntryState();
}

class _NewEntryState extends State<NewEntry> {
  TextEditingController nameController;
  TextEditingController dosageController;
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin;
  NewEntryBloc _newEntryBloc;

  GlobalKey<ScaffoldState> _scaffoldKey;

  void dispose() {
    super.dispose();
    nameController.dispose();
    dosageController.dispose();
    _newEntryBloc.dispose();
  }

  void initState() {
    super.initState();
    _newEntryBloc = NewEntryBloc();
    nameController = TextEditingController();
    dosageController = TextEditingController();
    flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
    _scaffoldKey = GlobalKey<ScaffoldState>();
    initializeNotifications();
    initializeErrorListen();
  }

  @override
  Widget build(BuildContext context) {
    final GlobalBloc _globalBloc = Provider.of<GlobalBloc>(context);

    return Scaffold(
      key: _scaffoldKey,
      resizeToAvoidBottomPadding: false,
      backgroundColor: Color(0xff121212),
      appBar: AppBar(
        backgroundColor: Color(0xff292929),
        elevation: 4.0,
        iconTheme: IconThemeData(
          color: Color(0xFFbb86fe),
        ),
        centerTitle: true,
        title: Text("Add a New Reminder",
          //AppLocalizations.of(context).translate('Add a New Reminder'),
          style: TextStyle(
            fontFamily: 'Circular',
            fontSize: 16,
            color: Color(0xffF2E7FE),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: Container(
        child: Provider<NewEntryBloc>.value(
          value: _newEntryBloc,
          child: ListView(
            padding: EdgeInsets.symmetric(
              horizontal: 25,
            ),
            children: <Widget>[
              PanelTitle(
                title: AppLocalizations.of(context).translate('Medicine_Name'),
                isRequired: true,
              ),
              TextFormField(
                maxLength: 12,
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 16,
                  color: Color(0xffF2E7FE),
                  //fontWeight: FontWeight.bold,
                ),
                controller: nameController,
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff2e7fe)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffBB86fc)),
                      //  when the TextFormField in focused
                    ),
                    border: UnderlineInputBorder()),
              ),
              PanelTitle(
                title: AppLocalizations.of(context).translate('Dosage'),
                isRequired: false,
              ),
              TextFormField(
                controller: dosageController,
                keyboardType: TextInputType.number,
                style: TextStyle(
                  fontFamily: 'Circular',
                  fontSize: 16,
                  color: Color(0xffF2E7FE),
                  // fontWeight: FontWeight.bold,
                ),
                textCapitalization: TextCapitalization.words,
                decoration: InputDecoration(
                    enabledBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xfff2e7fe)),
                    ),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xffBB86fc)),
                      //  when the TextFormField in focused
                    ),
                    border: UnderlineInputBorder()),
              ),
              SizedBox(
                height: 15,
              ),

              PanelTitle(
                title: AppLocalizations.of(context).translate('Type'),
                isRequired: false,
              ),
              Padding(
                padding: EdgeInsets.only(top: 10.0),
                child: StreamBuilder<MedicineType>(
                  stream: _newEntryBloc.selectedMedicineType,
                  builder: (context, snapshot) {
                    return Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        MedicineTypeColumn(
                            type: MedicineType.Bottle,
                            name: "Bottle",
                            iconValue: 0xe900,
                            isSelected: snapshot.data == MedicineType.Bottle
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Pill,
                            name: 'Pill',
                            iconValue: 0xe901,
                            isSelected: snapshot.data == MedicineType.Pill
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Syringe,
                            name: 'Injection',
                            iconValue: 0xe902,
                            isSelected: snapshot.data == MedicineType.Syringe
                                ? true
                                : false),
                        MedicineTypeColumn(
                            type: MedicineType.Tablet,
                            name: 'Tablet',
                            iconValue: 0xe903,
                            isSelected: snapshot.data == MedicineType.Tablet
                                ? true
                                : false),
                      ],
                    );
                  },
                ),
              ),
              PanelTitle(
                title: AppLocalizations.of(context).translate('Interval Selection'),
                isRequired: true,
              ),
              //ScheduleCheckBoxes(),
              IntervalSelection(),
              PanelTitle(
                title: AppLocalizations.of(context).translate('Starting Time'),
                isRequired: true,
              ),
              SelectTime(),
              SizedBox(
                height: 35,
              ),
              Padding(
                padding: EdgeInsets.only(
                  left: MediaQuery.of(context).size.height * 0.08,
                  right: MediaQuery.of(context).size.height * 0.08,
                ),
                child: InkWell(
                  onTap: () {
                    String medicineName;
                    int dosage;
                    if (nameController.text == "") {
                      _newEntryBloc.submitError(EntryError.NameNull);
                      return;
                    }
                    if (nameController.text != "") {
                      medicineName = nameController.text;
                    }
                    if (dosageController.text == "") {
                      dosage = 0;
                    }
                    if (dosageController.text != "") {
                      dosage = int.parse(dosageController.text);
                    }
                    for (var medicine in _globalBloc.medicineList$.value) {
                      if (medicineName == medicine.medicineName) {
                        _newEntryBloc.submitError(EntryError.NameDuplicate);
                        return;
                      }
                    }
                    if (_newEntryBloc.selectedInterval$.value == 0) {
                      _newEntryBloc.submitError(EntryError.Interval);
                      return;
                    }
                    if (_newEntryBloc.selectedTimeOfDay$.value == "None") {
                      _newEntryBloc.submitError(EntryError.StartTime);
                      return;
                    }
                    //---------------------------------------------------------
                    String medicineType = _newEntryBloc
                        .selectedMedicineType.value
                        .toString()
                        .substring(13);
                    int interval = _newEntryBloc.selectedInterval$.value;
                    String startTime = _newEntryBloc.selectedTimeOfDay$.value;

                    List<int> intIDs =
                        makeIDs(24 / _newEntryBloc.selectedInterval$.value);
                    List<String> notificationIDs = intIDs
                        .map((i) => i.toString())
                        .toList(); //for Shared preference

                    Medicine newEntryMedicine = Medicine(
                      notificationIDs: notificationIDs,
                      medicineName: medicineName,
                      dosage: dosage,
                      medicineType: medicineType,
                      interval: interval,
                      startTime: startTime,
                    );

                    _globalBloc.updateMedicineList(newEntryMedicine);
                    scheduleNotification(newEntryMedicine);

                    Navigator.pushReplacement(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return SuccessScreen();
                        },
                      ),
                    );
                  },
                  child: Container(
                    height: (MediaQuery.of(context).size.height)*.06,
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
                        'Confirm',
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
    );
  }

  void initializeErrorListen() {
    _newEntryBloc.errorState$.listen(
      (EntryError error) {
        switch (error) {
          case EntryError.NameNull:
            displayError("Please enter the medicine's name");
            break;
          case EntryError.NameDuplicate:
            displayError("Medicine name already exists");
            break;
          case EntryError.Dosage:
            displayError("Please enter the dosage required");
            break;
          case EntryError.Interval:
            displayError("Please select the reminder's interval");
            break;
          case EntryError.StartTime:
            displayError("Please select the reminder's starting time");
            break;
          default:
        }
      },
    );
  }

  void displayError(String error) {
    _scaffoldKey.currentState.showSnackBar(
      SnackBar(
        backgroundColor: Color(0xffbb86fe),
        content: Text(error),
        duration: Duration(milliseconds: 2000),
      ),
    );
  }

  List<int> makeIDs(double n) {
    var rng = Random();
    List<int> ids = [];
    for (int i = 0; i < n; i++) {
      ids.add(rng.nextInt(1000000000));
    }
    return ids;
  }

  initializeNotifications() async {
    var initializationSettingsAndroid =
        AndroidInitializationSettings('applogo_large');
    var initializationSettingsIOS = IOSInitializationSettings();
    var initializationSettings = InitializationSettings(
        android: initializationSettingsAndroid, iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings,
        onSelectNotification: onSelectNotification);
  }

  Future onSelectNotification(String payload) async {
    if (payload != null) {
      debugPrint('notification payload: ' + payload);
    }
    await Navigator.push(
      context,
      new MaterialPageRoute(builder: (context) => HomePage()),
    );
  }

  Future<void> scheduleNotification(Medicine medicine) async {
    var hour = int.parse(medicine.startTime[0] + medicine.startTime[1]);
    var ogValue = hour;
    var minute = int.parse(medicine.startTime[2] + medicine.startTime[3]);

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'repeatDailyAtTime channel id',
      'repeatDailyAtTime channel name',
      'repeatDailyAtTime description',
      importance: Importance.max,
      ledColor: Color(0xFFbb86fe),
      ledOffMs: 1000,
      ledOnMs: 1000,
      enableLights: true,
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
        android: androidPlatformChannelSpecifics,
        iOS: iOSPlatformChannelSpecifics);

    for (int i = 0; i < (24 / medicine.interval).floor(); i++) {
      if ((hour + (medicine.interval * i) > 23)) {
        hour = hour + (medicine.interval * i) - 24;
      } else {
        hour = hour + (medicine.interval * i);
      }
      await flutterLocalNotificationsPlugin.showDailyAtTime(
          int.parse(medicine.notificationIDs[i]),
          'Self Reminder: ${medicine.medicineName}',
          medicine.medicineType.toString() != MedicineType.None.toString()
              ? 'It is time to take your ${medicine.medicineType.toLowerCase()}, according to schedule'
              : 'It is time to take your medicine, according to schedule',
          Time(hour, minute, 0),
          platformChannelSpecifics);
      hour = ogValue;
    }
    //await flutterLocalNotificationsPlugin.cancelAll();
  }
}

class IntervalSelection extends StatefulWidget {
  @override
  _IntervalSelectionState createState() => _IntervalSelectionState();
}

class _IntervalSelectionState extends State<IntervalSelection> {
  var _intervals = [
    4,
    6,
    8,
    12,
    24,
  ];
  var _selected = 0;

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc =
        Provider.of<NewEntryBloc>(context, listen: false);
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              "Remind me every  ",
              style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 18,
                color: Color(0xffF2E7FE),
                fontWeight: FontWeight.w500,
              ),
            ),
            DropdownButton<int>(
              iconEnabledColor: Color(0xFFbb86fe),
              dropdownColor: Color(0xff292929),
              hint: _selected == 0
                  ? Text(
                      "Select an Interval",
                      style: TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 10,
                        color: Color(0xffF2E7FE),
                        fontWeight: FontWeight.w400,
                      ),
                    )
                  : null,
              elevation: 4,
              value: _selected == 0 ? null : _selected,
              items: _intervals.map((int value) {
                return DropdownMenuItem<int>(
                  value: value,
                  child: Text(
                    value.toString(),
                    style: TextStyle(
                      color: Color(0xfff2e7fe),
                      fontSize: 16,
                      fontWeight: FontWeight.w500,
                    ),
                  ),
                );
              }).toList(),
              onChanged: (newVal) {
                setState(() {
                  _selected = newVal;
                  _newEntryBloc.updateInterval(newVal);
                });
              },
            ),
            Text(
              _selected == 1 ? " hour" : " hours",
              style: TextStyle(
                fontFamily: 'Circular',
                fontSize: 18,
                color: Color(0xffF2E7FE),
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class SelectTime extends StatefulWidget {
  @override
  _SelectTimeState createState() => _SelectTimeState();
}

class _SelectTimeState extends State<SelectTime> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);
  bool _clicked = false;

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final NewEntryBloc _newEntryBloc =
        Provider.of<NewEntryBloc>(context, listen: false);
    final TimeOfDay picked = await showTimePicker(
      context: context,
      initialTime: _time,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Color(0xffbb86fe),
                  onPrimary: Color(0xff121212),
                  surface: Color(0xff121212),
                  onSurface: Color(0xfff2e7fe),
                ),
                buttonTheme:
                ButtonThemeData(textTheme: ButtonTextTheme.primary),
                dialogBackgroundColor: Color(0xffbb86fe)),
            child: child,
          );
        }
    );
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        _clicked = true;
        _newEntryBloc.updateTime("${convertTime(_time.hour.toString())}" +
            "${convertTime(_time.minute.toString())}");
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 60,
      child: Padding(
        padding: EdgeInsets.only(top: 10.0, bottom: 4),
        child: InkWell(
          onTap: () {
            _selectTime(context);
          },
          child: Container(
            height: 40,
            width: (MediaQuery.of(context).size.width) * .6,
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
              child: Text(
                _clicked == false
                    ? AppLocalizations.of(context).translate('Time')
                    : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
                style: TextStyle(
                  fontSize: 20,
                  fontFamily: 'Circular',
                  letterSpacing: 3.0,
                  fontWeight: FontWeight.bold,
                  color: Color(0xffF2E7FE),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class MedicineTypeColumn extends StatelessWidget {
  final MedicineType type;
  final String name;
  final int iconValue;
  final bool isSelected;

  MedicineTypeColumn(
      {Key key,
      @required this.type,
      @required this.name,
      @required this.iconValue,
      @required this.isSelected})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final NewEntryBloc _newEntryBloc =
        Provider.of<NewEntryBloc>(context, listen: false);
    return GestureDetector(
      onTap: () {
        _newEntryBloc.updateSelectedMedicine(type);
      },
      child: Column(
        children: <Widget>[
          Container(
            width: 65,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: isSelected
                  ? Colors.grey[850]
                  : Color(0xff292929).withOpacity(0.5),
            ),
            child: Center(
              child: Padding(
                padding: EdgeInsets.all(5.0),
                child: Icon(
                  IconData(iconValue, fontFamily: "Ic"),
                  size: 55,
                  color: isSelected
                      ? Color(0xffbb86fe)
                      : Color(0xFFf2e7fe).withOpacity(0.7),
                ),
              ),
            ),
          ),
          Padding(
            padding: EdgeInsets.only(top: 8.0),
            child: Container(
              width: 70,
              height: 30,
              decoration: BoxDecoration(
                color: isSelected ? Color(0xFF292929) : Colors.transparent,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Center(
                child: Text(
                  name,
                  style: TextStyle(
                    fontSize: 16,
                    color: isSelected
                        ? Color(0xffbb86fe)
                        : Color(0xFFf2e7fe).withOpacity(0.7),
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PanelTitle extends StatelessWidget {
  final String title;
  final bool isRequired;

  PanelTitle({
    Key key,
    @required this.title,
    @required this.isRequired,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 12, bottom: 4),
      child: Text.rich(
        TextSpan(children: <TextSpan>[
          TextSpan(
            text: title,
            style: TextStyle(
              fontFamily: 'Circular',
              fontSize: 14,
              color: Color(0xffF2E7FE),
              fontWeight: FontWeight.w500,
            ),
          ),
          TextSpan(
            text: isRequired ? " *" : "",
            style: TextStyle(fontSize: 14, color: Color(0xFFbb86fe)),
          ),
        ]),
      ),
    );
  }
}
