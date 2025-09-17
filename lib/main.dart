import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

import 'package:nyt_top_stories/app.dart';
import 'package:nyt_top_stories/injection_container.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await dotenv.load(fileName: ".env");
  await setupAllFeatures();

  runApp(MyApp());
}
