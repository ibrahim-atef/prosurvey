import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../../models/user_model.dart';

class LocalStorage {
  final SharedPreferences _prefs;
  
  static const String userKey = 'user_data';
  static const String tokenKey = 'auth_token';
  static const String isLoggedInKey = 'is_logged_in';

  LocalStorage(this._prefs);

  // User data
  Future<void> saveUser(UserModel user) async {
    await _prefs.setString(userKey, jsonEncode(user.toJson()));
  }

  UserModel? getUser() {
    final userData = _prefs.getString(userKey);
    if (userData != null) {
      return UserModel.fromJson(jsonDecode(userData));
    }
    return null;
  }

  Future<void> clearUser() async {
    await _prefs.remove(userKey);
  }

  // Authentication
  Future<void> saveToken(String token) async {
    await _prefs.setString(tokenKey, token);
  }

  String? getToken() {
    return _prefs.getString(tokenKey);
  }

  Future<void> clearToken() async {
    await _prefs.remove(tokenKey);
  }

  Future<void> setLoggedIn(bool isLoggedIn) async {
    await _prefs.setBool(isLoggedInKey, isLoggedIn);
  }

  bool isLoggedIn() {
    return _prefs.getBool(isLoggedInKey) ?? false;
  }

  // Clear all data
  Future<void> clearAll() async {
    await _prefs.clear();
  }
}
