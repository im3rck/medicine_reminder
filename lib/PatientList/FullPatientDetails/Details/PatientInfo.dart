import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';
import 'package:medicine_reminder/PatientList/datafile.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:medicine_reminder/Backend%20Services/Image%20Handling/ImageHandler.dart';
import 'package:medicine_reminder/Backend%20Services/Image%20Handling/ImageService.dart';

class PatientInfo extends StatefulWidget {
  PatientInfo(this.pno);
  String pno;
  @override
  _PatientInfoState createState() => _PatientInfoState();
}
PickedFile _image;
final ImagePicker _picker = ImagePicker();

class _PatientInfoState extends State<PatientInfo>
    with SingleTickerProviderStateMixin {
  Map c = {
    'patientToken': null,
    'patientName': null,
    'age': null,
    'gender': null,
    'contactNo': null,
    'relationship': null,
  };
  String imageUrl = null;
  fetchImageUrl(String targetPath) async {
    var storage = FirebaseStorage.instanceFor(bucket: 'gs://medicine-reminder-406a5.appspot.com/');

    String tempURL = await storage.ref(targetPath).getDownloadURL();
      setState(() {
        imageUrl = tempURL;
      });
  }
  dataFetch()  async {
    print("Help");
    FirebaseFirestore _newDb = FirebaseFirestore.instance;
    await _newDb
        .collection('/users/uOzQ4baX4CbRy3vnSKCyCJGi7sw1/patients')
        .get()
        .then((QuerySnapshot querySnapshot) => {
      querySnapshot.docs.forEach((doc) {
        if(doc['contactNo']==widget.pno) {
          print(doc['patientName']);
          setState(() {
            c = {
              'patientToken': doc['patientToken'],
              'patientName': doc['patientName'],
              'age': doc['age'],
              'gender': doc['gender'],
              'contactNo': doc['contactNo'],
              'relationship': doc['relationship'],
            };
          });
        }
      print(c); }) });

  }
  AnimationController animationController;
  Animation degOneTranslationAnimation,
      degTwoTranslationAnimation,
      degThreeTranslationAnimation;
  Animation rotationAnimation;

  double getRadiansFromDegree(double degree) {
    double unitRadian = 57.295779513;
    return degree / unitRadian;
  }
  double yOffset = 0;
  TextEditingController fnameController = TextEditingController();
  TextEditingController relController = TextEditingController();
  TextEditingController ageController = TextEditingController();
  TextEditingController genderController = TextEditingController();

  String _value;
  String valueItem;

  void _setText() {
    Map map = {
      'index': Patientdata.length + 1,
      'name': fnameController.text,
      'age': ageController.text,
      'gender': _value,
      'rel': relController.text
    };
    Patientdata.add(map);
  }
  @override
  void initState() {
    dataFetch();
    animationController =
        AnimationController(vsync: this, duration: Duration(milliseconds: 250));
    degOneTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.2), weight: 75.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.2, end: 1.0), weight: 25.0),
    ]).animate(animationController);
    degTwoTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.4), weight: 55.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.4, end: 1.0), weight: 45.0),
    ]).animate(animationController);
    degThreeTranslationAnimation = TweenSequence([
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 0.0, end: 1.75), weight: 35.0),
      TweenSequenceItem<double>(
          tween: Tween<double>(begin: 1.75, end: 1.0), weight: 65.0),
    ]).animate(animationController);
    rotationAnimation = Tween<double>(begin: 180.0, end: 0.0).animate(
        CurvedAnimation(parent: animationController, curve: Curves.easeOut));
    super.initState();
    animationController.addListener(() {
      setState(() {});
    });
  }

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
                //color: Color(0xffbb86fc),
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
                    children: [
                      Container(
                        margin: EdgeInsets.all(
                            (MediaQuery.of(context).size.width) * .03),
                        child: Row(
                          //mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Card(
                              //Image
                              elevation: 20.0,
                              child: Container(
                                height:
                                    (MediaQuery.of(context).size.height) * .2,
                                width:
                                    (MediaQuery.of(context).size.width) * .35,
                                color: Color(0xff323232),
                                child: imageUrl==null? Image.asset('assets/images/usertrans.png'): Image.network(imageUrl),
                              ),
                            ),
                            // SizedBox(
                            //     width:
                            //         (MediaQuery.of(context).size.width) * .28),
                            Column(
                              children: [

                                Stack(
                                  alignment: Alignment.topRight,
                                  children: <Widget>[
                                    IgnorePointer(
                                      child: Container(
                                        //color: Colors.black.withOpacity(0.5), // comment or change to transparent color
                                        height: (MediaQuery.of(context).size.height)*.2,
                                        width: (MediaQuery.of(context).size.height)*.2,
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: Offset.fromDirection(
                                          getRadiansFromDegree(180),
                                          degOneTranslationAnimation.value *
                                              100),
                                      child: Transform(
                                        transform: Matrix4.rotationZ(
                                            getRadiansFromDegree(
                                                rotationAnimation.value))
                                          ..scale(degOneTranslationAnimation
                                              .value),
                                        alignment: Alignment.center,
                                        child: CircularButton(
                                          color: Color(0xff323232),
                                          width: 50,
                                          height: 50,
                                          icon: Icon(
                                            Icons.person,
                                            color: Color(0xffbb86fe),
                                          ),
                                          onClick: () {
                                            _popupCard(context);
                                            print('First Button');
                                          },
                                        ),
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: Offset.fromDirection(
                                          getRadiansFromDegree(135),
                                          degTwoTranslationAnimation.value *
                                              100),
                                      child: Transform(
                                        transform: Matrix4.rotationZ(
                                            getRadiansFromDegree(
                                                rotationAnimation.value))
                                          ..scale(degTwoTranslationAnimation
                                              .value),
                                        alignment: Alignment.center,
                                        child: CircularButton(
                                          color: Color(0xff323232),
                                          width: 50,
                                          height: 50,
                                          icon: Icon(
                                            Icons.camera_alt,
                                            color: Color(0xffbb86fe),
                                          ),
                                          onClick: () {
                                            Navigator.push(
                                                context,
                                                MaterialPageRoute(
                                                    builder: (context) =>
                                              ImageCapture  (
                                                newFile: (File imageFile){
                                                    ImageService _IS = ImageService.PatientImage(imageFile,c['contactNo']);
                                                    // fetchImageUrl('PatientImages/${c['contactNo']}');
                                                   setState(()  {
                                                     callImage();
                                                   });
                                                }
                                            )
                                            ));

                                          },
                                        ),
                                      ),
                                    ),
                                    Transform.translate(
                                      offset: Offset.fromDirection(
                                          getRadiansFromDegree(90),
                                          degThreeTranslationAnimation.value *
                                              100),
                                      child: Transform(
                                        transform: Matrix4.rotationZ(
                                            getRadiansFromDegree(
                                                rotationAnimation.value))
                                          ..scale(degThreeTranslationAnimation
                                              .value),
                                        alignment: Alignment.center,
                                        child: CircularButton(
                                          color: Color(0xff323232),
                                          width: 50,
                                          height: 50,
                                          icon: Icon(
                                            Icons.delete,
                                            color:
                                                Colors.red.withOpacity(0.6),
                                          ),
                                          onClick: () {
                                            openAlertBox(context);
                                            print('Third Button');
                                          },
                                        ),
                                      ),
                                    ),
                                    Transform(
                                      transform: Matrix4.rotationZ(
                                          getRadiansFromDegree(
                                              rotationAnimation.value)),
                                      alignment: Alignment.center,
                                      child: CircularButton(
                                        color: Color(0xff323232),
                                        width: 50,
                                        height: 50,
                                        icon: Icon(
                                          Icons.edit_outlined,
                                          color: Color(0xffbb86fe),
                                        ),
                                        onClick: () {
                                          if (animationController
                                              .isCompleted) {
                                            animationController.reverse();
                                          } else {
                                            animationController.forward();
                                          }
                                        },
                                      ),
                                    )
                                  ],
                                ),
                                // SizedBox(
                                //   height: (MediaQuery.of(context).size.height) *
                                //       .15,
                                // )
                              ],
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: (MediaQuery.of(context).size.height)*.05,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: (MediaQuery.of(context).size.width)*.05,),
                          Text( AppLocalizations.of(context).translate('Name')+" :",
                              style:TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 20,
                                letterSpacing: 0.5,
                                color: Color(0xffbb86fe).withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(width: (MediaQuery.of(context).size.width)*.11,),
                          Text(c['patientName']==null? "": c['patientName'],
                              style:TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 18,
                                letterSpacing: 0.5,
                                color: Color(0xfff2e7fe).withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                      SizedBox(height: (MediaQuery.of(context).size.height)*.025,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: (MediaQuery.of(context).size.width)*.05,),
                          Text(AppLocalizations.of(context).translate('Age')+" :",
                              style:TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 20,
                                letterSpacing: 0.5,
                                color: Color(0xffbb86fe).withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(width: (MediaQuery.of(context).size.width)*.16,),
                          Text(c['age']==null? "": c['age'] ,
                              style:TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 18,
                                letterSpacing: 0.5,
                                color: Color(0xfff2e7fe).withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),

                      SizedBox(height: (MediaQuery.of(context).size.height)*.025,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: (MediaQuery.of(context).size.width)*.05,),
                          Text(AppLocalizations.of(context).translate('Number')+" :",
                              style:TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 20,
                                letterSpacing: 0.5,
                                color: Color(0xffbb86fe).withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(width: (MediaQuery.of(context).size.width)*.05,),
                          Text(c['contactNo']==null? "": c['contactNo'],
                              style:TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 18,
                                letterSpacing: 0.5,
                                color: Color(0xfff2e7fe).withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      ),
                      SizedBox(height: (MediaQuery.of(context).size.height)*.025,),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(width: (MediaQuery.of(context).size.width)*.05,),
                          Text(AppLocalizations.of(context).translate('Relationship')+" :",
                              style:TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 20,
                                letterSpacing: 0.5,
                                color: Color(0xffbb86fe).withOpacity(0.8),
                                fontWeight: FontWeight.bold,
                              )),
                          SizedBox(width: (MediaQuery.of(context).size.width)*.05,),
                          Text(c['relationship']==null? "" : c['relationship'],
                              style:TextStyle(
                                fontFamily: 'Circular',
                                fontSize: 18,
                                letterSpacing: 0.5,
                                color: Color(0xfff2e7fe).withOpacity(0.8),
                                fontWeight: FontWeight.w600,
                              )),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
  callImage () async
  {
    imageUrl = await FirebaseStorage.instanceFor(bucket: 'gs://medicine-reminder-406a5.appspot.com/').ref('PatientImages/${c['contactNo']}.png').getDownloadURL();
    print("IMAGE URL ${imageUrl}");
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
                              width: (MediaQuery.of(context).size.width) * .9,
                              child: TextField(
                                keyboardType: TextInputType.name,
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
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Container(
                                  width: (MediaQuery.of(context).size.width)*.5,
                                  child: TextField(
                                    keyboardType: TextInputType.number,
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
                                  height: (MediaQuery.of(context).size.height)*.08,

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
                                keyboardType: TextInputType.phone,
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
                               // _setText();
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
  openAlertBox(BuildContext context) {
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
                    padding: EdgeInsets.all(16),
                    child: Center(
                      child: Text(
                        "Remove this Patient?",
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

  Widget _buildAppBar() {
    Color appBarIconsColor = Color(0xFF292929);
    return AppBar(
      shadowColor: Color(0xff292929),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Color(0xffBB86Fe)),
        onPressed: () {
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
        child: Text(
          'Details',
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Circular',
            fontSize: 20,
            letterSpacing: 0.5,
            color: Color(0xffbb86fe),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}

class CircularButton extends StatelessWidget {
  final double width;
  final double height;
  final Color color;
  final Icon icon;
  final Function onClick;

  CircularButton(
      {this.color, this.width, this.height, this.icon, this.onClick});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(color: color, shape: BoxShape.circle),
      width: width,
      height: height,
      child: IconButton(icon: icon, enableFeedback: true, onPressed: onClick),
    );
  }
}
