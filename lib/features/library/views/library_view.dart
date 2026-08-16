import 'package:flutter/material.dart';

import 'widgets/library_view_body.dart';

/// Library tab — the child's saved favorite stories.
class LibraryView extends StatelessWidget {
  const LibraryView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: LibraryViewBody()),
    );
  }
}
