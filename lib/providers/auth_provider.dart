import 'package:flutter/material.dart';

class AuthUser {
  final String? id;
  final String? email;

  AuthUser({required this.id, required this.email});
}

class AuthProvider with ChangeNotifier {
  AuthUser? _user;
  bool _isAuthenticated = false;

  AuthUser? get user => _user;
  bool get isAuthenticated => _isAuthenticated;
  String? get userId => _user?.id;
  String? get userEmail => _user?.email;

  Future<void> login(String email, String password) async {
    try {
      // TODO: Implement actual login logic
      _user = AuthUser(id: 'user_123', email: email);
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      _user = null;
      _isAuthenticated = false;
      rethrow;
    }
  }

  Future<void> logout() async {
    try {
      // TODO: Implement actual logout logic
      _user = null;
      _isAuthenticated = false;
      notifyListeners();
    } catch (e) {
      rethrow;
    }
  }

  Future<void> register(String email, String password) async {
    try {
      // TODO: Implement actual registration logic
      _user = AuthUser(id: 'user_123', email: email);
      _isAuthenticated = true;
      notifyListeners();
    } catch (e) {
      _user = null;
      _isAuthenticated = false;
      rethrow;
    }
  }
}
