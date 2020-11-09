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
  // List<int> selectedItems = List();

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (ctx, index) {
        return GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            widget.wantedDays[index].isSelected =
                !widget.wantedDays[index].isSelected;
            setState(() {});
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
                        if (val) {
                          // widget.wantedDays[index].isSelected = val;
                          // selectedItems.add(index);
                          widget.customFunction(' Mon ');
                        }
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

// class SetCustom extends StatelessWidget {
//
//   final List<int> _daysList = new List();
//
//   @override
//   Widget build(BuildContext context) {
//     _daysList.add(1);
//     _daysList.add(2);
//   }
//
//   List<int> getMainButtonsList() {
//     return _daysList;
//   }
// }
// class MyClass {
//   String title;
//   bool value;
//   MyClass(this.title, this.value);
//   @override
//   String toString() {
//     return 'MyClass{title: $title, value: $value}';
//   }
// }
//
// class MultiCheckBoxField extends StatelessWidget {
//   const MultiCheckBoxField({
//     Key key,
//     this.count = 1,
//     this.onSaved,
//   }) : super(key: key);
//
//   final int count;
//   final FormFieldSetter<List<bool>> onSaved;
//
//   @override
//   Widget build(BuildContext context) {
//     return FormField<List<bool>>(
//       initialValue: List.filled(count, false),
//       onSaved: onSaved,
//       builder: (FormFieldState field) {
//         return Column(
//           mainAxisSize: MainAxisSize.min,
//           children: List.generate(
//             count,
//                 (int index) {
//               return Checkbox(
//                 onChanged: (bool value) {
//                   field.value[index] = value;
//                   field.didChange(field.value);
//                 },
//                 value: field.value[index],
//               );
//             },
//           ),
//         );
//       },
//     );
//   }
// }
