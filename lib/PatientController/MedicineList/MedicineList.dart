import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:medicine_reminder/Backend%20Services/Services/cF_Services.dart';
import 'package:medicine_reminder/Backend%20Services/Database%20System/Data%20Models/ScheduleModel.dart';

class PatientMedicineList extends StatelessWidget {
  PatientMedicineList(this.patientID);
  String patientID;
  Stream<List<newScheduleModel>> scheduleList;
  Stream<List<RepeatedScheduleModel>> repeatedScheduleList;
  List<String> names = [];
  Stream<List<String>> getSchedules(){
    FirestoreServices services = FirestoreServices.test();
    scheduleList = services.getMockSchedules(patientID);
    repeatedScheduleList = services.getMockRepeatedSchedules(patientID);
    newScheduleModel newsm;
    List<newScheduleModel> finalList = [];
    scheduleList.forEach((value) {
      value.forEach((element) {
        finalList.add(element);
        finalList.forEach((element) {
          if(!names.contains(element.medName)){
            names.add(element.medName);
          }
        });
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
          finalList.forEach((element) {
          //  print("Wicket");
            if(!names.contains(element.medName)){
              names.add(element.medName);
              //print(names.toString());
            }
          });
        }
      });
    });

    Stream<List<String>> nameList = Stream.value(names);
    return nameList;
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
  List<String> _schedules = [];
  render(List<String> streamData) {
    streamData.forEach((element) {
      _schedules.add(element);
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
                          schedule,
                          style: TextStyle(
                            fontSize: 16,
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
                      // IconSlideAction(
                      //   caption: 'Log',
                      //   color: Color(0xff121212),
                      //   icon: Icons.leaderboard,
                      //   onTap: () => print('log'),
                      // ),
                    ],
                    secondaryActions: <Widget>[
                      // IconSlideAction(
                      //   caption: 'Edit',
                      //   color: Color(0xffbb86fe),
                      //   icon: Icons.edit_outlined,
                      //   onTap: () => print('edit'),
                      // ),
                      IconSlideAction(
                        caption: 'Delete',
                        color: Colors.red,
                        icon: Icons.delete,
                        onTap: () {
                          delMedicine(schedule);
                          Navigator.pop(context);
                        },
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
  void delMedicine(String value){
    FirestoreServices services = FirestoreServices.test();
    services.mockDelete(value);
  }
}


class PatientScheduleList extends StatelessWidget {
  PatientScheduleList(this.patientID);
  String patientID;
  Stream<List<newScheduleModel>> scheduleList;
  Stream<List<RepeatedScheduleModel>> repeatedScheduleList;
  Stream<List<newScheduleModel>> getSchedules(){
    FirestoreServices services = FirestoreServices.test();
    scheduleList = services.getMockSchedules(patientID);
    repeatedScheduleList = services.getMockRepeatedSchedules(patientID);
    newScheduleModel newsm;
    List<newScheduleModel> finalList = [];
    scheduleList.forEach((value) {

      value.forEach((element) {

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
      NSM = newScheduleModel(date: element.date, time: element.time, medName: element.medName, scheduleId: element.scheduleId);
      _schedules.add(NSM);
      _schedules.forEach((element) {
        print(element.toMap().toString());
      });
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
                        schedule.medName,
                        style: TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfff2e7fe),
                          height: 2,
                        ),
                      ),
                      trailing: Text(
                        schedule.time,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Color(0xfff2e7fe),
                          height: 2,
                        ),
                      )
                    ),
                  ),
                  actionPane: SlidableBehindActionPane(),
                  actions: <Widget>[
                    // IconSlideAction(
                    //   caption: 'Log',
                    //   color: Color(0xff121212),
                    //   icon: Icons.leaderboard,
                    //   onTap: () => print('log'),
                    // ),
                  ],
                  secondaryActions: <Widget>[
                    // IconSlideAction(
                    //   caption: 'Edit',
                    //   color: Color(0xffbb86fe),
                    //   icon: Icons.edit_outlined,
                    //   onTap: () => print('edit'),
                    // ),
                    IconSlideAction(
                      caption: 'Delete',
                      color: Colors.red,
                      icon: Icons.delete,
                      onTap: (){
                        delSchedule(schedule.scheduleId);
                      },
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
  void delSchedule(String value){
    FirestoreServices services = FirestoreServices.test();
    services.mockDeleteSchedule(value);
  }
}
