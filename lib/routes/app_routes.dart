import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';
import 'package:nyt_top_stories/features/nyt/presentation/pages/article_detail_page.dart';
import 'package:nyt_top_stories/features/nyt/presentation/pages/article_webview_page.dart';
import 'package:nyt_top_stories/features/nyt/presentation/pages/top_stories_page.dart';
import '../splash_screen.dart';


class AppRouter {
  static final router = GoRouter(
    initialLocation: '/',
    routes: [
      // Splash
      GoRoute(
        path: '/',
        builder: (context, state) => const SplashScreen(),
      ),

      // Top Stories
      GoRoute(
        path: '/top-stories',
        builder: (context, state) => const TopStoriesPage(),
      ),

    
      GoRoute(
        path: '/article-detail',
        builder: (context, state) {
          final article = state.extra as ArticleEntity;
          return ArticleDetailPage(article: article);
        },
      ),

      // GoRoute(
      //   path: '/article-webview',
      //   builder: (context, state) {
      //     final data = state.extra as Map<String, dynamic>;
      //     return ArticleWebViewPage(
      //       url: data['url'] as String,
      //       title: data['title'] as String,
      //     );
      //   },
      // ),
    ],
  );
}
