import 'package:flutter/material.dart';
import '../models/user_model.dart';
import '../db/user_database.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;

  UserModel? get currentUser => _currentUser;

  Future<bool> login(String email, String password) async {
    final user = await UserDatabase.instance.getUserByEmail(email);
    if (user != null && user.password == password) {
      _currentUser = user;
      notifyListeners();
      return true;
    }
    return false;
  }

  Future<bool> register(String name, String email, String password) async {
    final existing = await UserDatabase.instance.getUserByEmail(email);
    if (existing != null) return false;

    final newUser = UserModel(name: name, email: email, password: password);
    await UserDatabase.instance.insertUser(newUser);
    _currentUser = newUser;
    notifyListeners();
    return true;
  }

  void logout() {
    _currentUser = null;
    notifyListeners();
  }
}
