import 'package:flutter/material.dart';
import 'package:nyt_top_stories/features/nyt/domain/entities/article_entities.dart';
import 'package:nyt_top_stories/features/nyt/presentation/wodgets/article_card.dart';
import 'package:nyt_top_stories/features/nyt/presentation/wodgets/article_list_tile.dart';
import 'package:nyt_top_stories/features/nyt/presentation/wodgets/layout_toggle_button.dart';
import 'package:nyt_top_stories/features/nyt/presentation/wodgets/search_field.dart';
import 'package:nyt_top_stories/features/nyt/presentation/wodgets/section_filter_menu.dart';


enum LayoutType { list, card }

class TopStoriesPage extends StatefulWidget {
  const TopStoriesPage({super.key});

  @override
  State<TopStoriesPage> createState() => _TopStoriesPageState();
}

class _TopStoriesPageState extends State<TopStoriesPage> {
  LayoutType _layout = LayoutType.list;
  String _searchQuery = "";
  String _selectedSection = "home";

  // Mock articles
  final List<ArticleEntity> _articles = [
    ArticleEntity(
      title: "New Tech Innovations in AI",
      byline: "By John Doe",
      thumbnail:
          "https://static01.nyt.com/images/2023/09/29/business/29ai/29ai-thumbStandard.jpg",
      largeImage:
          "https://static01.nyt.com/images/2023/09/29/business/29ai/29ai-superJumbo.jpg", abstract: '', url: '',
    ),
    ArticleEntity(
      title: "World Leaders Meet at UN Summit",
      byline: "By Jane Smith",
      thumbnail:
          "https://static01.nyt.com/images/2023/09/28/world/28un/28un-thumbStandard.jpg",
      largeImage:
          "https://static01.nyt.com/images/2023/09/28/world/28un/28un-superJumbo.jpg",
          abstract: '',
      url: '',
    ),
    // ArticleEntity(
    //   title: "Sports Highlights of the Week",
    //   byline: "By Mike Johnson",
    //   thumbnail: null,
    //   largeImage: null,
    //   abstract: '',
    //   url: '',
    // ),
  ];

  @override
  Widget build(BuildContext context) {
    // Apply search filter
    final filtered = _articles.where((a) {
      final query = _searchQuery.toLowerCase();
      return a.title.toLowerCase().contains(query) ||
          a.byline.toLowerCase().contains(query);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('NYT Top Stories'),
        actions: [
          SectionFilter(
            onSectionSelected: (section) {
              setState(() {
                _selectedSection = section;
              });
            },
          ),
          LayoutToggle(
            currentLayout: _layout,
            onToggle: (layout) {
              setState(() {
                _layout = layout;
              });
            },
          ),
        ],
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(56),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: SearchBarWidget(
              onChanged: (value) {
                setState(() {
                  _searchQuery = value;
                });
              },
            ),
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {
          // mock refresh
          await Future.delayed(const Duration(seconds: 1));
        },
        child: filtered.isEmpty
            ? ListView(
                children: const [
                  SizedBox(height: 200),
                  Center(child: Text('No articles found')),
                ],
              )
            : _layout == LayoutType.list
                ? ListView.separated(
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (context, index) =>
                        ArticleListItem(article: filtered[index]),
                  )
                : GridView.builder(
                    padding: const EdgeInsets.all(8),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: 2,
                      childAspectRatio: 0.8,
                    ),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) =>
                        ArticleCard(article: filtered[index]),
                  ),
      ),
    );
  }
}
