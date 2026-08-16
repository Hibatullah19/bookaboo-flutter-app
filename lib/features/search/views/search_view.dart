import 'package:flutter/material.dart';

import 'widgets/search_view_body.dart';

/// Search tab — find stories by name, author or category.
class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: SearchViewBody()),
    );
  }
}
