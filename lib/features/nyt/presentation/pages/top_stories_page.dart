// top_stories_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nyt_top_stories/features/nyt/presentation/cubit/nyt_cubit.dart';
import 'package:nyt_top_stories/features/nyt/presentation/cubit/nyt_state.dart';


import 'package:nyt_top_stories/features/nyt/presentation/wodgets/article_card.dart';
import 'package:nyt_top_stories/features/nyt/presentation/wodgets/article_list_tile.dart';
import 'package:nyt_top_stories/features/nyt/presentation/wodgets/layout_toggle_button.dart';
import 'package:nyt_top_stories/features/nyt/presentation/wodgets/search_field.dart';
import 'package:nyt_top_stories/features/nyt/presentation/wodgets/section_filter_menu.dart';

class TopStoriesPage extends StatefulWidget {
  const TopStoriesPage({super.key});

  @override
  State<TopStoriesPage> createState() => _TopStoriesPageState();
}

class _TopStoriesPageState extends State<TopStoriesPage> {
  @override
  void initState() {
    super.initState();

    context.read<NYTCubit>().fetchTopStories(section: "arts");
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NYTCubit, NYTState>(
      builder: (context, state) {
        final cubit = context.read<NYTCubit>();
        final filtered = cubit.filteredArticles;

        return Scaffold(
          appBar: AppBar(
            title: const Text('NYT Top Stories'),
            actions: [
              SectionFilter(
                onSectionSelected: (section) {
                  cubit.fetchTopStories(section: section);
                },
              ),
              LayoutToggle(
                currentLayout: state.layout,
                onToggle: cubit.setLayout,
              ),
            ],
            bottom: PreferredSize(
              preferredSize: const Size.fromHeight(56),
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: SearchBarWidget(
                  onChanged: cubit.search,
                ),
              ),
            ),
          ),
          body: RefreshIndicator(
            onRefresh: () => cubit.fetchTopStories(section: state.section),
            child: Builder(
              builder: (_) {
                if (state.loading) {
                  return const Center(child: CircularProgressIndicator());
                } else if (state.error != null) {
                  return ListView(
                    children: [
                      const SizedBox(height: 200),
                      Center(
                        child: Text(
                          "Error: ${state.error}",
                          style: const TextStyle(color: Colors.red),
                        ),
                      ),
                    ],
                  );
                } else if (filtered.isEmpty) {
                  return ListView(
                    children: const [
                      SizedBox(height: 200),
                      Center(child: Text("No articles found")),
                    ],
                  );
                }

                return state.layout == LayoutType.list
                    ? ListView.separated(
                        physics: const AlwaysScrollableScrollPhysics(),
                        itemCount: filtered.length,
                        separatorBuilder: (_, __) => const Divider(height: 1),
                        itemBuilder: (context, index) =>
                            ArticleListItem(article: filtered[index]),
                      )
                    : GridView.builder(
                        physics: const AlwaysScrollableScrollPhysics(),
                        padding: const EdgeInsets.all(8),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          childAspectRatio: 0.8,
                        ),
                        itemCount: filtered.length,
                        itemBuilder: (context, index) =>
                            ArticleCard(article: filtered[index]),
                      );
              },
            ),
          ),
        );
      },
    );
  }
}
