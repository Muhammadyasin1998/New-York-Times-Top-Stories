import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'dart:convert';

class TokenLocalDataSource {
  final FlutterSecureStorage storage;

  TokenLocalDataSource(this.storage);

  Future<void> saveAuthData(String accessToken, String refreshToken,
      Map<String, dynamic> userJson) async {
    await storage.write(key: 'access_token', value: accessToken);
    await storage.write(key: 'refresh_token', value: refreshToken);
    await storage.write(key: 'user_data', value: jsonEncode(userJson));
  }

  Future<String?> getAccessToken() async =>
      await storage.read(key: 'access_token');
  Future<String?> getRefreshToken() async =>
      await storage.read(key: 'refresh_token');

  Future<Map<String, dynamic>?> getUserData() async {
    final jsonString = await storage.read(key: 'user_data');
    return jsonString != null ? jsonDecode(jsonString) : null;
  }

  Future<void> clear() async => await storage.deleteAll();
}
