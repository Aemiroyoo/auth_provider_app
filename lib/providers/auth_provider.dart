import 'dart:async';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/user_model.dart';
import '../db/user_database.dart';

class AuthProvider with ChangeNotifier {
  UserModel? _currentUser;
  UserModel? get currentUser => _currentUser;

  Timer? _logoutTimer;

  AuthProvider() {
    loadUserFromPrefs();
  }

  Future<void> loadUserFromPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    final email = prefs.getString('loggedInEmail');
    if (email != null) {
      final user = await UserDatabase.instance.getUserByEmail(email);
      if (user != null) {
        _currentUser = user;
        notifyListeners();
        _startAutoLogoutTimer();
      }
    }
  }

  Future<void> _saveUserToPrefs(String email) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('loggedInEmail', email);
  }

  Future<void> _clearUserPrefs() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove('loggedInEmail');
  }

  void _startAutoLogoutTimer() {
    _logoutTimer?.cancel();
    _logoutTimer = Timer(const Duration(minutes: 1), () {
      logout();
    });
  }

  void logout() {
    print('➡️ LOGOUT triggered');
    _currentUser = null;
    _logoutTimer?.cancel();
    _clearUserPrefs();
    notifyListeners(); // ini yang trigger MyApp rebuild
  }

  Future<bool> login(String email, String password) async {
    final user = await UserDatabase.instance.getUserByEmail(email);
    if (user != null && user.password == password) {
      _currentUser = user;
      await _saveUserToPrefs(email);
      notifyListeners();
      _startAutoLogoutTimer();
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
    await _saveUserToPrefs(email);
    notifyListeners();
    _startAutoLogoutTimer();
    return true;
  }
}
