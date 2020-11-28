import 'package:medicine_reminder/PatientList/SelfReminder/Models/Errors.dart';
import 'package:medicine_reminder/PatientList/SelfReminder/Models/Medicine_Details.dart';
import 'package:rxdart/rxdart.dart';

class NewEntryBloc {
  BehaviorSubject<MedicineType> _selectedMedicineType$;
  BehaviorSubject<MedicineType> get selectedMedicineType =>
      _selectedMedicineType$.stream;

  BehaviorSubject<int> _selectedInterval$;
  BehaviorSubject<int> get selectedInterval$ => _selectedInterval$;

  BehaviorSubject<String> _selectedTimeOfDay$;
  BehaviorSubject<String> get selectedTimeOfDay$ => _selectedTimeOfDay$;

  BehaviorSubject<EntryError> _errorState$;
  BehaviorSubject<EntryError> get errorState$ => _errorState$;

  NewEntryBloc() {
    _selectedMedicineType$ =
    BehaviorSubject<MedicineType>.seeded(MedicineType.None);
    // _checkedDays$ = BehaviorSubject<List<Day>>.seeded([]);
    _selectedTimeOfDay$ = BehaviorSubject<String>.seeded("None");
    _selectedInterval$ = BehaviorSubject<int>.seeded(0);
    _errorState$ = BehaviorSubject<EntryError>();
  }

  void dispose() {
    _selectedMedicineType$.close();
    // _checkedDays$.close();
    _selectedTimeOfDay$.close();
    _selectedInterval$.close();
  }

  void submitError(EntryError error) {
    _errorState$.add(error);
  }

  void updateInterval(int interval) {
    _selectedInterval$.add(interval);
  }

  void updateTime(String time) {
    _selectedTimeOfDay$.add(time);
  }

  void updateSelectedMedicine(MedicineType type) {
    MedicineType _tempType = _selectedMedicineType$.value;
    if (type == _tempType) {
      _selectedMedicineType$.add(MedicineType.None);
    } else {
      _selectedMedicineType$.add(type);
    }
  }
}