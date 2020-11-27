import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

List<String> intervalItems = [];

class Test extends StatefulWidget {
  _Test createState() => _Test();
}

class _Test extends State<Test> {
  TimeOfDay _time = TimeOfDay(hour: 0, minute: 00);

  String convertTime(String minutes) {
    if (minutes.length == 1) {
      return "0" + minutes;
    } else {
      return minutes;
    }
  }

  Future<TimeOfDay> _selectTime(BuildContext context) async {
    final TimeOfDay picked = await showTimePicker(
        context: context,
        initialTime: _time,
        builder: (BuildContext context, Widget child) {
          return Theme(
            data: ThemeData.dark().copyWith(
                colorScheme: ColorScheme.dark(
                  primary: Color(0xffbb86fe),
                  onPrimary: Color(0xff121212),
                  surface: Color(0xff121212),
                  onSurface: Color(0xfff2e7fe),
                ),
                buttonTheme:
                    ButtonThemeData(textTheme: ButtonTextTheme.primary),
                dialogBackgroundColor: Color(0xffbb86fe)),
            child: child,
          );
        });
    if (picked != null && picked != _time) {
      setState(() {
        _time = picked;
        intervalItems.add(
            "${convertTime(_time.hour.toString())}:${convertTime(_time.minute.toString())}");
      });
    }
    return picked;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          SizedBox(height: 300),
          FloatingActionButton.extended(
            onPressed: () {
              _selectTime(context);
            },
            icon: Icon(Icons.add),
            backgroundColor: Color(0xff292929),
            foregroundColor: Color(0xffbb86fe),
            label: Text(
              "Interval",
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'Circular',
                fontWeight: FontWeight.bold,
                color: Color(0xffF2E7FE),
              ),
            ),
          ),
          SizedBox(height: 100),

          new Expanded(
              child: new ListView.builder(
                  itemCount: intervalItems.length,
                  itemBuilder: (BuildContext ctx, int index) {
                    return new Container(
                      alignment: Alignment.center,
                      child: Card(
                        elevation: 10.0,
                        margin: new EdgeInsets.symmetric(
                            horizontal: 10.0, vertical: 10.0),
                        child: Slidable(
                          child: Container(
                            decoration: BoxDecoration(
                              color: Color(0xff292929),
                            ),
                            child: ListTile(
                              leading: Container(
                                margin: EdgeInsets.symmetric(
                                    horizontal: 10, vertical: 10.0),
                                height: 20,
                                width: 20,
                                decoration: BoxDecoration(
                                    color: Color(0xff292929),
                                    shape: BoxShape.circle,
                                    border: Border.all(
                                        color: Color(0xffbb86fe),
                                        width: 4)),
                              ),
                              title: Text(
                                intervalItems[index],
                                style: TextStyle(
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xfff2e7fe),
                                  height: 2,
                                ),
                              ),
                              trailing: Container(
                                height: 50,
                                width: 5,
                                color: Color(0xffbb86fe),
                              ),
                            ),
                          ),
                          actionPane: SlidableBehindActionPane(),
                          secondaryActions: <Widget>[
                            IconSlideAction(
                              caption: 'Delete',
                              color: Colors.red,
                              icon: Icons.delete,
                              onTap: () {
                                intervalItems.removeAt(index);
                                // Navigator.pop(context);
                                // _timeInterval();
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  })),

        ],
      ),
    );
  }
}
