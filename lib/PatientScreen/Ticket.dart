import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/ScheduleModel.dart';
import 'CardData.dart';
import 'CardInner.dart';
import 'CardFront.dart';
import 'FoldingLogic.dart';

class Ticket extends StatefulWidget {
  static const double nominalOpenHeight = 400;
  static const double nominalClosedHeight = 160;
  final newScheduleModel medicineCard;
  final Function onClick;

  const Ticket({Key key, @required this.medicineCard, @required this.onClick})
      : super(key: key);

  @override
  State<StatefulWidget> createState() => _TicketState();
}

class _TicketState extends State<Ticket> {
  FrontCard frontCard;
  FrontCard topCard;
  MiddleCard middleCard;
  bool _isOpen;

  Widget get backCard => Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4.0), color: Color(0xff292929)));

  @override
  void initState() {
    super.initState();
    _isOpen = false;
    frontCard = FrontCard(data: widget.medicineCard);
    middleCard = MiddleCard(widget.medicineCard);
  }

  @override
  Widget build(BuildContext context) {
    return FoldingTicket(
        entries: _getEntries(), isOpen: _isOpen, onClick: _handleOnTap);
  }

  List<FoldEntry> _getEntries() {
    return [
      FoldEntry(height: 160.0, front: topCard),
      FoldEntry(height: 160.0, front: middleCard, back: frontCard),
    ];
  }

  void _handleOnTap() {
    widget.onClick();
    _isOpen ?
    setState(() {
      _isOpen = !_isOpen;
      Future.delayed(const Duration(milliseconds: 500), () {
        setState(() {
          topCard = FrontCard(
              data: widget.medicineCard,
              theme: SummaryTheme.dark,
              isOpen: _isOpen);
        });
      });
    }) :
    setState(() {
      _isOpen = !_isOpen;
      topCard = FrontCard(
          data: widget.medicineCard,
          theme: SummaryTheme.dark,
          isOpen: _isOpen);
    });
  }
}
