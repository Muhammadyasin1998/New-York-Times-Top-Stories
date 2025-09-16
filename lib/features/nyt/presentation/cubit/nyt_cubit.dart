import 'package:bloc/bloc.dart';

import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';
import 'package:nyt_top_stories/features/nyt/domain/usecases/get_top_stories.dart';

import 'nyt_state.dart';

class NYTCubit extends Cubit<NYTState> {
  final GetTopStories getTopStories;

  NYTCubit({required this.getTopStories}) : super(const NYTState());

  Future<void> fetchTopStories({String? section}) async {
    final sec = section ?? state.section;
    emit(state.copyWith(loading: true, error: null, section: sec));

    final result = await getTopStories(sec);

    result.fold(
      (failure) {
        emit(state.copyWith(
          loading: false,
          error: failure.message,
        ));
      },
      (articles) {
        emit(state.copyWith(
          loading: false,
          articles: articles,
          error: null,
        ));
      },
    );
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
