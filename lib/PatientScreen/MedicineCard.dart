import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/ScheduleModel.dart';
import 'package:medicine_reminder/Backend%20Services/Services/cF_Services.dart';
import 'CardData.dart';
import 'Ticket.dart';

class MedicineCard extends StatefulWidget {
  @override
  MedicineCard(this.patientID);
  String patientID;
  _MedicineCardState createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {
  final ScrollController _scrollController = ScrollController();

  final List<int> _openCards = [];

  final List<newScheduleModel> medicineCards = GetMedicineCards().medCards;
  String dateCheck =  DateTime.now().year.toString() + "-" + DateTime.now().month.toString()+ "-" +DateTime.now().day.toString();
  // Stream<List<newScheduleModel>> stream() {
  //   Stream<List<newScheduleModel>> target;
  //   target = FirebaseFirestore.instance
  //       .collection(
  //           'users/qYfmaBH7usYg7CGx7JTzTlgCRdx1/patients/alalalalldldlaslalsalsllsllaslsd/TimedSchedules')
  //       .snapshots()
  //       .map((snapshot) => snapshot.docs
  //           .map((doc) => newScheduleModel.fromJson(doc.data()))
  //           .toList());
  //   print(target.toString());
  //   return target;
  // }
  Stream<List<newScheduleModel>> getSchedules(){
    FirestoreServices services = FirestoreServices.test();
    scheduleList = services.getMockDailySchedules(widget.patientID);
    repeatedScheduleList = services.getMockDailyRepeatedSchedules(widget.patientID);
    newScheduleModel newsm;
    List<newScheduleModel> finalList = [];
    scheduleList.forEach((value) {

      value.forEach((element) {
        if(element.date==dateCheck)
        finalList.add(element);
      });

    });
    repeatedScheduleList.forEach((listOfSchedules) {
      listOfSchedules.forEach((schedule) {
        List<String> days = schedule.days.split(',');
        List<int> daysCode = [];
        days.forEach((element) {
          daysCode.add(decode(element));
        });
        if(daysCode.contains(DateTime.now().weekday) ){

          newsm = newScheduleModel(date: '${DateTime.now().year}-${DateTime.now().month}-${DateTime.now().day}', time: schedule.time, medName: schedule.medName, dosage: schedule.dosage, imageUrl: 'abcde', scheduleId: schedule.scheduleId );
          finalList.add(newsm);

        }
      });
    });
    Stream<List<newScheduleModel>> schedules = Stream.value(finalList);
    return schedules;
  }
  Stream<List<newScheduleModel>> scheduleList;
  Stream<List<RepeatedScheduleModel>> repeatedScheduleList;
  List<String> names = [];

  decode(String day){
    switch(day)
    {
      case "Monday" : { return 1; }
      case "Tuesday" : { return 2; }
      case "Wednesday" : { return 3; }
      case "Thursday" : { return 4; }
      case "Friday" : { return 5; }
      case "Saturday" : { return 6; }
      case "Sunday" : { return 7; }
      default: {return 0;}
    }
  }
  render(List<newScheduleModel> streamData) {
    streamData.forEach((element) {
      GetMedicineCards.pushData(element);
    });
    // GetMedicineCards.popData();   Note : After mark as taken is pressed
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: _buildAppBar(),
      body: Container(
        child: Flex(direction: Axis.vertical, children: <Widget>[
          Expanded(
            child: StreamBuilder<List<newScheduleModel>>(
                stream: getSchedules(),
                builder: (context, snapshot) {
                  if (snapshot.data != null) render((snapshot.data));
                  return ListView.builder(
                    controller: _scrollController,
                    physics: BouncingScrollPhysics(),
                    itemCount: medicineCards.length,
                    itemBuilder: (BuildContext context, int index) {
                      return Ticket(
                        medicineCard: medicineCards.elementAt(index),
                        onClick: () => _handleClickedCard(index),
                      );
                    },
                  );
                }),
          ),
        ]),
      ),
    );
  }

  bool _handleClickedCard(int clickedCard) {
    _openCards.contains(clickedCard)
        ? _openCards.remove(clickedCard)
        : _openCards.add(clickedCard);

    double openCardsOffset =
        Ticket.nominalOpenHeight * _getOpenCardsBefore(clickedCard);
    double closedTicketsOffset = Ticket.nominalClosedHeight *
        (clickedCard - _getOpenCardsBefore(clickedCard));

    double offset = openCardsOffset +
        closedTicketsOffset -
        (Ticket.nominalClosedHeight * .5);

    _scrollController.animateTo(max(0, offset),
        duration: Duration(seconds: 1),
        curve: Interval(.25, 1, curve: Curves.easeOutQuad));
    return true;
  }

  _getOpenCardsBefore(int ticketIndex) {
    return _openCards.where((int index) => index < ticketIndex).length;
  }

  Widget _buildAppBar() {
    return AppBar(
      shadowColor: Color(0xffbb86fe),
      leading: IconButton(
        icon: Icon(Icons.arrow_back_ios, color: Color(0xffBB86Fe)),
        onPressed: () {
          Navigator.pop(context);
        },
      ),
      actions: <Widget>[
        Padding(
          padding: const EdgeInsets.only(right: 18.0),
          child: Icon(Icons.more_horiz, color: Color(0xffBB86Fe), size: 28),
        )
      ],
      brightness: Brightness.light,
      backgroundColor: Color(0xFF292929),
      elevation: 0,
      title: Container(
        width: double.infinity,
        alignment: Alignment.center,
        child: Text(
          'Medicines For Today'.toUpperCase(),
          textAlign: TextAlign.center,
          style: TextStyle(
            fontFamily: 'Circular',
            fontSize: 16,
            letterSpacing: 0.5,
            color: Color(0xffbb86fe),
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
