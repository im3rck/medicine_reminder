import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medicine_reminder/Backend%20Services/Services/cF_Services.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/ScheduleModel.dart';

class PatientScheduleList extends StatelessWidget {
  Stream<List<newScheduleModel>> scheduleList;
  Stream<List<RepeatedScheduleModel>> repeatedScheduleList;
  Stream<List<newScheduleModel>> getSchedules(){
    FirestoreServices services = FirestoreServices.test();
    scheduleList = services.getMockSchedules();
    repeatedScheduleList = services.getMockRepeatedSchedules();
    List<newScheduleModel> newsm;//list of objects from reps with updated dates
    repeatedScheduleList.forEach((listOfSchedules) {
      listOfSchedules.forEach((schedule) {
          List<String> days = schedule.days.split(',');
          List<int> daysCode = [];
          days.forEach((element) {
            daysCode.add(decode(element));
          });
          // if(DateTime.now().day)
      });
    });
  }
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
 List<newScheduleModel> _schedules = [];


  render(List<newScheduleModel> streamData) {

    streamData.forEach((element) {

      newScheduleModel NSM;
      NSM = newScheduleModel(date: element.date, time: element.time, medName: element.medName);
      _schedules.add(NSM);
    });
  }
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
      stream: getSchedules(),
      builder: (context, snapshot) {
        if (snapshot.data != null) {
          render((snapshot.data));}
        return ListView.builder(
          itemCount: _schedules.length,
          itemBuilder: (context, index) {
            final schedule = _schedules[index];
            return Container(
              alignment: Alignment.center,
              child: Card(
                elevation: 10.0,
                margin:
                new EdgeInsets.symmetric(horizontal: 10.0, vertical: 10.0),
                child: Slidable(
                  child: Container(
                    decoration: BoxDecoration(
                      color: Color(0xff292929),
                    ),
                    child: ListTile(
                      leading: Container(
                        margin:
                        EdgeInsets.symmetric(horizontal: 10, vertical: 10.0),
                        height: 20,
                        width: 20,
                        decoration: BoxDecoration(
                            color: Color(0xff292929),
                            shape: BoxShape.circle,
                            border:
                            Border.all(color: Color(0xffbb86fe), width: 4)),
                      ),
                      title: Text(
                        schedule.date,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfff2e7fe),
                          height: 2,
                        ),
                      ),
                      subtitle: Text(
                        'Medicine: ' + schedule.medName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfff2e7fe),
                          height: 2,
                        ),
                      ),
                      trailing: Container(
                        height: 50,
                        width: 5,
                        color: Color(0xffbb86fe),
                      ),
                    ),
                  ),
                  actionPane: SlidableBehindActionPane(),
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
                      onTap: () => print('edit'),
                    ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: () => print('delete'),
                    ),
                  ],
                ),
              ),
            );
          },
        );
      }
    );
  }
}
