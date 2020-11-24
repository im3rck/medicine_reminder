

import 'package:flutter/material.dart';

class Entry {

  final String patient_Name;
  final String age;
  final String gender;

  Entry({this.gender, this.age, @required this.patient_Name});

  factory Entry.fromJson(Map<String, dynamic> json){
    return Entry(
        patient_Name: json['patient_Name'],
        age: json['age'],
        gender: json['gender']
    );
  }

  Map<String,dynamic> toMap(){
    return {
      'patient_Name': patient_Name,
      'age':age,
      'gender':gender
    };
  }
}