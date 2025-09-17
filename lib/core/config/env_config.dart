// lib/core/config/env_config.dart
import 'package:flutter_dotenv/flutter_dotenv.dart';

class EnvConfig {
  static String get baseUrl => dotenv.env['BASE_URL'] ?? '';
  static String get apiKey => dotenv.env['API_KEY'] ?? '';
}
