// features/auth/data/datasource/auth_local_datasource.dart
import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';
import 'package:nyt_top_stories/features/auth/data/models/user_model.dart';

abstract class IAuthLocalDataSource {
  Future<void> saveToken(String token);
  Future<void> saveUser(UserModel user);
  Future<String?> getToken();
  Future<UserModel?> getUser();
  Future<void> clear();
}

class AuthLocalDataSourceImpl implements IAuthLocalDataSource {
  final SharedPreferences prefs;

  AuthLocalDataSourceImpl(this.prefs);

  static const _tokenKey = "ACCESS_TOKEN";
  static const _userKey = "USER_DATA";

  @override
  Future<void> saveToken(String token) async {
    await prefs.setString(_tokenKey, token);
  }

  @override
  Future<void> saveUser(UserModel user) async {
    await prefs.setString(_userKey, user.toJson().toString());
  }

  @override
  Future<String?> getToken() async {
    return prefs.getString(_tokenKey);
  }

@override
  Future<UserModel?> getUser() async {
    final jsonStr = prefs.getString(_userKey);
    if (jsonStr == null) return null;

    final Map<String, dynamic> jsonMap = jsonDecode(jsonStr);
    return UserModel.fromJson(jsonMap);
  }

  @override
  Future<void> clear() async {
    await prefs.remove(_tokenKey);
    await prefs.remove(_userKey);
  }
}
