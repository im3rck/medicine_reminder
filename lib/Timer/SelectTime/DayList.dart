import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import 'constructor.dart';

class DayList extends StatelessWidget {
  final List<DayDetails> _pats;

  DayList(this._pats);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: ListView.builder(
        shrinkWrap: true,
        itemCount: _pats.length,
        itemBuilder: (context, index) {
          final pats = _pats[index];
          return Slidable(
            child: Container(
              color: Colors.white,
              child: ListTile(
                contentPadding: EdgeInsets.all(10),
                leading: CircleAvatar(
                  backgroundColor: Colors.green,
                  foregroundColor: Colors.white,
                  child: Text((pats.dayNumber).toString()),
                ),
                title: Text(pats.dayName),
              ),
            ),
            actionPane: SlidableBehindActionPane(),
            actions: <Widget>[
              IconSlideAction(
                caption: 'log',
                color: Colors.blue,
                icon: Icons.leaderboard,
                onTap: () => print('log'),
              ),
            ],
            secondaryActions: <Widget>[
              IconSlideAction(
                caption: 'edit',
                color: Colors.yellow,
                icon: Icons.edit_outlined,
                onTap: () => print('edit'),
              ),
              IconSlideAction(
                caption: 'delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: () => print('delete'),
              ),
            ],
          );
        },
      ),
    );
  }
}
