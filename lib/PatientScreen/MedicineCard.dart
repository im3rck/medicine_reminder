import 'dart:math';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

import 'CardData.dart';
import 'Ticket.dart';

class MedicineCard extends StatefulWidget {
  @override
  _MedicineCardState createState() => _MedicineCardState();
}

class _MedicineCardState extends State<MedicineCard> {

  final ScrollController _scrollController = ScrollController();

  final List<int> _openCards = [];

  final List<ScheduleModel> medicineCards = GetMedicineCards().medCards;
  Stream<List<ScheduleModel>> retest()  {
    Stream<List<ScheduleModel>> target;
    target =  FirebaseFirestore.instance
        .collection(
        'users/uOzQ4baX4CbRy3vnSKCyCJGi7sw1/patients/Duhshshshsggshdhejshdhdhegdgdhhdgdgehd/TimedSchedules')
        .snapshots()
        .map((snapshot) =>
        snapshot.docs
            .map((doc) => ScheduleModel.fromJson(doc.data()))
            .toList());
    return target;
  }
  render(List<ScheduleModel> streamData)  {
   // FirebaseFirestore _db = FirebaseFirestore.instance;
   //  Stream<List<ScheduleModel>> streamData =  await _db
   //      .collection(
   //      'users/uOzQ4baX4CbRy3vnSKCyCJGi7sw1/patients/Duhshshshsggshdhejshdhdhegdgdhhdgdgehd/TimedSchedules')
   //      .snapshots()
   //      .map((snapshot) =>
   //      snapshot.docs
   //          .map((doc) => ScheduleModel.fromJson(doc.data()))
   //          .toList());
   // assert(streamData != null);
    // Stream<List<ScheduleModel>> streamData;
   // var scheduleList = await streamData.elementAt(0);
    streamData.forEach((element) {
      element.dateTime = DateTime.now(); //
      GetMedicineCards.pushData(element);
    });

    // GetMedicineCards.popData();   Note : After mark as taken is pressed
  }


  @override
  void initState() {
    super.initState();

   // render();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFF121212),
      appBar: _buildAppBar(),
      body: Container(
        child: Flex(direction: Axis.vertical, children: <Widget>[
          Expanded(
            child: StreamBuilder<List<ScheduleModel>>(
                stream: retest(),
                //Stream.value(medicineCards), // medCards
                builder: (context, snapshot) {
                  print("help: ${snapshot.data==null? "Pink":snapshot.data}");
                  if(snapshot.data!=null)render((snapshot.data));
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
    _getOpenCardsBefore(int ticketIndex) {
      // Search all indexes that are smaller to the current index in the list of indexes of open tickets
      return _openCards
          .where((int index) => index < ticketIndex)
          .length;
    }

    // Scroll to ticket position
    // Add or remove the item of the list of open tickets
    _openCards.contains(clickedCard)
        ? _openCards.remove(clickedCard)
        : _openCards.add(clickedCard);

    // Calculate heights of the open and closed elements before the clicked item
    double openCardsOffset =
        Ticket.nominalOpenHeight * _getOpenCardsBefore(clickedCard);
    double closedTicketsOffset = Ticket.nominalClosedHeight *
        (clickedCard - _getOpenCardsBefore(clickedCard));

    double offset = openCardsOffset +
        closedTicketsOffset -
        (Ticket.nominalClosedHeight * .5);

    // Scroll to the clicked element
    _scrollController.animateTo(max(0, offset),
        duration: Duration(seconds: 1),
        curve: Interval(.25, 1, curve: Curves.easeOutQuad));
    // Return true to stop the notification propagation
    return true;
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
