import 'package:flutter/gestures.dart';
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
          return Container(
            alignment: Alignment.center,
            child: Card(
              elevation: 10.0,
              margin: new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
              child: Slidable(
                child: Container(
                  decoration: BoxDecoration(
                  color: Color(0xff292929),
                ),
                  child: ListTile(
                    leading: Container(
                      margin: EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                      height: 20,
                      width: 20,
                      decoration: BoxDecoration(
                      color: Color(0xff292929),
                          shape: BoxShape.circle,
                        border: Border.all(color: Color(0xffbb86fe),
                        width: 4)
                      ),
                    ),
                    title: Text(pats.patName,style:  TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Color(0xfff2e7fe),
                    height: 2,
                  ),),
                    subtitle: Text('Age : '+(pats.age).toString(), style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xfff2e7fe),
                    height: 2,
                  ),),
                    trailing: Container(
                      height: 50,
                      width: 5,
                      color: Color(0xffbb86fe),
                    ),
                ),
              ), actionPane: SlidableBehindActionPane(),
                actions: <Widget>[
                  IconSlideAction(
                    caption: 'Log',
                    color: Color(0xff121212),
                    icon: Icons.leaderboard,
                    onTap: () => print('log'),
                  ),
                ],
                secondaryActions: <Widget>[
                  IconSlideAction(
                    caption: 'Edit',
                    color: Color(0xffbb86fe),
                    icon: Icons.edit_outlined,
                    onTap: ()=>print('edit'),
                  ),
                  IconSlideAction(
                    caption: 'Delete',
                    color: Colors.red,
                    icon: Icons.delete,
                    onTap: ()=>print('delete'),
                  ),

                ],
              ),
            ),
          );
        },),
    );
  }

}

