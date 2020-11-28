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
    if (list.length == 7)
      widget.updateDays(' REMIND ME EVERYDAY ');
    else if (list.contains(5) && list.contains(6) && list.length == 2)
      widget.updateDays(' REMIND ME WEEKENDS ');
    else
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
                    title: Text(widget.wantedDays[index].day,
                        style: TextStyle(
                            fontFamily: 'Circular',
                            fontSize: 16,
                            color: Colors.white,
                            fontWeight: FontWeight.bold)),
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
          materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
          minWidth: 250,
          height: 35,
          child: FlatButton(
            padding: EdgeInsets.zero,
            onPressed: () {
              if (selectedDays.isNotEmpty) {
                addDays(selectedDays);
                Navigator.of(context, rootNavigator: true).pop();
              }
            },
            child: Text('OK',
                style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 16,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            color: Color(0xffBB86FC),
            textColor: Colors.white,
          ), //your original button
        ),
      ],
    );
  }
}
