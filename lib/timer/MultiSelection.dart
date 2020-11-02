import 'package:flutter/material.dart';

import 'package:medicine_reminder/timer/days.dart';

class MultiSelection extends StatefulWidget {
  final List<Days> wantedDays;

  MultiSelection(this.wantedDays);

  @override
  _MultiSelectionState createState() => _MultiSelectionState();
}

class _MultiSelectionState extends State<MultiSelection> {

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            widget.wantedDays[index].isSelected = !widget.wantedDays[index].isSelected;
            setState(() {});
          },
          child: Container(
            color: widget.wantedDays[index].isSelected
                ? Colors.white
                : null,
            child: Row(
              children: <Widget>[
                Checkbox(
                    value: widget.wantedDays[index].isSelected,
                    onChanged: (s) {
                      widget.wantedDays[index].isSelected = !widget.wantedDays[index].isSelected;
                      setState(() {});
                    }),
                Text(widget.wantedDays[index].day)
              ],
            ),
          ),
        );
      },
      itemCount: widget.wantedDays.length,
    );
  }
}