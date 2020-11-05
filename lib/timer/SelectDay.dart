import 'package:flutter/material.dart';

import 'package:medicine_reminder/timer/SingleSelection.dart';
import 'package:medicine_reminder/timer/Timer.dart';

class SelectDay extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {

  List<String> sortFilter = [
    'Daily',
    'Custom',
  ];

  Future navigateToSubPage(context) async {
    Navigator.push(context, MaterialPageRoute(builder: (context) => Timer()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
                backgroundColor: Color(0xfff96060),
                leading: GestureDetector(
                  onTap: () {
                    /* Write listener code here */
                  },
                  child: Icon(
                    Icons.arrow_back_outlined, // add custom icons also
                  ),
                ),
                elevation: 0,
                centerTitle: true,
                title: Text("Select Day", style: TextStyle(
                    fontSize: 30
                ),),
                actions: [
                  IconButton(
                    icon: Icon(Icons.short_text,
                      color: Colors.white,
                      size: 30,
                    ),
                    highlightColor: Colors.transparent,
                    onPressed: () {},
                  )
                ],
              ),
      body: SingleSelection(sortFilter),
      // body: Row(
      //     children: <Widget>[
      //       SingleSelection(sortFilter),
      //       Text("Remind me Everyday"),
      //     ],
      // ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigation),
        backgroundColor: Color(0xfff96060),
        onPressed: () {
          navigateToSubPage(context);
        },
      ),

    );
  }
}

