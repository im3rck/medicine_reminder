import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/ScheduleModel.dart';
import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';
import 'package:medicine_reminder/PatientController/Cards/Medicine/AutoComplete.dart';
import 'package:medicine_reminder/PatientController/Cards/Medicine/TimeIntervals.dart';
import 'package:medicine_reminder/PatientController/Cards/customCard.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';

import 'MedicineAddon.dart';
import 'package:medicine_reminder/PatientController/Cards/Medicine/scheduleData.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:medicine_reminder/Backend%20Services/Image%20Handling/ImageHandler.dart';
import 'package:medicine_reminder/Backend%20Services/Image%20Handling/ImageService.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:uuid/uuid.dart';
import 'package:medicine_reminder/Backend%20Services/Services/cF_Services.dart';
PickedFile _image;
final ImagePicker _picker = ImagePicker();

class Medicines extends StatefulWidget {
  _Medicines createState() => _Medicines();
}

class _Medicines extends State<Medicines> {
  // void initState(){
  //   Pink();
  // }
  // Pink() async {
  //    await FirebaseStorage.instanceFor(bucket: 'gs://medicine-reminder-406a5.appspot.com/')
  //       .ref('PatientImages/595956898.png')
  //       .writeToFile(imageFile);
  // // }
  // //COPIED THIS
   String imageUrl;
  // File imageFile;
  //COPIED THIS
  TextEditingController dosageController = new TextEditingController();
  TextEditingController initialQuantityController = new TextEditingController();
  final style = TextStyle(
      color: Color(0xfff2e7fe),
      fontWeight: FontWeight.bold,
      fontFamily: 'Circular',
      fontSize: 16.0);
  String _selected = '';
  String _selectedType = '0';
  double yOffset = 0;

  List<IconData> _icons = [
    Icons.description,
    Icons.calendar_today,
    Icons.alarm_add,
    Icons.calendar_today,
  ];
   var uuid = Uuid();
  void writeRepeatedSchedules(context) async {
    FirestoreServices FS = FirestoreServices.test();
    RepeatedScheduleModel rsm;
    rsm = RepeatedScheduleModel(days: daysList,time: timeOfDay.hour.toString() + ':' + timeOfDay.minute.toString(),
        medName: medicineName, dosage: dosageController.text, imageUrl: "abcd", scheduleId: uuid.v1()  );
    FS.createRepeatedSchedule(rsm);
  }
 void writeSchedule(context) async {
   FirestoreServices FS = FirestoreServices.test();
   if(dateList!=null){
     newScheduleModel nsm;
     dateList.forEach((date){
       print("Potato + ${date.toIso8601String()}");
       nsm =  newScheduleModel(date: date.year.toString() + '-' + date.month.toString() + '-' + date.day.toString(),
         time: timeOfDay.hour.toString() + ':' + timeOfDay.minute.toString(),
         medName: medicineName, dosage: dosageController.text, imageUrl: "abcd", scheduleId: uuid.v1()
        );
       FS.createTimedSchedule(nsm);
     });
   }

 }
  InkWell _choice(String heading, String body, int index) {
    return InkWell(
        onTap: () {
          switch (index) {
            case 0:
              _newMedicine(true);
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
            height: (MediaQuery.of(context).size.height) * .35,
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
          _choice(AppLocalizations.of(context).translate('By_Medicine'), AppLocalizations.of(context).translate('Set_Schedule_for_Medicines'), 0),
          _choice(AppLocalizations.of(context).translate('By_Schedule'), AppLocalizations.of(context).translate('Set_Medicines_for_Schedules'), 1),
        ]);
      },
    );
  }

  void _newMedicine(bool single) {
    String _check() {
      if (_selected == 'Pill' || _selected == 'Tablet')
        return "numbers";
      else if (_selected == 'Bottle' || _selected == 'Syringe')
        return 'mL';
      else
        return AppLocalizations.of(context).translate('Dosage');
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
                                      AppLocalizations.of(context).translate('Type'),
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
                                      'Injection',
                                      'Tablet',
                                      'Other'
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
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  ImageCapture  (
                                                      newFile: (File imageFile){
                                                        ImageService _IS = ImageService.MedicineImage(imageFile,medicineName);
                                                        // fetchImageUrl('PatientImages/${c['contactNo']}');
                                                        // setState(()  {
                                                        // //  callImage();
                                                        //  imageUrl = 'gs://medicine-reminder-406a5.appspot.com/MedicineImages/g5e7l9e.png';
                                                        //      //_IS.targetUrl;
                                                        // });
                                                      }
                                                  )
                                          ));
                                    },
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(25.0),
                                      child: imageUrl != null
                                          ? ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(25),
                                              child: Image.network(
                                                imageUrl,
                                                width: 100,
                                                height: 100,
                                                fit: BoxFit.contain,
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
                              width: (MediaQuery.of(context).size.width)*.9,
                              child: AutoComplete(),
                              // child: TextField(
                              //   onSubmitted: (value) {
                              //     yOffset = 0;
                              //   },
                              //   },
                              //   // controller: emailController,
                              //   style: TextStyle(color: Color(0xfff2e7fe)),
                              //   decoration: InputDecoration(
                              //       labelText: 'Medicine Name',
                              //       labelStyle: TextStyle(
                              //         fontSize: 14,
                              //         fontFamily: 'Circular',
                              //         color: Color(0xfff2e7fe).withOpacity(0.6),
                              //         height: 2,
                              //       ),
                              //       filled: true,
                              //       fillColor: Color(0xff121212),
                              //       contentPadding: EdgeInsets.symmetric(
                              //           horizontal: 16, vertical: 0),
                              //       enabledBorder: UnderlineInputBorder(
                              //         borderSide:
                              //             BorderSide(color: Color(0xfff2e7fe)),
                              //       ),
                              //       focusedBorder: UnderlineInputBorder(
                              //         borderSide:
                              //             BorderSide(color: Color(0xffBB86fc)),
                              //         //  when the TextFormField in focused
                              //       ),
                              //       border: UnderlineInputBorder()),
                             // ),
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
                                      if(value==null ){
                                        yOffset = 0;
                                        showModalBottomSheet(
                                            context: context,
                                            backgroundColor: Color(0xff292929),
                                            builder: (BuildContext bc) {
                                              return SafeArea(
                                                child: Container(
                                                  height: (MediaQuery.of(context).size.height)*.06,
                                                  child: Container(
                                                    child: Center(child: Text("Enter a valid Dosage",style: style,)),
                                                  ),
                                                ),
                                              );
                                            });
                                      }
                                      yOffset = 0;
                                    },
                                    controller: dosageController,
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
                                      if(value==null ){
                                        yOffset = 0;
                                        showModalBottomSheet(
                                            context: context,
                                            backgroundColor: Color(0xff292929),
                                            builder: (BuildContext bc) {
                                              return SafeArea(
                                                child: Container(
                                                  height: (MediaQuery.of(context).size.height)*.06,
                                                  child: Container(
                                                    child: Center(child: Text("Enter a valid Quantity",style: style,)),
                                                  ),
                                                ),
                                              );
                                            });
                                      }
                                      yOffset = 0;
                                    },
                                    controller: initialQuantityController,
                                    style: TextStyle(color: Color(0xfff2e7fe)),
                                    decoration: InputDecoration(
                                        labelText: AppLocalizations.of(context).translate('Initial_Quantity'),
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
                              height: 20,
                            ),
                            single
                                ? Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Expanded(
                                          child: _choice(
                                              AppLocalizations.of(context).translate('Time_Schedule'), AppLocalizations.of(context).translate('Days_and_Range'), 3)),
                                      Expanded(
                                          child: _choice(
                                              AppLocalizations.of(context).translate('Time'), AppLocalizations.of(context).translate('Timing_and_Intervals'), 2)),
                                    ],
                                  )
                                : SizedBox(
                                    height: 20,
                                  ),
                            SizedBox(
                              height: 20,
                            ),
                            InkWell(
                              onTap: () {
                                flag ? writeRepeatedSchedules(context) : writeSchedule(context);
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
                                    AppLocalizations.of(context).translate('Confirm'),
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
  callImage () async
  {
    imageUrl = await FirebaseStorage.instanceFor(bucket: 'gs://medicine-reminder-406a5.appspot.com/').ref('MedicineImages/${medicineName}.png').getDownloadURL();
    print("IMAGE URL ${imageUrl}");
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
                  Expanded(child: TimeIntervals()),
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
                  // SizedBox(
                  //   height: 10.0,
                  // ),
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
              decoration: BoxDecoration(
                border: Border.all(color: Color(0xffBB86FC), width: 1),
                color: Color(0xff292929),
                borderRadius: BorderRadius.circular(15.0),
              ),
              child: Column(
                children: [
                  Center(
                    child: Text(
                      AppLocalizations.of(context).translate('Set_The_Schedule'),
                      style: TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                        color: Color(0xffF2E7FE),
                      ),
                    ),
                  ),
                  Expanded(
                    child: InkWell(
                      onTap: () => _newMedicine(false),
                      child: TimeIntervals(),
                    ),
                  ),
                ],
              ),
            );
          },
        );
      },
    );
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
                  customCard(Icons.description, AppLocalizations.of(context).translate('Medicine'), AppLocalizations.of(context).translate('Dosage_Details'))),
        ),
      ],
    );
  }
}
