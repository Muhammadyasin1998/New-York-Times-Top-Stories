// nyt_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';

import 'package:nyt_top_stories/features/nyt/domain/repositories/nyt_repository.dart';

import 'nyt_state.dart';

class NYTCubit extends Cubit<NYTState> {
  final NYTRepository repository;
  NYTCubit({required this.repository}) : super(const NYTState());

  Future<void> fetchTopStories({String? section}) async {
    final sec = section ?? state.section;
    emit(state.copyWith(loading: true, error: null, section: sec));
    try {
      final articles = await repository.getTopStories(sec);
      emit(state.copyWith(loading: false, articles: articles, error: null));
    } catch (e) {
      emit(state.copyWith(loading: false, error: e.toString()));
    }
  }

  void search(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setLayout(LayoutType layout) {
    emit(state.copyWith(layout: layout));
  }

  // client-side filter (title or author)
  List<ArticleEntity> get filteredArticles {
    final q = state.searchQuery.trim().toLowerCase();
    if (q.isEmpty) return state.articles;
    return state.articles
        .where((a) =>
            a.title.toLowerCase().contains(q) ||
            a.author.toLowerCase().contains(q))
        .toList();
  }
}
