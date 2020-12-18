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

  DateTime dateTime;
  String medName;
  String dosage;
  String imageUrl;
  String scheduleId;
  String patientToken;
  bool isTimed;


  newScheduleModel({
      this.dateTime,
      this.medName,
      this.imageUrl,
      this.dosage,
      this.scheduleId,
      this.patientToken,
      this.isTimed = true,
    });

  factory newScheduleModel.fromJson(Map<String, dynamic> json){
    print('Inside : ${json} ${DateTime.parse(json['dateTime'])}');

    return newScheduleModel(
        dateTime: DateTime.parse(json['dateTime']),
        medName: json['medName'],
        dosage: json['dosage'],
        imageUrl: json['imageUrl'],
        scheduleId: json['scheduleId'],
        patientToken: json['patientToken'],
        isTimed: true
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'dateTime': dateTime.toIso8601String(),
      'medName': medName,
      'dosage': dosage,
      'imageUrl': imageUrl,
      'scheduleId' : scheduleId,
      'patientToken' : patientToken
    };
  }
}