import 'package:flutter/material.dart';
import 'package:nyt_top_stories/features/nyt/presentation/pages/top_stories_page.dart';

class LayoutToggle extends StatelessWidget {
  final LayoutType currentLayout;
  final ValueChanged<LayoutType> onToggle;

  const LayoutToggle(
      {super.key, required this.currentLayout, required this.onToggle});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      icon: Icon(
        currentLayout == LayoutType.list ? Icons.view_module : Icons.view_list,
      ),
      onPressed: () {
        onToggle(currentLayout == LayoutType.list
            ? LayoutType.card
            : LayoutType.list);
      },
    );
  }
}
