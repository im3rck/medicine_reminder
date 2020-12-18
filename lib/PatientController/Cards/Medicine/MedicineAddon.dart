import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:medicine_reminder/PatientController/DaySelector/DaySelector.dart';
import 'package:syncfusion_flutter_datepicker/datepicker.dart';
import 'package:syncfusion_flutter_core/theme.dart';

class MedicineAddon extends StatefulWidget {
  @override
  _MedicineAddon createState() => _MedicineAddon();
}

class _MedicineAddon extends State<MedicineAddon> {
  int selectedIndex = 0;
  bool yes = true;
  String _selectedDate;
  String _dateCount;
  String _range;
  String _rangeCount;
  List<String> optionList = [
    'Repeat\nTill\nCancelled',
    'Select\nRange of\nDays',
    'Custom\nSet of\nDays'
  ];

  void initState() {
    _selectedDate = '';
    _dateCount = '';
    _range = '';
    _rangeCount = '';
    super.initState();
  }

  /// The method for [DateRangePickerSelectionChanged] callback, which will be
  /// called whenever a selection changed on the date picker widget.
  void _onSelectionChanged(DateRangePickerSelectionChangedArgs args) {
    /// The argument value will return the changed date as [DateTime] when the
    /// widget [SfDateRangeSelectionMode] set as single.
    ///
    /// The argument value will return the changed dates as [List<DateTime>]
    /// when the widget [SfDateRangeSelectionMode] set as multiple.
    ///
    /// The argument value will return the changed range as [PickerDateRange]
    /// when the widget [SfDateRangeSelectionMode] set as range.
    ///
    /// The argument value will return the changed ranges as
    /// [List<PickerDateRange] when the widget [SfDateRangeSelectionMode] set as
    /// multi range.
    setState(() {
      if (args.value is PickerDateRange) {
        _range =
            DateFormat('dd/MM/yyyy').format(args.value.startDate).toString() +
                ' - ' +
                DateFormat('dd/MM/yyyy')
                    .format(args.value.endDate ?? args.value.startDate)
                    .toString();
      } else if (args.value is DateTime) {
        _selectedDate = args.value;
      } else if (args.value is List<DateTime>) {
        _dateCount = args.value.length.toString();
      } else {
        _rangeCount = args.value.length.toString();
      }
      print(_range);
      print(_dateCount);
    });
  }

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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xffbb86fe),
                          ),
                          color: Color(0xffbb86fe),
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
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
                        IconButton(
                          icon: Icon(
                            Icons.arrow_back_ios,
                            color: Color(0xff121212),
                          ),
                          color: Color(0xff121212),
                          onPressed: () {},
                        ),
                      ],
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
                            onSelectionChanged: _onSelectionChanged,
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

  void changeIndex(int index) {
    setState(() {
      selectedIndex = index;
      selectedIndex == 0 ? yes = true : yes = false;
    });
  }

  InkWell showCards(String message, int index) {
    return InkWell(
      onTap: () {
        changeIndex(index);
        selectedIndex == 1
            ? setCustomRange('Range of Days', false)
            : selectedIndex == 2
                ? setCustomRange('Set of Days', true)
                : null;
      },
      child: Column(
        children: [
          Card(
            elevation: 20.0,
            color:
                selectedIndex == index ? Color(0xffbb86fe) : Color(0xff292929),
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)),
            margin: EdgeInsets.all(7.0),
            child: Container(
              height: (MediaQuery.of(context).size.height) * .15,
              width: (MediaQuery.of(context).size.width) * .25,
              decoration: BoxDecoration(
                color: selectedIndex == index
                    ? Color(0xffbb86fe)
                    : Color(0xff292929),
                border: Border.all(
                    color: selectedIndex == index
                        ? Color(0xff292929)
                        : Color(0xffbb86fe),
                    width: 1),
                borderRadius: BorderRadius.circular(10.0),
                boxShadow: [
                  BoxShadow(
                    color: Color(0xff292929),
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
                    color: selectedIndex == index
                        ? Color(0xff121212)
                        : Color(0xffF2E7FE),
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
        Flexible(
            child: ListView.builder(
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, index) {
            return Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  showCards(optionList[index], index),
                ]);
          },
          itemCount: optionList.length,
        ))
      ],
    );
  }
}
