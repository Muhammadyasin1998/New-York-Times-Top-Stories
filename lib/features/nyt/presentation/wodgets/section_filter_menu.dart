import 'package:flutter/material.dart';

class SectionFilter extends StatelessWidget {
  final List<String> sections = [
    'home',
    'world',
    'science',
    'technology',
    'sports',
    'arts',
    'business',
    'us'
  ];

  final ValueChanged<String> onSectionSelected;

   SectionFilter({super.key, required this.onSectionSelected});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<String>(
      icon: const Icon(Icons.filter_list),
      onSelected: onSectionSelected,
      itemBuilder: (ctx) =>
          sections.map((s) => PopupMenuItem(value: s, child: Text(s))).toList(),
    );
  }
}
