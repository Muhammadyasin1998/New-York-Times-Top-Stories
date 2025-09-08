// app.dart
import 'package:flutter/material.dart';
import 'package:nyt_top_stories/routes/app_routes.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      debugShowCheckedModeBanner: false,
      title: 'NYT Top Stories',
      routerConfig: AppRouter.router,
    );
  }
}
