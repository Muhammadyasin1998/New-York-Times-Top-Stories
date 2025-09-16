


import 'package:nyt_top_stories/core/di/injection.dart';
import 'package:nyt_top_stories/features/nyt/di/injection.dart';

Future<void> setupAllFeatures() async {
  
await initDependencies();
await setupNYTDependencies();

}
