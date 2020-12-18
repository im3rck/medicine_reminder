import 'package:flutter/material.dart';
import 'package:flutter_typeahead/flutter_typeahead.dart';
import 'package:http/http.dart' as http;
import 'dart:async';
import 'dart:convert';

import 'package:medicine_reminder/Enhancements/LanguageConfig/AppLocalizations.dart';

class AutoComplete extends StatefulWidget {
  AutoComplete({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _AutoCompleteState createState() => _AutoCompleteState();
}

class UserDetail {
  final int id;
  final String title;
  final String url;

  UserDetail({this.id, this.title, this.url});
}

class _AutoCompleteState extends State<AutoComplete> {
  int _counter = 0;
  final TextEditingController _typeAheadController = TextEditingController();

  static List<UserDetail> _det = [];

  Future<List<UserDetail>> _getUsers() async {
    String url = 'https://jsonplaceholder.typicode.com/photos';
    var data = await http.get(url);
    var jsonData = json.decode(data.body);
    List<UserDetail> users = [];
    for (var item in jsonData) {
      UserDetail user =
          UserDetail(id: item['id'], title: item['title'], url: item['thumbnailUrl']);
      users.add(user);
    }
    print(users.length);
    _det = users;
    return users;
  }

  static List<UserDetail> getSuggestions(String query) {
    List<UserDetail> matches = [];
    matches.addAll(_det);
    matches.retainWhere(
        (UserDetail s) => s.title.toLowerCase().contains(query.toLowerCase()));
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

                  direction: AxisDirection.up,
                  textFieldConfiguration: TextFieldConfiguration(
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
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(30.0),
                                    child: Image(
                                      image: NetworkImage(suggestion.url,
                                          scale: 3),
                                    ),
                                  )),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.all(10.0),
                                  child: Text(
                                    suggestion.title,
                                    style: TextStyle(
                                        color: Color(0xfff2e7fe),
                                        fontFamily: 'Circular',
                                        fontSize: 15),
                                  ),
                                ),
                              ),
                              Padding(
                                padding:
                                    const EdgeInsets.fromLTRB(50.0, 10, 10, 10),
                                child: Text(suggestion.id.toString(),
                                    style: TextStyle(
                                        color: Color(0xfff2e7fe),
                                        fontFamily: 'Circular',
                                        fontSize: 15)),
                              )
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                  onSuggestionSelected: (suggestion) {
                    this._typeAheadController.text = suggestion;
                  }),
            ),
          );
        });
  }
}
