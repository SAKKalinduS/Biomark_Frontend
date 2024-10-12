import 'package:flutter/foundation.dart';
import '../models/personal_data.dart';

class DataService extends ChangeNotifier {
  Future<PersonalData> getPersonalData() async {
    // TODO: Implement actual data retrieval logic
    return PersonalData(
      fullName: 'John Doe',
      email: 'john@example.com',
      dateOfBirth: '1990-01-01',
      bloodGroup: 'A+',
      sex: 'Male',
      height: 180.0,
      ethnicity: 'Caucasian',
      eyeColor: 'Brown',
    );
  }

  Future<void> updatePersonalData(PersonalData data) async {
    // TODO: Implement actual data update logic
    notifyListeners();
  }

  Future<void> unsubscribe() async {
    // TODO: Implement actual unsubscribe logic
    notifyListeners();
  }
}