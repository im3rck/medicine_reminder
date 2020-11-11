import 'package:flutter/material.dart';

import 'package:medicine_reminder/Timer/days.dart';

class MultiSelection extends StatefulWidget {
  final List<Days> wantedDays = [
    Days('Monday'),
    Days('Tuesday'),
    Days('Wednesday'),
    Days('Thursday'),
    Days('Friday'),
    Days('Saturday'),
    Days('Sunday'),
  ];
  final customFunction;

  MultiSelection({Key key, this.customFunction}) : super(key: key);

  @override
  _MultiSelectionState createState() => _MultiSelectionState();
}

class _MultiSelectionState extends State<MultiSelection> {
  List<int> selectedDays = [];

  void addDays(List<int> list) {
    list.sort();
    list.forEach((element) {
      switch (element) {
        case 0:
          widget.customFunction(' Mon ');
          break;
        case 1:
          widget.customFunction(' Tue ');
          break;
        case 2:
          widget.customFunction(' Wed ');
          break;
        case 3:
          widget.customFunction(' Thu ');
          break;
        case 4:
          widget.customFunction(' Fri ');
          break;
        case 5:
          widget.customFunction(' Sat ');
          break;
        case 6:
          widget.customFunction(' Sun ');
          break;
      }
    });
  }

  bool _selected = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        Expanded(
          child: ListView.builder(
            itemBuilder: (ctx, index) {
              return SizedBox(
                height: 40.0,
                width: 40.0,
                child: CheckboxListTile(
                    title: Text(widget.wantedDays[index].day),
                    controlAffinity: ListTileControlAffinity.leading,
                    contentPadding: EdgeInsets.all(0),
                    value: widget.wantedDays[index].isSelected,
                    onChanged: (val) {
                      widget.wantedDays[index].isSelected =
                          !widget.wantedDays[index].isSelected;
                      setState(() {
                        if (val)
                          selectedDays.add(index);
                        else
                          selectedDays.remove(index);
                      });
                    }),
              );
            },
            itemCount: widget.wantedDays.length,
          ),
        ),
        ButtonTheme(
          padding: EdgeInsets.zero,
          //adds padding inside the button
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          //limits the touch area to the button area
          minWidth: 250,
          //wraps child's width
          height: 35,
          //wraps child's height
          child: FlatButton(
            // shape: RoundedRectangleBorder(
            //     borderRadius: new BorderRadius.circular(15)),
            padding: EdgeInsets.zero,
            onPressed: () {
              addDays(selectedDays);
              Navigator.of(context, rootNavigator: true).pop();
            },
            child: Text(
              'Ok',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            color: Colors.redAccent,
            textColor: Colors.white,
          ), //your original button
        ),
      ],
    );
  }
}
