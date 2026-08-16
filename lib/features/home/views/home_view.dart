import 'package:flutter/material.dart';

import 'widgets/home_view_body.dart';

/// Home tab — featured stories, categories and the full bookshelf.
class HomeView extends StatelessWidget {
  const HomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: HomeViewBody()),
    );
  }
}
