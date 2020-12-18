class ScheduleModel {
  DateTime dateTime;
  String medName;
  String dosage;
  String imageUrl;
  String scheduleId;
  String patientToken;
  bool isTimed;

  ScheduleModel({
    this.dateTime,
    this.medName,
    this.imageUrl,
    this.dosage,
    this.scheduleId,
    this.patientToken,
    this.isTimed = true,
  });

  factory ScheduleModel.fromJson(Map<String, dynamic> json) {
    return ScheduleModel(
        dateTime: DateTime.parse(json['dateTime']),
        medName: json['medName'],
        dosage: json['dosage'],
        imageUrl: json['imageUrl'],
        scheduleId: json['scheduleId'],
        patientToken: json['patientToken'],
        isTimed: true);
  }

  Map<String, dynamic> toMap() {
    return {
      'dateTime': dateTime.toIso8601String(),
      'medName': medName,
      'dosage': dosage,
      'imageUrl': imageUrl,
      'scheduleId': scheduleId,
      'patientToken': patientToken
    };
  }
}

class GetMedicineCards {
  static List<ScheduleModel> medicineCard = [];

  static pushData(ScheduleModel scheduleModel) =>
      medicineCard.add(scheduleModel);

  static popData() => medicineCard.removeLast();

  get medCards => medicineCard;

  getMedicineCards(int index) {
    return medicineCard.elementAt(index);
  }
}
