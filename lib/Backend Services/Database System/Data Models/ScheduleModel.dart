class SM {
  String date;
  String medName;
  String dosage;
  String imageUrl;
  int remainingQuantity;
  String time;

  SM(this.medName,this.imageUrl,this.remainingQuantity,this.time,this.dosage,this.date);

}

class newScheduleModel {

  String date;
  String time;
  String medName;
  String dosage;
  String imageUrl;
  String scheduleId;

  newScheduleModel({
      this.date,
      this.time,
      this.medName,
      this.imageUrl,
      this.dosage,
      this.scheduleId,

    });

  factory newScheduleModel.fromJson(Map<String, dynamic> json){
   // print('Inside : ${json} ${DateTime.parse(json['dateTime'])}');
   // print("DEADBEEF");
    return newScheduleModel(
        //dateTime: DateTime.parse(json['dateTime']),
        date: json['date'],
        time: json['time'],
        medName: json['medName'],
        dosage: json['dosage'],
        imageUrl: json['imageUrl'],
        scheduleId: json['scheduleId'],

    );
  }


  Map<String,dynamic> toMap(){
    return {
      //'dateTime': dateTime.toIso8601String(),
      'date': date,
      'time': time,
      'medName': medName,
      'dosage': dosage,
      'imageUrl': imageUrl,
      'scheduleId' : scheduleId,
    };
  }
}
class RepeatedScheduleModel {

  String days;
  String time;
  String medName;
  String dosage;
  String imageUrl;
  String scheduleId;

  RepeatedScheduleModel({
    this.days,
    this.time,
    this.medName,
    this.imageUrl,
    this.dosage,
    this.scheduleId,

  });

  factory RepeatedScheduleModel.fromJson(Map<String, dynamic> json){
    // print('Inside : ${json} ${DateTime.parse(json['dateTime'])}');
   // print("DEADBEEF");
    return RepeatedScheduleModel(
      //dateTime: DateTime.parse(json['dateTime']),
      days: json['days'],
      time: json['time'],
      medName: json['medName'],
      dosage: json['dosage'],
      imageUrl: json['imageUrl'],
      scheduleId: json['scheduleId'],

    );
  }


  Map<String,dynamic> toMap(){
    return {
      //'dateTime': dateTime.toIso8601String(),
      'days': days,
      'time': time,
      'medName': medName,
      'dosage': dosage,
      'imageUrl': imageUrl,
      'scheduleId' : scheduleId,
    };
  }
}
class AlarmSchedule{
  DateTime dateTime;
  String medName;
  String dosage;
  String imageUrl;

  AlarmSchedule({this.dateTime,this.medName,this.imageUrl,this.dosage});

}