import 'package:flutter/material.dart';

import 'package:medicine_reminder/Timer/SelectDay/MultiSelection.dart';

class SingleSelection extends StatefulWidget {
  final List<String> optionList = [
    'DAILY',
    'CUSTOM',
  ];
  final updateIndices;

  SingleSelection({Key key, this.updateIndices}) : super(key: key);

  @override
  _SingleSelectionState createState() => _SingleSelectionState();
}

class _SingleSelectionState extends State<SingleSelection> {
  String selectedValue;
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    selectedValue = widget.optionList.first;
  }

  String selectedDays = '    MON '
      ' TUE '
      ' WED '
      ' THU '
      ' FRI '
      ' SAT '
      ' SUN ';

  void openDialog(int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              shape: RoundedRectangleBorder(
                  borderRadius: new BorderRadius.circular(15)),
              title: Text('DAYS'),
              content: Container(
                  width: 250,
                  height: 340,
                  child: MultiSelection(
                      updateDays: listChange, updateIndices: getIndices)),
            ),
          );
        });
  }

  Widget customRadioString(String txt, int index) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: <Widget>[
          OutlineButton(
            onPressed: () {
              changeIndex(index);
              if (index == 1) {
                openDialog(index);
                selectedDays = '   ';
              } else {
                var list = Iterable<int>.generate(7).toList();
                getIndices(list);
                selectedDays = '    MON '
                    ' TUE '
                    ' WED '
                    ' THU '
                    ' FRI '
                    ' SAT '
                    ' SUN ';
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            borderSide: BorderSide(
                color: selectedIndex == index ? Colors.cyan : Colors.grey),
            child: Text(
              txt,
              style: TextStyle(
                  color: selectedIndex == index ? Colors.cyan : Colors.grey),
            ),
          ),
          Container(
            width: 250,
            child: showDailyMsg(index),
          )
        ],
      ),
    );
  }

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
    });
  }

  void listChange(String updateSelectedDays) {
    var ok = selectedDays.contains(updateSelectedDays);
    if (!ok)
      setState(() {
        selectedDays = selectedDays + updateSelectedDays;
      });
  }

  void getIndices(List<int> list) {
    widget.updateIndices(list);
  }

  Widget showDailyMsg(int index) {
    List<TextSpan> _getSelected() {
      final String daily = '    REMIND ME EVERYDAY ';

      List<TextSpan> selected = [];

      if (index == 0)
        selected.add(TextSpan(text: daily));
      else
        selected.add(TextSpan(text: selectedDays));
      return selected;
    }

    final style = TextStyle(
      color: selectedIndex == index ? Colors.cyan : Colors.grey,
    );
    final selected = _getSelected();

    return RichText(
      text: TextSpan(
        style: style,
        children: selected,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        // return a row with container and another widget if you want to add
        // something else
        return Container(
          padding: EdgeInsets.all(20),
          color:
              selectedValue == widget.optionList[index] ? Colors.white : null,
          child: Row(
            children: <Widget>[
              customRadioString(widget.optionList[index], index),
            ],
          ),
        );
      },
      itemCount: widget.optionList.length,
    );
  }
}
