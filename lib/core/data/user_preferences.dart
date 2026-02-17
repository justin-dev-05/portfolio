import 'dart:convert';
import 'package:pdi_dost/features/auth/model/LoginModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserPreferences {
  static final UserPreferences _instance = UserPreferences._internal();
  factory UserPreferences() => _instance;
  UserPreferences._internal();

  static const String _keyFirebaseToken = 'firebase_token';
  static const String _keyIsFromNotification = 'is_from_notification';
  static const String _keyEventId = 'event_id';
  static const String _keyEventName = 'event_name';
  static const String loginKey = 'USER_DATA';

  Future<void> saveSignInInfo(LoginData? data) async {
    final prefs = await SharedPreferences.getInstance();
    if (data == null) {
      await prefs.remove(loginKey);
    } else {
      await prefs.setString(loginKey, json.encode(data.toJson()));
    }
  }

  Future<LoginData?> getSignInInfo() async {
    final prefs = await SharedPreferences.getInstance();
    String? jsonString = prefs.getString(loginKey);
    if (jsonString != null) {
      Map<String, dynamic> jsonMap = json.decode(jsonString);
      return LoginData.fromJson(jsonMap);
    }
    return null;
  }

  Future<void> clearSignInInfo() async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.remove(loginKey);
  }

  Future<void> setFirebaseToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyFirebaseToken, token);
  }

  Future<String> getFirebaseToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString(_keyFirebaseToken) ?? '';
  }

  Future<void> setIsFromNotification(bool value) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setBool(_keyIsFromNotification, value);
  }

  Future<bool> getIsFromNotification() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool(_keyIsFromNotification) ?? false;
  }

  Future<void> setEventId(String id) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEventId, id);
  }

  Future<void> setEventName(String name) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_keyEventName, name);
  }
}
