import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';



import 'Constructor/Constructor.dart';


class PatientMedicineList extends StatelessWidget{
  final List<PatientDetails> _plist = <PatientDetails>[
    PatientDetails(patNumber: 1, patName: 'Sam', age: 78),
    PatientDetails(patNumber: 2, patName: 'Mike', age: 82),
    PatientDetails(patNumber: 3, patName: 'Liv', age: 66),
    PatientDetails(patNumber: 4, patName: 'Tom', age: 69),
  ];

  @override
  Widget build(BuildContext context) {
    return MedicineList(_plist);
  }
}

class MedicineList extends StatelessWidget{
  final List<PatientDetails> _pats;
  MedicineList(this._pats);
  @override
  Widget build(BuildContext context) {
    return Container(
      child: ListView.builder(
        itemCount: _pats.length,
        itemBuilder: (context, index) {
          final pats = _pats[index];
          return Slidable(child: Container(
            color: Color(0xff292929),
            child: ListTile(
              leading: CircleAvatar(
                backgroundColor: Colors.green,
                foregroundColor: Colors.white,
                child: Text((pats.patNumber).toString()),
              ),
              title: Text(pats.patName),
              subtitle: Text('Age : '+(pats.age).toString()),
            ),
          ), actionPane: SlidableBehindActionPane(),
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
                onTap: ()=>print('edit'),
              ),
              IconSlideAction(
                caption: 'delete',
                color: Colors.red,
                icon: Icons.delete,
                onTap: ()=>print('delete'),
              ),

            ],
          );
        },),
    );
  }

}

