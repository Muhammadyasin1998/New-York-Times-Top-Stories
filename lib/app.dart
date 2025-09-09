// app.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyt_top_stories/features/nyt/presentation/cubit/nyt_cubit.dart';
import 'package:nyt_top_stories/routes/app_routes.dart'; // your GoRouter setup
import 'features/nyt/di/injection.dart';

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<NYTCubit>(
          create: (_) => getIt<NYTCubit>(),
        ),
      ],
      child: MaterialApp.router(
        debugShowCheckedModeBanner: false,
        title: 'NYT Top Stories',
        theme: ThemeData(
          primaryColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            foregroundColor: Colors.black, 
          ),
        ),
        routerConfig: AppRouter.router, 
      ),
    );
  }
}
