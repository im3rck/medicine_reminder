import 'package:flutter/material.dart';

import 'package:medicine_reminder/Timer/SelectDay/SingleSelection.dart';
import 'package:medicine_reminder/Timer/SelectTime/SelectTime.dart';

class SelectDay extends StatelessWidget {
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
  List<int> returnedIndices = [];

  Future navigateToSubPage(context) async {
    Navigator.push(context,
        MaterialPageRoute(builder: (context) => Timer(returnedIndices)));
  }

  void getIndices(List<int> list) {
    returnedIndices = list;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color(0xff3196ae),
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
        title: Text(
          "Select Day",
          style: TextStyle(fontSize: 30),
        ),
        actions: [
          IconButton(
            icon: Icon(
              Icons.short_text,
              color: Colors.white,
              size: 30,
            ),
            highlightColor: Colors.transparent,
            onPressed: () {},
          )
        ],
      ),
      // body: SingleSelection(updateIndices: getIndices),
      body: Stack(
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: 70,
                color: Color(0xff3196ae),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            // changeFilter("Time");
                          },
                          child: Text(
                            "Time",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 4,
                          width: 120,
                          // color: (filterType == "Time")
                          //     ? Colors.white
                          //     : Colors.transparent,
                        )
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        InkWell(
                          onTap: () {
                            // changeFilter("Schedule");
                          },
                          child: Text(
                            "Schedule",
                            style: TextStyle(color: Colors.white, fontSize: 18),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Container(
                          height: 4,
                          width: 120,
                          // color: (filterType == "Schedule")
                          //     ? Colors.white
                          //     : Colors.transparent,
                        )
                      ],
                    )
                  ],
                ),
              ),
              // if (filterType == "Schedule")
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 30,
                        ),
                        Row(
                          children: [
                            SizedBox(
                              width: 15,
                            ),
                            Container(
                                margin: const EdgeInsets.all(6.0),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "Multiple Dates",
                                  // style: myStyle(16),
                                )),
                            Center(
                              child: Switch(
                                value: true,
                                onChanged: (value) {
                                  setState(() {
                                    // isSwitched = value;
                                    // print(isSwitched);
                                  });
                                },
                                activeTrackColor: Colors.grey,
                                activeColor: Colors.lightBlue,
                              ),
                            ),
                            Container(
                                margin: const EdgeInsets.all(6.0),
                                padding: const EdgeInsets.all(10.0),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50.0),
                                  color: Colors.white,
                                  boxShadow: [
                                    BoxShadow(
                                      color: Colors.grey,
                                      offset: Offset(0.0, 1.0), //(x,y)
                                      blurRadius: 6.0,
                                    ),
                                  ],
                                ),
                                child: Text(
                                  "Range of Dates",
                                  // style: myStyle(16),
                                )),
                          ],
                        ),
                        SizedBox(
                          height: 30,
                        ),
                        // _calendarType(),
                      ],
                    ),
                  ),
                ),
              // if (filterType == "Time")
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Center(
                          child: Container(
                            child: SelectTime(),
                          ),
                        )
                      ],
                    ),
                  ),
                )
            ],
          ),
        ],
      ),
      backgroundColor: Colors.white,
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.navigation),
        backgroundColor: Color(0xff3196ae),
        onPressed: () {
          navigateToSubPage(context);
        },
      ),
    );
  }
}
