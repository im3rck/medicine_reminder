import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;
  List<Map> snapshot = [
    {"first_name": "abc"},
    {"first_name": "def"}
  ];
  bool isChecked = false;

  void _incrementCounter() async {
    await showDialog<void>(
        context: context,
        builder: (BuildContext context) {
          return StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {

              return Dialog(
                shape: RoundedRectangleBorder(
                    borderRadius: new BorderRadius.circular(15)),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    Container(
                      padding: EdgeInsets.all(12),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        color: Colors.grey[300],
                        borderRadius: new BorderRadius.only(
                            topLeft: const Radius.circular(15),
                            topRight: const Radius.circular(15)),
                      ),
                      child: Text(
                        "Select Students",
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.w600),
                      ),
                    ),
                    Container(
                      width: 300,
                      height: 400,
                      child: ListView(
                        //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[

                          for (var item in snapshot)
                          //Text(item['first_name'])
                            Row(
                              children: [
                                /*SizedBox(
                                  width: 100.0,
                                  height: 100.0,
                                  child: Image.asset('assets/newlogo.png'),
                                ),*/
                                Text(item['first_name']),
                                Checkbox(
                                  value: isChecked,
                                  onChanged: (bool value) {
                                    print(isChecked);
                                    setState(() {
                                      isChecked = value;
                                    });
                                  },
                                ),
                              ],
                            ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: <Widget>[
                        RaisedButton(
                          color: Colors.blue,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Okay',
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        ),
                        SizedBox(
                          width: 20,
                        ),
                        RaisedButton(
                          color: Colors.red,
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          child: Text(
                            'Cancel!',
                            style:
                            TextStyle(fontSize: 18.0, color: Colors.white),
                          ),
                        )
                      ],
                    ),
                  ],
                ),
              );
            },
          );
        });
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.display1,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: Icon(Icons.add),
      ),
    );
  }
}