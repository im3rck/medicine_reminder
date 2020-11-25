import 'package:flutter/material.dart';

import 'Cards.dart';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_reminder/PatientController/Connection/Connection.dart';
import 'package:medicine_reminder/PatientController/MedicineList/MedicineList.dart';
import 'package:medicine_reminder/PatientController/Cards/customCard.dart';
import 'package:medicine_reminder/PatientList/datafile.dart';

PickedFile _image;
final ImagePicker _picker = ImagePicker();

class Details extends StatefulWidget {
  _Details createState() => _Details();
}

class _Details extends State<Details> {
  TextEditingController fnameController = TextEditingController();
  TextEditingController relController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  String _value;
  String valueItem;

  void _setText() {
    print(_value);
    Map map = {
      'index': patientData.length + 1,
      'name': fnameController.text,
      'age': ageController.text,
      'gender': _value,
      'rel': relController.text
    };
    patientData.add(map);
  }

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

  void _showPicker(context) {
    showModalBottomSheet(
        context: context,
        backgroundColor: Color(0xff292929),
        builder: (BuildContext bc) {
          return SafeArea(
            child: Container(
              child: new Wrap(
                children: <Widget>[
                  new ListTile(
                      leading: new Icon(Icons.photo_library,
                          color: Color(0xfff2e7fe)),
                      title: new Text(
                        'Photo Library',
                        style: TextStyle(
                          fontFamily: 'Circular',
                          fontSize: 16,
                          color: Color(0xffF2E7FE),
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      onTap: () {
                        _imgFromGallery();
                        Navigator.of(context).pop();
                      }),
                  new ListTile(
                    leading:
                        new Icon(Icons.photo_camera, color: Color(0xfff2e7fe)),
                    title: new Text(
                      'Camera',
                      style: TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 16,
                        color: Color(0xffF2E7FE),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
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
                        Column(
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
                                controller: fnameController,
                                style: TextStyle(color: Color(0xfff2e7fe)),
                                decoration: InputDecoration(
                                    labelText: 'Name',
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
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              // width: (MediaQuery.of(context).size.width) * .9,
                              // width: (MediaQuery.of(context).size.width) * .9,
                              children: [
                                Container(
                                  width: 250,
                                  child: TextField(
                                    onTap: () {
                                      yOffset = -210;
                                    },
                                    onSubmitted: (value) {
                                      yOffset = 0;
                                    },
                                    controller: ageController,
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
                                Container(
                                  height: 63,
                                  child: DropdownButton(
                                    hint: Text("Gender",
                                        style: TextStyle(
                                          fontFamily: 'Circular',
                                          fontSize: 16,
                                          color: Color(0xffF2E7FE),
                                          fontWeight: FontWeight.bold,
                                        )),
                                    value: _value,
                                    dropdownColor: Color(0xff292929),
                                    iconEnabledColor: Color(0xFF3EB16F),
                                    onChanged: (newValue) {
                                      setState(() {
                                        _value = newValue;
                                      });
                                    },
                                    items: ['Male', 'Female', 'Other']
                                        .map((valueItem) {
                                      return new DropdownMenuItem(
                                        value: valueItem,
                                        child: new Text(valueItem,
                                            style: TextStyle(
                                              fontFamily: 'Circular',
                                              fontSize: 16,
                                              color: Color(0xffF2E7FE),
                                              fontWeight: FontWeight.bold,
                                            )),
                                      );
                                    }).toList(),
                                  ),
                                )
                              ],
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
                                controller: relController,
                                style: TextStyle(color: Color(0xfff2e7fe)),
                                decoration: InputDecoration(
                                    labelText: 'Relationship',
                                    prefixIcon: Icon(
                                      Icons.people_outline_rounded,
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
                                _setText();
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
                                      fontFamily: 'Circular',
                                      fontSize: 16,
                                      color: Color(0xffF2E7FE),
                                      fontWeight: FontWeight.bold,
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

  @override
  Widget build(BuildContext context) {
    return Row(
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
    );
  }
}
