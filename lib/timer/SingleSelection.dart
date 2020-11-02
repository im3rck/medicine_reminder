import 'package:flutter/material.dart';

import 'package:medicine_reminder/timer/days.dart';
import 'package:medicine_reminder/Timer/MultiSelection.dart';

class SingleSelection extends StatefulWidget {
  final List<String> optionList;
  SingleSelection(this.optionList);

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

  List<Days> selectedDays = [
    Days('Monday'),
    Days('Tuesday'),
    Days('Wednesday'),
    Days('Thursday'),
    Days('Friday'),
    Days('Saturday'),
    Days('Sunday'),
  ];

  void openDialog() {
      showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: Text('Days'),
              content: Container(
                  width: 250,
                  height: 325,
                  child: MultiSelection(selectedDays)),
              actions: <Widget>[
                FlatButton(
                  padding: EdgeInsets.all(15),
                  onPressed: () {},
                  child: Text('Ok'),
                  color: Colors.redAccent,
                  textColor: Colors.white,
                ),
              ],
            );
          });
  }

  Widget customRadioString(String txt,int index){
    return OutlineButton(
      onPressed: () {
        changeIndex(index);
        if(index == 1) {
          openDialog();
        }
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10.0)),
      borderSide: BorderSide(color: selectedIndex == index ? Colors.cyan : Colors.grey),
      child: Text(txt,style: TextStyle(color: selectedIndex == index ?Colors.cyan : Colors.grey),),

    );
  }
  void changeIndex(int index){
    setState(() {
      selectedIndex = index;
    });
  }


  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            selectedValue = widget.optionList[index];
            setState(() {});
          },
          child: Container(
            padding: EdgeInsets.all(20),
            color: selectedValue == widget.optionList[index]
                ? Colors.white
                : null,
            child: Row(
                children: <Widget>[
                  customRadioString(widget.optionList[index], index),
                ],
            ),
          ),
        );
      },
      itemCount: widget.optionList.length,
    );
  }

}
