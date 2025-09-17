import 'package:nyt_top_stories/core/di/core_injection.dart';
import 'package:nyt_top_stories/features/auth/di/injection.dart';
import 'package:nyt_top_stories/features/nyt/di/injection.dart';

Future<void> setupAllFeatures() async {
  await initDependencies();
  await setupNYTDependencies();
  await setupAuthDependencies();
}
