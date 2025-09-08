// nyt_state.dart
import 'package:equatable/equatable.dart';
import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';


enum LayoutType { list, card }

class NYTState extends Equatable {
  final bool loading;
  final String? error;
  final String section;
  final String searchQuery;
  final LayoutType layout;
  final List<ArticleEntity> articles;

  const NYTState({
    this.loading = false,
    this.error,
    this.section = 'home',
    this.searchQuery = '',
    this.layout = LayoutType.list,
    this.articles = const [],
  });

  NYTState copyWith({
    bool? loading,
    String? error,
    String? section,
    String? searchQuery,
    LayoutType? layout,
    List<ArticleEntity>? articles,
  }) {
    return NYTState(
      loading: loading ?? this.loading,
      error: error,
      section: section ?? this.section,
      searchQuery: searchQuery ?? this.searchQuery,
      layout: layout ?? this.layout,
      articles: articles ?? this.articles,
    );
  }

  @override
  List<Object?> get props =>
      [loading, error, section, searchQuery, layout, articles];
}
