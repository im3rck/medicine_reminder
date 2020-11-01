import 'package:flutter/material.dart';
import 'package:medicine_reminder/Widgets/variables.dart';

class NewPatient2 extends StatefulWidget{
  @override
  _NewPatient2State createState() => _NewPatient2State();
}
String _selected;

class _NewPatient2State extends State<NewPatient2>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomPadding: false,
      backgroundColor: Colors.white,
        appBar: AppBar(
        backgroundColor: Colors.green,
        iconTheme: IconThemeData(
        color: Colors.redAccent,
    ),
           centerTitle: true,
            title: Text(
                  "Add New MedReminder",
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 18,
              ),
          ),
          elevation: 0.0,
        ),
      body: Container(
        child: ListView(
          padding: EdgeInsets.symmetric(horizontal: 25),
          children: <Widget>[
          SizedBox(height: 100,),
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
            SizedBox(height: 8,),


          ],
        ),

      ),

    );
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

