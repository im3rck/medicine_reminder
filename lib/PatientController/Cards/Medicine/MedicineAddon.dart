import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/PatientController/DaySelector/DaySelector.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class MedicineAddon extends StatefulWidget {
  @override
  _MedicineAddon createState() => _MedicineAddon();
}

class _MedicineAddon extends State<MedicineAddon> {
  bool flag = true;
  bool which = true;
  bool yes = true;

  void setCustomRange(String message, bool option) {
    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      isScrollControlled: true,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      builder: (BuildContext context) {
        return StatefulBuilder(
          builder: (BuildContext context, StateSetter myState) {
            return Container(
                height: (MediaQuery.of(context).size.height) * .6,
                padding: EdgeInsets.all(20.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Color(0xffBB86FC), width: 1),
                  color: Color(0xff121212),
                  borderRadius: BorderRadius.circular(15.0),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Center(
                      child: Text(
                        message,
                        style: TextStyle(
                          fontSize: 20,
                          fontFamily: 'Circular',
                          fontWeight: FontWeight.bold,
                          color: Color(0xffF2E7FE),
                        ),
                      ),
                    ),
                    Divider(
                      height: 20,
                      color: Color(0xffbb86fe),
                    ),
                    SizedBox(
                      height: 10.0,
                    ),
                    Expanded(
                      child: SfDateRangePickerTheme(
                          data: SfDateRangePickerThemeData(
                            brightness: Brightness.dark,
                            backgroundColor: Color(0xff121212),
                          ),
                          child: SfDateRangePicker(
                            view: DateRangePickerView.month,
                            backgroundColor: Color(0xff121212),
                            selectionColor: Color(0xffbb86fe),
                            rangeSelectionColor: option
                                ? Color(0xfff2e7fe)
                                : Color(0xffbb86fe).withOpacity(0.1),
                            startRangeSelectionColor: Color(0xffbb86fe),
                            endRangeSelectionColor:
                                option ? Color(0xfff2e7fe) : Color(0xffbb86fe),
                            enablePastDates: false,
                            monthViewSettings: DateRangePickerMonthViewSettings(
                              firstDayOfWeek: 1,
                              dayFormat: 'EEE',
                              enableSwipeSelection: true,
                            ),
                            selectionMode: option
                                ? DateRangePickerSelectionMode.multiple
                                : DateRangePickerSelectionMode.range,
                            rangeTextStyle: TextStyle(
                                fontFamily: 'Circular',
                                color: Color(0xfff2e7fe)),
                            monthCellStyle: DateRangePickerMonthCellStyle(
                              todayTextStyle: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Circular',
                                fontWeight: FontWeight.bold,
                                color: Color(0xffF2E7FE),
                              ),
                              todayCellDecoration: BoxDecoration(
                                  color: Color(0xff323232),
                                  border: Border.all(
                                      color: Color(0xffbb86fe), width: 1),
                                  shape: BoxShape.circle),
                              leadingDatesTextStyle: TextStyle(
                                  fontFamily: 'Circular',
                                  color: Color(0xfff2e7fe)),
                              trailingDatesTextStyle: TextStyle(
                                  fontFamily: 'Circular',
                                  color: Color(0xfff2e7fe)),
                              weekendTextStyle: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Circular',
                                fontWeight: FontWeight.w600,
                                color: Color(0xffF2E7FE),
                              ),
                            ),
                          )),
                    ),
                    Center(
                      child: Container(
                          padding: EdgeInsets.only(bottom: 5),
                          child: FloatingActionButton.extended(
                            onPressed: () {
                              Navigator.pop(context);
                            },
                            backgroundColor: Color(0xff292929),
                            foregroundColor: Color(0xffbb86fe),
                            label: Text(
                              " Confirm ",
                              style: TextStyle(
                                fontSize: 16,
                                fontFamily: 'Circular',
                                fontWeight: FontWeight.bold,
                                color: Color(0xffbb86fe),
                              ),
                            ),
                          )),
                    ),
                  ],
                ));
          },
        );
      },
    );
  }

  void onSelect() {
    setState(() {
      flag = !flag;
      which = !which;
    });
  }

  void onTap() {
    setState(() {
      yes = !yes;
    });
  }

  InkWell showCards(String message, int index, bool flag, bool which) {
    whichColour(int index) {
      switch (index) {
        case 0:
          break;
        case 1:
          break;
        case 2:
          break;
      }
    }
    return InkWell(
      onTap: () {
        switch (index) {
          case 0:
            onSelect();
            setState(() {
              yes = true;
            });
            break;
          case 1:
            setCustomRange('Range of Days', false);
            onSelect();
            onTap();
            break;
          case 2:
            setCustomRange('Set of Days', true);
            onSelect();
            onTap();
            break;
        }
      },
      child: Column(
        children: [
          Card(
            elevation: 20.0,
            color: flag ? which ? Color(0xffbb86fe) : Color(0xff292929) : Color(0xff292929),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.all(7.0),
            child: Container(
              height: (MediaQuery.of(context).size.height) * .15,
              width: (MediaQuery.of(context).size.width) * .25,
              decoration: BoxDecoration(
                color: flag ? Color(0xffbb86fe) : Color(0xff121212),
                border: Border.all(color: Color(0xffbb86fe), width: 1),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff121212).withOpacity(0.2),
                    spreadRadius: 3,
                    blurRadius: 4,
                    offset: Offset(0, 3),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  message,
                  style: TextStyle(
                    fontSize: 16,
                    fontFamily: 'Circular',
                    fontWeight: FontWeight.bold,
                    color: Color(0xffF2E7FE),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        yes ? SelectedDaysUpdateExample() : SizedBox(height: 48),
        SizedBox(height: 20),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            showCards('Repeat\nTill\nCancelled', 0, flag, which),
            showCards('Select\nRange of\nDays', 1, !flag, !which),
            showCards('Custom\nSet of\nDays', 2, !flag, which),
          ],
        )
      ],
    );
  }
}
