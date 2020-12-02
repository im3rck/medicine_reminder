import 'package:flutter/material.dart';

import 'package:medicine_reminder/Timer/SelectDay/MultiSelection.dart';

class SingleSelection extends StatefulWidget {
  final List<String> optionList = [
    '   DAILY   ',
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

  String selectedDays = '';

  void openDialog(int index) {
    showDialog(
        context: context,
        builder: (ctx) {
          return WillPopScope(
            onWillPop: () async {
              return false;
            },
            child: AlertDialog(
              backgroundColor: Color(0xff292929),

              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(15)),
              title: Center(
                child: Text('DAYS',
                    style: TextStyle(
                        fontFamily: 'Circular',
                        fontSize: 16,
                        color: Colors.white,
                        fontWeight: FontWeight.bold)),
              ),
              content: Container(
                  decoration: BoxDecoration(
                    color: Color(0xff292929),
                    borderRadius: BorderRadius.circular(15.0),
                  ),
                  width: 250,
                  height: 340,
                  child: MultiSelection(
                      updateDays: listChange, updateIndices: getIndices)),
            ),
          );
        });
  }

  Widget customRadioString(String txt, int index) {
    return Column(children: [
      Row(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          OutlineButton(
            onPressed: () {
              changeIndex(index);
              if (index == 1) {
                openDialog(index);
                selectedDays = '';
              }
            },
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            borderSide: BorderSide(
                color:
                    selectedIndex == index ? Color(0xffBB86FC) : Colors.grey),

              child: Text(
                txt,
                style: TextStyle(
                    fontFamily: 'Circular',
                    fontSize: 16,
                    color: selectedIndex == index
                        ? Color(0xffBB86FC)
                        : Colors.grey,
                    fontWeight: FontWeight.bold),
              ),

          ),
          SizedBox(
            height: 20,
            width: 10,
          ),
          showMsg(index),
        ],
      ),
      SizedBox(height: 40),
    ]);
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

  Widget showMsg(int index) {
    List<TextSpan> _getSelected() {
      final String daily = ' REMIND ME EVERYDAY ';

      List<TextSpan> selected = [];

      if (index == 0)
        selected.add(TextSpan(text: daily));
      else
        selected.add(TextSpan(text: selectedDays));
      return selected;
    }

    final style = TextStyle(
      fontFamily: 'Circular',
      fontSize: 16,
      color: selectedIndex == index ? Color(0xffBB86FC) : Colors.grey,
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
      shrinkWrap: true,
      itemBuilder: (ctx, index) {
        return Row(
            children: [customRadioString(widget.optionList[index], index)]);
      },
      itemCount: widget.optionList.length,
    );
  }
}
