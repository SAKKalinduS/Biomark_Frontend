import 'package:flutter/foundation.dart';
import '../models/user.dart';

class AuthService extends ChangeNotifier {
  User? _currentUser;

  User? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    // TODO: Implement actual login logic
    _currentUser = User(email: email);
    notifyListeners();
    return true;
  }

  Future<bool> register(User user) async {
    // TODO: Implement actual registration logic
    _currentUser = user;
    notifyListeners();
    return true;
  }

  Future<bool> recoverAccount(String fullName, String dateOfBirth, String answer1, String answer2) async {
    // TODO: Implement actual account recovery logic
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}