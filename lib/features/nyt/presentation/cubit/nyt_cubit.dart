// lib/features/nyt/presentation/cubit/nyt_cubit.dart
import 'package:bloc/bloc.dart';
import 'package:nyt_top_stories/core/error/api_exception.dart';
import 'package:nyt_top_stories/core/error/data_parsing_exceptions.dart';
import 'package:nyt_top_stories/core/error/network_exceptions.dart';
import 'nyt_state.dart';
import 'package:nyt_top_stories/features/nyt/domain/repositories/nyt_repository.dart';

import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';

class NYTCubit extends Cubit<NYTState> {
  final NYTRepository repository;

  NYTCubit({required this.repository}) : super(const NYTState());

  Future<void> fetchTopStories({String? section}) async {
    final sec = section ?? state.section;
    emit(state.copyWith(loading: true, error: null, section: sec));

    try {
      final articles = await repository.getTopStories(sec);
      emit(state.copyWith(loading: false, articles: articles, error: null));
    } on NetworkException catch (e) {
      emit(state.copyWith(loading: false, error: e.message));
    } on ApiException catch (e) {
      final msg = e.message.isNotEmpty
          ? e.message
          : 'Server error (${e.statusCode ?? 'unknown'})';
      emit(state.copyWith(loading: false, error: msg));
    } on DataParsingException catch (e) {
      emit(state.copyWith(
          loading: false, error: 'Data parsing error: ${e.message}'));
    } catch (e) {
      emit(state.copyWith(loading: false, error: 'Unexpected error: $e'));
    }
  }

  void search(String query) {
    emit(state.copyWith(searchQuery: query));
  }

  void setLayout(LayoutType layout) {
    emit(state.copyWith(layout: layout));
  }

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
