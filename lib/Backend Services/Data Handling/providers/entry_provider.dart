/*
import 'dart:html';

import 'package:flutter/material.dart';
import 'package:medicine_reminder/Backend%20Services/Data%20Handling/services/firestore_service.dart';

import 'package:uuid/uuid.dart';

class EntryProvider with ChangeNotifier {
  final firestoreService = FirestoreService();
  DateTime _date;
  String _gender;
  String _age;
  String _patientName;
  var uuid = Uuid();

  //Getters
  DateTime get date => _date;
  String get age => _age;
  String get gender => _gender;
  String get patient_Name => _patientName;
  //Stream<List<Entry>> get entries => firestoreService.getEntries();

  //Setters
  set changeDate(DateTime date){
    _date = date;
    notifyListeners();
  }

  set changeName(String patient_Name){
    _patientName = patient_Name;
    notifyListeners();
  }

  //Functions
  loadAll(Entry entry){
    if (entry != null){
      _date = DateTime.parse(entry.date);
      _entry =entry.entry;
      _entryId = entry.entryId;
    } else {
      _date = DateTime.now();
      _entry = null;
      _entryId = null;
    }
  }

  saveEntry(){
    if (patient_Name == null){
      //Add
      var newEntry = Entry(date: _date.toIso8601String(), entry: _entry, entryId: uuid.v1());
      print(newEntry.entry);
      firestoreService.setEntry(newEntry);
    } else {
      //Edit
      var updatedEntry = Entry(date: _date.toIso8601String(), entry: _entry, entryId: _entryId);
      firestoreService.setEntry(updatedEntry);
    }
  }

  removeEntry(String entryId){
    firestoreService.removeEntry(entryId);
  }

}
*/
