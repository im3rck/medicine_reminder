import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_reminder/PatientController/MedicineList/MedicineList.dart';
import 'package:medicine_reminder/PatientController/customCard.dart';

double yOffset = 0;
String _selected = '';

// ignore: must_be_immutable
class Cards extends StatefulWidget {
  @override
  _CardsState createState() => _CardsState();
}

PickedFile _image;
final ImagePicker _picker = ImagePicker();

class _CardsState extends State<Cards> {
  final double appBarHeight = 55.0;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        SizedBox(height: 14.0),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                _popupCard(context);
              },
              child: Container(
                  height: 185.0,
                  width: MediaQuery.of(context).size.width,
                  child: customCard(Icons.person, "Details", "Patient Bio")),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                _medicineChoice(context);
              },
              child: Container(
                  height: 185,
                  width: MediaQuery.of(context).size.width,
                  child: customCard(
                      Icons.description, "Medicine", "Dosage Details")),
            ),
          ],
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            InkWell(
              onTap: () {
                _medicineList();
              },
              child: Container(
                  height: 185.0,
                  width: MediaQuery.of(context).size.width,
                  child: customCard(Icons.assignment, "Medicine", "List")),
            ),
          ],
        ),
      ],
    );
  }

  void _medicineChoice(context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      builder: (context) {
        return Row(mainAxisAlignment: MainAxisAlignment.center, children: [
          InkWell(
            onTap: () {
              _byMedicine();
            },
            child: Container(
                height: (MediaQuery.of(context).size.height) * .25,
                width: (MediaQuery.of(context).size.width) * .5,
                child: customCard(
                  Icons.description,
                  "By Medicine",
                  "Set Schedule for Medicines",
                )),
          ),
          InkWell(
            onTap: (){
              _bySchedule();
            },
            child: Container(
                height: (MediaQuery.of(context).size.height) * .25,
                width: (MediaQuery.of(context).size.width) * .5,
                child: customCard(
                  Icons.calendar_today,
                  "By Schedule",
                  "Set Medicines for Schedules",
                )),
          ),
        ]);
      },
    );
  }

  void _byMedicine() {
    _newMedicine(context);
  }
  void _bySchedule(){
    _newSchedule(context);
  }

  void _newSchedule(context){

  }
  // Patient Details
  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library),
                      title: new Text('Photo Library'),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading: new Icon(Icons.photo_camera),
                    title: new Text('Camera'),
                    onTap: () {
                      _imgFromCamera();
                      Navigator.of(context).pop();
                    },
                  ),
                ],
              ),
            ),
          );
        });
  }

  _imgFromCamera() async {
    final PickedFile image =
        await _picker.getImage(source: ImageSource.camera, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    PickedFile image =
        await _picker.getImage(source: ImageSource.gallery, imageQuality: 50);

    setState(() {
      _image = image;
    });
  }

  void _popupCard(context) {
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
                // height: (MediaQuery.of(context).size.height) * .80,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffBB86FC), width: 1),
                  color: Color(0xff121212),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Wrap(
                  children: [
                    Stack(
                      // alignment: Alignment.center,
                      children: [
                        // CustomPaint(
                        //   child: Container(
                        //     child: Center(
                        //       child: Column(
                        //         mainAxisAlignment: MainAxisAlignment.end,
                        //         children: [],
                        //       ),
                        //     ),
                        //     height: (MediaQuery.of(context).size.height) * .57,
                        //     width: MediaQuery.of(context).size.width,
                        //   ),
                        // ),
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                                child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  yOffset = 0;
                                  _showPicker(context);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: _image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.file(
                                            File(_image.path),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Colors.grey[200],
                                            borderRadius:
                                                BorderRadius.circular(12),
                                          ),
                                          width: 100,
                                          height: 100,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Colors.grey[800],
                                          ),
                                        ),
                                ),
                              ),
                            )),
                            SizedBox(
                              height: 24,
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width) * .9,
                              child: TextField(
                                onTap: () {
                                  yOffset = -210;
                                },
                                onSubmitted: (value) {
                                  yOffset = 0;
                                },
                                // controller: emailController,
                                style: TextStyle(color: Color(0xfff2e7fe)),
                                decoration: InputDecoration(
                                    labelText: 'Username',
                                    prefixIcon: Icon(
                                      Icons.person,
                                      color: Color(0xffF2E7FE),
                                    ),
                                    labelStyle: TextStyle(
                                      fontFamily: 'Circular',
                                      fontSize: 16,
                                      color: Color(0xffF2E7FE),
                                      fontWeight: FontWeight.bold,
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
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width) * .9,
                              child: TextField(
                                onTap: () {
                                  yOffset = -210;
                                },
                                onSubmitted: (value) {
                                  yOffset = 0;
                                },
                                // controller: emailController,
                                style: TextStyle(color: Color(0xfff2e7fe)),
                                decoration: InputDecoration(
                                    labelText: 'Age',
                                    prefixIcon: Icon(
                                      Icons.calendar_view_day,
                                      color: Color(0xffF2E7FE),
                                    ),
                                    labelStyle: TextStyle(
                                      fontFamily: 'Circular',
                                      fontSize: 16,
                                      color: Color(0xffF2E7FE),
                                      fontWeight: FontWeight.bold,
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
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              width: (MediaQuery.of(context).size.width) * .9,
                              child: TextField(
                                onTap: () {
                                  yOffset = -210;
                                },
                                onSubmitted: (value) {
                                  yOffset = 0;
                                },
                                // controller: emailController,
                                style: TextStyle(color: Color(0xfff2e7fe)),
                                decoration: InputDecoration(
                                    labelText: 'Contact',
                                    prefixIcon: Icon(
                                      Icons.phone,
                                      color: Color(0xffF2E7FE),
                                    ),
                                    labelStyle: TextStyle(
                                      fontFamily: 'Circular',
                                      fontSize: 16,
                                      color: Color(0xffF2E7FE),
                                      fontWeight: FontWeight.bold,
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
                                    ),
                                    border: UnderlineInputBorder()),
                              ),
                            ),
                            SizedBox(
                              height: 30,
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
                                  color: Color(0xff292929),
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

  void _newMedicine(context) {
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
                // height: (MediaQuery.of(context).size.height) * .80,
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffBB86FC), width: 1),
                  color: Color(0xff121212),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Wrap(
                  children: [
                    Stack(
                      // alignment: Alignment.center,
                      children: [
                        Column(
                          // mainAxisAlignment: MainAxisAlignment.center,
                          // crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
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
                                    /* prefixIcon: Icon(
                                      Icons.person,
                                      color: Color(0xffF2E7FE),
                                    ),*/
                                    labelStyle: TextStyle(
                                      fontSize: 14,
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
                            SizedBox(
                              height: 16,
                            ),
                            Container(
                              child: MedicineType(),
                            ),
                            SizedBox(width: 10.0),
                            TextField(
                              onSubmitted: (value) {
                                yOffset = 0;
                              },
                              // controller: emailController,
                              style: TextStyle(color: Color(0xfff2e7fe)),
                              decoration: InputDecoration(
                                  labelText: _check(),
                                  /*prefixIcon: Icon(
                                    Icons.phone,
                                    color: Color(0xffF2E7FE),
                                  ),*/
                                  labelStyle: TextStyle(
                                    fontSize: 14,
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
                                  ),
                                  border: UnderlineInputBorder()),
                            ),
                            SizedBox(
                              height: 16,
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
                                    labelText: 'Initial Quantity',
                                    /* prefixIcon: Icon(
                                      Icons.person,
                                      color: Color(0xffF2E7FE),
                                    ),*/
                                    labelStyle: TextStyle(
                                      fontSize: 14,
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
                            SizedBox(
                              height: 26,
                            ),
                            Container(
                                child: Center(
                              child: GestureDetector(
                                onTap: () {
                                  yOffset = 0;
                                  _showPicker(context);
                                },
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(12.0),
                                  child: _image != null
                                      ? ClipRRect(
                                          borderRadius:
                                              BorderRadius.circular(12),
                                          child: Image.file(
                                            File(_image.path),
                                            width: 100,
                                            height: 100,
                                            fit: BoxFit.fitHeight,
                                          ),
                                        )
                                      : Container(
                                          decoration: BoxDecoration(
                                            color: Color(0xff292929),
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
                                          width: 100,
                                          height: 100,
                                          child: Icon(
                                            Icons.camera_alt,
                                            color: Color(0xfff2e7fe),
                                          ),
                                        ),
                                ),
                              ),
                            )),
                            SizedBox(
                              height: 20,
                            ),
                            Row(
                              children: [
                                InkWell(
                                  onTap: () {
                                    _timeInterval(); //_selectTime();
                                  },
                                  child: Column(
                                    children: [
                                      Container(
                                          height: (MediaQuery.of(context)
                                                  .size
                                                  .height) *
                                              .25,
                                          width: (MediaQuery.of(context)
                                                  .size
                                                  .width) *
                                              .43,
                                          child: customCard(
                                            Icons.alarm_add,
                                            _clicked == false
                                                ? "Time"
                                                : "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}",
                                            "Timing & Intervals",
                                          )),
                                    ],
                                  ),
                                ),
                                Container(
                                    height:
                                        (MediaQuery.of(context).size.height) *
                                            .25,
                                    width: (MediaQuery.of(context).size.width) *
                                        .43,
                                    child: customCard(
                                      Icons.calendar_today,
                                      "Schedule",
                                      "Days & Range",
                                    )),
                              ],
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                _clicked = false;
                                Navigator.pop(context);
                                yOffset = 0;
                              },
                              child: Container(
                                height: 40,
                                width: (MediaQuery.of(context).size.width) * .8,
                                decoration: BoxDecoration(
                                  color: Color(0xff292929),
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
  void _timeInterval()
  {
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
            child: Column(
              children: [
                Center(
                  child: Text("Set Time Intervals", style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffF2E7FE),
                  ),),
                ),
                Container(
                  height: (MediaQuery.of(context).size.height)*.40,
                ),
                FloatingActionButton.extended(
                  onPressed: (){
                    _selectTime(context);
                    },
                  icon: Icon(Icons.add),
                  backgroundColor: Color(0xff292929),
                  foregroundColor: Color(0xffbb86fe),
                  label: Text("Interval",style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xffF2E7FE),
                ),),
                )
              ],
            ));
      },
    );
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
        _clicked = true;
      });
    }
    return picked;
  }

  String _check() {
    if (_selected == 'Pill' || _selected == 'Tablet')
      return "numbers";
    else if (_selected == 'Bottle' || _selected == 'Syringe')
      return 'mL';
    else
      return 'Dosage Format';
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
                _selectedType = newVal;
                _selected = newVal;
              },
            ),
          ],
        ),
      ),
    );
  }
}

bool _clicked = false;
TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);

String convertTime(String minutes) {
  if (minutes.length == 1) {
    return "0" + minutes;
  } else {
    return minutes;
  }
}
