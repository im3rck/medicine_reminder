import 'package:flutter/material.dart';

import 'package:medicine_reminder/timer/days.dart';

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
  void addDays(int index) {
    switch (index) {
      case 0:
        {
          widget.customFunction(' Mon ');
        }
        break;
      case 1:
        {
          widget.customFunction(' Tue ');
        }
        break;
      case 2:
        {
          widget.customFunction(' Wed ');
        }
        break;
      case 3:
        {
          widget.customFunction(' Thu ');
        }
        break;
      case 4:
        {
          widget.customFunction(' Fri ');
        }
        break;
      case 5:
        {
          widget.customFunction(' Sat ');
        }
        break;
      case 6:
        {
          widget.customFunction(' Sun ');
        }
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            widget.wantedDays[index].isSelected =
                !widget.wantedDays[index].isSelected;
            setState(() {
              addDays(index);
            });
          },
          child: Container(
            color: widget.wantedDays[index].isSelected ? Colors.white : null,
            child: Row(
              children: <Widget>[
                Checkbox(
                    value: widget.wantedDays[index].isSelected,
                    onChanged: (val) {
                      widget.wantedDays[index].isSelected =
                          !widget.wantedDays[index].isSelected;
                      setState(() {
                        if (val) addDays(index);
                      });
                    }),
                Text(widget.wantedDays[index].day),
              ],
            ),
          ),
        );
      },
      itemCount: widget.wantedDays.length,
    );
  }
}
