import 'package:flutter/cupertino.dart';

class PPD{
   String patientToken;
   String patientName;
   String age;
   String gender;
  //remember : final String pic;
   String contactNo;
   String relationship;

  //PPD({@required this.patientToken,@required this.patientName,this.age,this.gender,this.relationship,@required this.contactNo});
   PPD({ this.patientToken, this.patientName,this.age,this.gender,this.relationship, this.contactNo});

  factory PPD.fromJson(Map<String, dynamic> json){
    return PPD(
        patientToken: json['patientToken'],
        patientName: json['patientName'],
        age: json['age'],
        gender: json['gender'],
        contactNo: json['contactNo'],
        relationship: json['relationship']

    );
  }

  Map<String,dynamic> toMap(){
    return {
      'patientToken': patientToken,
      'patientName': patientName,
      'age':age,
      'gender':gender,
      'contactNo':contactNo,
      'relationship' : relationship
    };
  }

}