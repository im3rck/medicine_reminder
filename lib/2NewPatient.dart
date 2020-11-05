import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medicine_reminder/timer/Timer.dart';
import 'package:medicine_reminder/Widgets/variables.dart';


class NewPatient2 extends StatefulWidget{
  @override
  _NewPatient2State createState() => _NewPatient2State();
}
String _selected;


class _NewPatient2State extends State<NewPatient2>{
  PickedFile _image;
  final ImagePicker _picker = ImagePicker();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Color(0xfff96060),
        iconTheme: IconThemeData(
        color: Color(0xfff96060),
    ),
           centerTitle: true,
            title: Text(
                  "Add New MedReminder",
                  style: TextStyle(
                      color: Colors.white,
                      fontSize: 18,
              ),
          ),
          elevation: 0.0,
        ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: <Widget>[
          SizedBox(height: 50,),
            Container(
              child: Text("Medicine Name *", style: myStyle(16),),
            ),
          Container(
            width: MediaQuery.of(context).size.width,
            margin: EdgeInsets.symmetric(horizontal: 30),
            child: TextField(
               maxLength: 12,
               decoration: InputDecoration(
                 border: UnderlineInputBorder(),
                fillColor: Colors.white30,
                filled: true,
                labelText: 'Name',
                prefixIcon: Icon(Icons.notes, color: Colors.blueGrey,),
                labelStyle: myStyle(16,Colors.blueGrey),
              )
          ),
        ),
            Container(
              child: MedicineType(),
            ),
            Padding(
              padding: EdgeInsets.only(top: 8.0),
                child: Container(
                  child: Row(
                      children: <Widget>[
                        Text(
                          "Dosage in  ", style: myStyle(16),
                        ),
                        if (_selected == 'Pill' || _selected == 'Tablet')
                          Column(
                            children: [
                              Text('numbers'),
                            ],
                          )
                        else
                          if (_selected == 'Bottle' || _selected == 'Syringe')
                            Column(
                              children: [
                                Text('mL'),
                              ],
                            )
                        else
                          Column(
                              children: [
                              Text('Dosage Format'),
                              ],
                              ),
                      ]
                  ),
                ),
              ),
            Container(
              width: MediaQuery.of(context).size.width,
              margin: EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                  decoration: InputDecoration(
                    border: UnderlineInputBorder(),
                    fillColor: Colors.white30,
                    filled: true,
                    labelText: _selected,
                    prefixIcon: Icon(Icons.add, color: Colors.blueGrey,),
                    labelStyle: myStyle(16,Colors.blueGrey),
                  )
              ),
            ),
            SizedBox(height: 16,),
            Container(
              child: Text("Sample *", style: myStyle(16),),
            ),
            SizedBox(height: 4,),
            Container(
            child: Center(
              child: GestureDetector(
                onTap: () {
                  _showPicker(context);
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12.0),
                  child: _image != null
                      ? ClipRRect(
                    borderRadius: BorderRadius.circular(12),
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
                      borderRadius: BorderRadius.circular(12),
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
            )
      ),
            SizedBox(height: 40,),
            GestureDetector(
              onTap: (){
                navigateToTimer(context);
              },
              child: Container(
                alignment: Alignment.center,
                width: MediaQuery.of(context).size.width,
                padding: EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                    color: Color(0xfff96060),
                    borderRadius: BorderRadius.circular(30)
                ),
                child: Text("Set the Routine",style: myStyle(16,Colors.white),),
              ),
            ),
          ],
        ),

      ),

    );

  }
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
        }
    );
  }
  _imgFromCamera() async {
   final PickedFile image = await _picker.getImage(
        source: ImageSource.camera, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }

  _imgFromGallery() async {
    PickedFile image = await  _picker.getImage(
        source: ImageSource.gallery, imageQuality: 50
    );

    setState(() {
      _image = image;
    });
  }


}
class MedicineType extends StatefulWidget{
  @override
  _MedicineTypeState createState() => _MedicineTypeState();
}

class _MedicineTypeState extends State<MedicineType>{
  List<String> _type = ['Pill', 'Bottle', 'Syringe', 'Tablet'];
  String _selectedType = '0';
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 8.0),
      child: Container(
        child: Row(
          children: <Widget>[
            Text(
              "Medicine Type:  ", style: myStyle(16),
            ),
            DropdownButton(
              iconEnabledColor: Color(0xFF3EB16F),
              hint: _selectedType == '0' ? Text (
                "Type", style: myStyle(16),
              ) : null,
              elevation: 4,
              value: _selectedType == '0' ? null : _selectedType,
              items: _type.map((String value){
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(
                    value, style: myStyle(16),
                  ),
                );
              }).toList(),
              onChanged: (newVal){
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

Future navigateToTimer(context) async {
  Navigator.push(context, MaterialPageRoute(builder: (context) => Timer()));
}

