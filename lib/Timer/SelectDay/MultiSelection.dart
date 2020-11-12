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
  final updateDays;
  final updateIndices;

  MultiSelection({Key key, this.updateDays, this.updateIndices})
      : super(key: key);

  @override
  _MultiSelectionState createState() => _MultiSelectionState();
}

class _MultiSelectionState extends State<MultiSelection> {
  List<int> selectedDays = [];

  void addDays(List<int> list) {
    list.sort();
    widget.updateIndices(list);
    list.forEach((element) {
      switch (element) {
        case 0:
          widget.updateDays(' MON ');
          break;
        case 1:
          widget.updateDays(' TUE ');
          break;
        case 2:
          widget.updateDays(' WED ');
          break;
        case 3:
          widget.updateDays(' THU ');
          break;
        case 4:
          widget.updateDays(' FRI ');
          break;
        case 5:
          widget.updateDays(' SAT ');
          break;
        case 6:
          widget.updateDays(' SUN ');
          break;
      }
    });
  }

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
            padding: EdgeInsets.zero,
            onPressed: () {
              if (selectedDays.isNotEmpty) {
                addDays(selectedDays);
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            child: Text(
              'OK',
              style: TextStyle(fontSize: 18.0, color: Colors.white),
            ),
            color: Color(0xff3196ae),
            textColor: Colors.white,
          ), //your original button
        ),
      ],
    );
  }
}
