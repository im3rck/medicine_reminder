import 'package:flutter/material.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_reminder/PatientController/Cards/customCard.dart';
import 'package:medicine_reminder/PatientController/DaySelector/DaySelector.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_core/theme.dart';

import 'MedicineAddon.dart';

PickedFile _image;
final ImagePicker _picker = ImagePicker();

class Medicines extends StatefulWidget {
  _Medicines createState() => _Medicines();
}

class _Medicines extends State<Medicines> {
  List<String> intervalItems = [];
  List<String> scheduleItems = [];
  String _selected = '';
  String _selectedType = '0';
  double yOffset = 0;
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);

  List<IconData> _icons = [
    Icons.description,
    Icons.calendar_today,
    Icons.alarm_add,
    Icons.calendar_today,
  ];

  InkWell _choice(String heading, String body, int index) {
    return InkWell(
        onTap: () {
          switch (index) {
            case 0:
              _newMedicine(context);
              break;
            case 1:
              _newSchedule(context);
              break;
            case 2:
              _timeInterval(context);
              break;
            case 3:
              _dayInterval(context);
              break;
          }
        },
        child: Container(
            height: (MediaQuery.of(context).size.height) * .30,
            width: (MediaQuery.of(context).size.width) * .5,
            child: customCard(_icons[index], heading, body)));
  }

  void _medicineChoice(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      builder: (context) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          _choice("By Medicine", "Set Schedule for Medicines", 0),
          _choice("By Schedule", "Set Medicines for Schedules", 1),
        ]);
      },
    );
  }

  void _newMedicine(context) {
    String _check() {
      if (_selected == 'Pill' || _selected == 'Tablet')
        return "numbers";
      else if (_selected == 'Bottle' || _selected == 'Syringe')
        return 'mL';
      else
        return 'Dosage';
    }

    double xOffset = 0;
    double scaleFactor = 1;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      builder: (context) {
        return WillPopScope(
          onWillPop: () async {
            return false;
          },
          child: Stack(
            children: <Widget>[
              AnimatedContainer(
                transform: Matrix4.translationValues(xOffset, yOffset, 0)
                  ..scale(scaleFactor),
                duration: Duration(milliseconds: 250),
                margin: EdgeInsets.fromLTRB(5, 0, 5, 10),
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffBB86FC), width: 1),
                  color: Color(0xff121212),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Wrap(
                  children: [
                    Stack(
                      children: [
                        Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                              children: [
                                Flexible(
                                  child: DropdownButton(
                                    iconEnabledColor: Color(0xFF3EB16F),
                                    dropdownColor: Color(0xff292929),
                                    hint: Text(
                                      "Type",
                                      style: TextStyle(
                                        fontFamily: 'Circular',
                                        fontSize: 16,
                                        color: Color(0xffF2E7FE),
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                    elevation: 4,
                                    value: _selectedType == '0'
                                        ? null
                                        : _selectedType,
                                    items: [
                                      'Pill',
                                      'Bottle',
                                      'Syringe',
                                      'Tablet'
                                    ].map((String value) {
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
                                ),
                                Container(
                                  child: GestureDetector(
                                    onTap: () {
                                      yOffset = 0;
                                      _showPicker(context);
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: _image != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: Image.file(
                                                File(_image.path),
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.fitHeight,
                                              ),
                                            )
                                          : Container(
                                              width: 100,
                                              height: 100,
                                              decoration: BoxDecoration(
                                                color: Color(0xff121212),
                                                borderRadius: BorderRadius.all(
                                                  Radius.circular(25),
                                                ),
                                                border: Border.all(
                                                    color: Color(0xffBB86FC),
                                                    width: 1),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Color(0xffbb86fe)
                                                        .withOpacity(0.2),
                                                    spreadRadius: 3,
                                                    blurRadius: 4,
                                                    offset: Offset(5.0, 5.0),
                                                  ),
                                                ],
                                              ),
                                              child: Icon(
                                                Icons.camera_alt,
                                                color: Color(0xfff2e7fe),
                                              ),
                                            ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width) * .9,
                              child: TextField(
                                onSubmitted: (value) {
                                  yOffset = 0;
                                },
                                // controller: emailController,
                                style: TextStyle(color: Color(0xfff2e7fe)),
                                decoration: InputDecoration(
                                    labelText: 'Medicine Name',
                                    labelStyle: TextStyle(
                                      fontSize: 14,
                                      fontFamily: 'Circular',
                                      color: Color(0xfff2e7fe).withOpacity(0.6),
                                      height: 2,
                                    ),
                                    filled: true,
                                    fillColor: Color(0xff121212),
                                    contentPadding: EdgeInsets.symmetric(
                                        horizontal: 16, vertical: 0),
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xfff2e7fe)),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide:
                                          BorderSide(color: Color(0xffBB86fc)),
                                      //  when the TextFormField in focused
                                    ),
                                    border: UnderlineInputBorder()),
                              ),
                            ),
                            SizedBox(height: 16),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width) * .4,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (value) {
                                      yOffset = 0;
                                    },
                                    // controller: emailController,
                                    style: TextStyle(color: Color(0xfff2e7fe)),
                                    decoration: InputDecoration(
                                        labelText: _check(),
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xfff2e7fe)
                                              .withOpacity(0.6),
                                          height: 2,
                                        ),
                                        filled: true,
                                        fillColor: Color(0xff121212),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 0),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xfff2e7fe)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffBB86fc)),
                                        ),
                                        border: UnderlineInputBorder()),
                                  ),
                                ),
                                Container(
                                  width:
                                      (MediaQuery.of(context).size.width) * .4,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
                                    onSubmitted: (value) {
                                      yOffset = 0;
                                    },
                                    // controller: emailController,
                                    style: TextStyle(color: Color(0xfff2e7fe)),
                                    decoration: InputDecoration(
                                        labelText: 'Initial Quantity',
                                        labelStyle: TextStyle(
                                          fontSize: 14,
                                          color: Color(0xfff2e7fe)
                                              .withOpacity(0.6),
                                          height: 2,
                                        ),
                                        filled: true,
                                        fillColor: Color(0xff121212),
                                        contentPadding: EdgeInsets.symmetric(
                                            horizontal: 16, vertical: 0),
                                        enabledBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xfff2e7fe)),
                                        ),
                                        focusedBorder: UnderlineInputBorder(
                                          borderSide: BorderSide(
                                              color: Color(0xffBB86fc)),
                                          //  when the TextFormField in focused
                                        ),
                                        border: UnderlineInputBorder()),
                                  ),
                                ),
                              ],
                            ),
                            SizedBox(
                              height: 50,
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Expanded(
                                    child: _choice(
                                        "Time", "Timing & Intervals", 2)),
                                Expanded(
                                    child:
                                        _choice("Schedule", "Days & Range", 3)),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                Navigator.pop(context);
                                yOffset = 0;
                              },
                              child: Container(
                                height: 40,
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
                                  child: Text(
                                    "Confirm",
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
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPicker(context) {
    _imgFromGallery() async {
      PickedFile image =
          await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

      setState(() {
        _image = image;
      });
    }

    _imgFromCamera() async {
      final PickedFile image =
          await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

      setState(() {
        _image = image;
      });
    }

    ListTile _choice(String heading, bool option) {
      return ListTile(
          leading: Icon(option ? Icons.photo_library : Icons.photo_camera,
              color: Color(0xfff2e7fe)),
          title: new Text(
            heading,
            style: TextStyle(
              fontFamily: 'Circular',
              fontSize: 16,
              color: Color(0xffF2E7FE),
              fontWeight: FontWeight.bold,
            ),
          ),
          onTap: () {
            option ? _imgFromGallery() : _imgFromCamera();
            Navigator.of(context).pop();
          });
    }

    showModalBottomSheet(
        context: context,
        backgroundColor: Color(0xff292929),
        builder: (BuildContext ctx) {
          return SafeArea(
            child: new Wrap(
              children: <Widget>[
                _choice('Photo Library', true),
                _choice('Camera', false)
              ],
            ),
          );
        });
  }

  String convertTime(String minutes) {
    if (minutes.length == 1) {
      return "0" + minutes;
    } else {
      return minutes;
    }
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
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
        });
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        intervalItems.add(
            "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}");
        _timeInterval(context);
      });
    }
    return picked;
  }

  void _timeInterval(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      builder: (BuildContext context) {
        var heightOfModalBottomSheet = MediaQuery.of(context).size.width;
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter myState) {
            return Container(
              height: heightOfModalBottomSheet,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffBB86FC), width: 1),
                color: Color(0xff292929),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Set Time Intervals",
                      style: TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF2E7FE),
                      ),
                    ),
                  ),
                  SizedBox(height: 10),
                  new Expanded(
                      child: new ListView.builder(
                          itemCount: intervalItems.length,
                          itemBuilder: (BuildContext ctx, int index) {
                            return new Container(
                              alignment: Alignment.center,
                              child: Card(
                                elevation: 10.0,
                                margin: new EdgeInsets.symmetric(
                                    horizontal: 10.0, vertical: 10.0),
                                child: Slidable(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Color(0xff292929),
                                    ),
                                    child: ListTile(
                                      leading: Container(
                                        margin: EdgeInsets.symmetric(
                                            horizontal: 10, vertical: 10.0),
                                        height: 20,
                                        width: 20,
                                        decoration: BoxDecoration(
                                            color: Color(0xff292929),
                                            shape: BoxShape.circle,
                                            border: Border.all(
                                                color: Color(0xffbb86fe),
                                                width: 4)),
                                      ),
                                      title: Text(
                                        intervalItems[index],
                                        style: TextStyle(
                                          fontFamily: 'Circular',
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                          color: Color(0xfff2e7fe),
                                          height: 2,
                                        ),
                                      ),
                                      trailing: Container(
                                        height: 50,
                                        width: 5,
                                        color: Color(0xffbb86fe),
                                      ),
                                    ),
                                  ),
                                  actionPane: SlidableBehindActionPane(),
                                  secondaryActions: <Widget>[
                                    IconSlideAction(
                                      caption: 'Delete',
                                      color: Colors.red,
                                      icon: Icons.delete,
                                      onTap: () {
                                        intervalItems.removeAt(index);
                                        Navigator.pop(context);
                                        _timeInterval(context);
                                      },
                                    ),
                                  ],
                                ),
                              ),
                            );
                          })),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pop(context);
                      setState(() {
                        _selectTime(context);
                      });
                    },
                    icon: Icon(Icons.add),
                    backgroundColor: Color(0xff292929),
                    foregroundColor: Color(0xffbb86fe),
                    label: Text(
                      "Interval",
                      style: TextStyle(
                        fontSize: 16,
                        fontFamily: 'Circular',
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF2E7FE),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _dayInterval(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter myState) {
            return Container(
              height: (MediaQuery.of(context).size.height) * .5,
              padding: EdgeInsets.all(20.0),
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffBB86FC), width: 1),
                color: Color(0xff121212),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Select Days",
                      style: TextStyle(
                        fontSize: 20,
                        fontFamily: 'Circular',
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF2E7FE),
                      ),
                    ),
                  ),
                  SizedBox(height: 25),
                  Expanded(child: MedicineAddon()),
                  SizedBox(
                    height: 10.0,
                  ),
                  Center(
                      child: Container(
                          padding: EdgeInsets.only(bottom: 10),
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backgroundColor: Color(0xff292929),
                            foregroundColor: Color(0xffbb86fe),
                            label: Text(
                              "Done",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Circular',
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF2E7FE),
                              ),
                            ),
                          ))),
                ],
              ),
            );
          },
        );
      },
    );
  }

  void _newSchedule(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      builder: (context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter myState) {
            return Container(
              padding: EdgeInsets.all(20.0),
              // height: (MediaQuery.of(context).size.height) * .80,
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffBB86FC), width: 1),
                color: Color(0xff292929),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      "Set The Schedule",
                      style: TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF2E7FE),
                      ),
                    ),
                  ),
                  new Expanded(
                      child: InkWell(
                    onTap: () => _newMedicine(context),
                    child: new ListView.builder(
                        itemCount: scheduleItems.length,
                        itemBuilder: (BuildContext ctx, int index) {
                          return new Container(
                            alignment: Alignment.center,
                            child: Card(
                              elevation: 10.0,
                              margin: new EdgeInsets.symmetric(
                                  horizontal: 10.0, vertical: 10.0),
                              child: Slidable(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: Color(0xff292929),
                                  ),
                                  child: ListTile(
                                    leading: Container(
                                      margin: EdgeInsets.symmetric(
                                          horizontal: 10, vertical: 10.0),
                                      height: 20,
                                      width: 20,
                                      decoration: BoxDecoration(
                                          color: Color(0xff292929),
                                          shape: BoxShape.circle,
                                          border: Border.all(
                                              color: Color(0xffbb86fe),
                                              width: 4)),
                                    ),
                                    title: Text(
                                      scheduleItems[index],
                                      style: TextStyle(
                                        fontSize: 16,
                                        fontWeight: FontWeight.bold,
                                        color: Color(0xfff2e7fe),
                                        height: 2,
                                      ),
                                    ),
                                    trailing: Container(
                                      height: 50,
                                      width: 5,
                                      color: Color(0xffbb86fe),
                                    ),
                                  ),
                                ),
                                actionPane: SlidableBehindActionPane(),
                                actions: <Widget>[
                                  IconSlideAction(
                                    caption: 'MedList',
                                    color: Color(0xff121212),
                                    icon: Icons.list,
                                    onTap: () => print('log'),
                                  ),
                                ],
                                secondaryActions: <Widget>[
                                  IconSlideAction(
                                    caption: 'Delete',
                                    color: Colors.red,
                                    icon: Icons.delete,
                                    onTap: () {
                                      scheduleItems.removeAt(index);
                                      Navigator.pop(context);
                                      _newSchedule(context);
                                    },
                                  ),
                                ],
                              ),
                            ),
                          );
                        }),
                  )),
                  FloatingActionButton.extended(
                    onPressed: () {
                      Navigator.pop(context);
                      _selectTimeSchedule(context);
                    },
                    icon: Icon(Icons.add),
                    backgroundColor: Color(0xff292929),
                    foregroundColor: Color(0xffbb86fe),
                    label: Text(
                      "Schedule",
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF2E7FE),
                      ),
                    ),
                  )
                ],
              ),
            );
          },
        );
      },
    );
  }

  Future<TimeOfDay> _selectTimeSchedule(BuildContext context) async {
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
        });
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        // _clicked = true;
        scheduleItems.add(
            "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}");
        print(scheduleItems);
        _newSchedule(context);
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        InkWell(
          onTap: () {
            _medicineChoice(context);
          },
          child: Container(
              height: (MediaQuery.of(context).size.height) * .25,
              width: MediaQuery.of(context).size.width,
              child:
                  customCard(Icons.description, "Medicine", "Dosage Details")),
        ),
      ],
    );
  }
}
