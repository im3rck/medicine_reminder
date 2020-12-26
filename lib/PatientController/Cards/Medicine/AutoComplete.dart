import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'package:medicine_reminder/Backend%20Services/Services/cF_Services.dart';
import 'dart:async';
import 'dart:convert';

import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/MedicineDescription.dart';
import 'package:medicine_reminder/PatientController/Cards/Medicine/scheduleData.dart';

class AutoComplete extends StatefulWidget {
  AutoComplete({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AutoCompleteState createState() => _AutoCompleteState();
}

class UserDetail {
  final String id;
  final String title;


  UserDetail({this.id, this.title});
}

class _AutoCompleteState extends State<AutoComplete> {

  final TextEditingController _typeAheadController = TextEditingController();

  FirestoreServices _fS = new FirestoreServices.test();

  List<MedicineDB> medList;

  static List<UserDetail> _det = [];


  obtainData() async {
    medList =  await _fS.getMedicineFromDataBase().first;
  }

  void initState(){
    super.initState();
    obtainData();
  }

  Future<List<UserDetail>> _getUsers() async {
    // String url = 'https://jsonplaceholder.typicode.com/photos';
    // var data = await http.get(url);
    // var jsonData = json.decode(data.body);
    //medList.forEach((element) { print('AAAAAAAAA ${element.MedName} ${element.Type}');});
    List<UserDetail> users = [];
    medList.forEach((element) {
      var temp = element.toMap();
      UserDetail user =  UserDetail(id: temp['MedName'], title: temp['Type']);
      users.add(user);
    });


    print(users.length);
    _det = users;
    return users;
  }

  static List<UserDetail> getSuggestions(String query) {
    List<UserDetail> matches = [];
    matches.addAll(_det);
    matches.retainWhere(
            (UserDetail s) => s.id.toLowerCase().contains(query.toLowerCase()));
    return matches;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: _getUsers(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: ListTile(
              title: TypeAheadField(
                autoFlipDirection: true,
                  direction: AxisDirection.up,

                  textFieldConfiguration: TextFieldConfiguration(
                    onSubmitted: (value){
                      medicineName=value;
                    },
                    style: TextStyle(color: Color(0xfff2e7fe)),
                    decoration: InputDecoration(
                        labelText: AppLocalizations.of(context)
                            .translate('Medicine_Name'),
                        labelStyle: TextStyle(
                          fontSize: 16,
                          fontFamily: 'Circular',
                          color: Color(0xfff2e7fe).withOpacity(0.6),
                          height: 2,
                        ),
                        contentPadding:
                        EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                        enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xfff2e7fe)),
                        ),
                        focusedBorder: UnderlineInputBorder(
                          borderSide: BorderSide(color: Color(0xffBB86fc)),
                          //  when the TextFormField in focused
                        ),
                        border: UnderlineInputBorder()),
                    controller: this._typeAheadController,
                  ),
                  suggestionsCallback: (pattern) async {
                    return await getSuggestions(pattern);
                  },
                  transitionBuilder: (context, suggestionsBox, controller) {
                    return suggestionsBox;
                  },
                  itemBuilder: (context, UserDetail suggestion) {
                   // print('ABCD : ${suggestion.title} ${suggestion.id}');
                    return Container(
                      color: Color(0xff292929),
                      child: Padding(
                        padding: EdgeInsets.all(10.0),
                        child: Card(
                          color: Color(0xff323232),
                          elevation: 20,
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: <Widget>[
                              Padding(
                                  padding: EdgeInsets.fromLTRB(3, 5, 10, 2),
                                  child: Container(
                                    height: MediaQuery.of(context).size.height*.01,
                                    width: MediaQuery.of(context).size.height*.01,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(30.0),
                                      child: Image(
                                        image: AssetImage('assets/images/usertrans.png'),
                                        fit: BoxFit.contain,
                                      ),
                                    ),
                                  )),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    suggestion.id,
                                    style: TextStyle(
                                        color: Color(0xfff2e7fe),
                                        fontFamily: 'Circular',
                                        fontSize: 10),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                const EdgeInsets.fromLTRB(50.0, 10, 10, 10),
                                child: Text(suggestion.title == null ? 'Value': suggestion.title,
                                    style: TextStyle(
                                        color: Color(0xfff2e7fe),
                                        fontFamily: 'Circular',
                                        fontSize: 10)),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    this._typeAheadController.text = suggestion.id;
                    print('value : ${_typeAheadController.text}');
                    medicineName = _typeAheadController.text;
                  }),
            ),
          );
        });
  }
}
