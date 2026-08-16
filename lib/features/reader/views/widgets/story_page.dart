import 'package:flutter/material.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../books/data/models/book_model.dart';

/// One page of the story: an illustrated panel using the book's artwork,
/// with the page's own character sitting in front of it.
class StoryPage extends StatelessWidget {
  const StoryPage({
    super.key,
    required this.page,
    required this.book,
  });

  final BookPage page;
  final Book book;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.xl,
        vertical: AppSpacing.md,
      ),
      child: Column(
        children: [
          Expanded(
            flex: 3,
            child: DecoratedBox(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(AppRadius.xl),
                boxShadow: AppShadows.medium,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(AppRadius.xl),
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppImage.cover(book.coverAsset, radius: 0),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        color: Colors.black.withValues(alpha: 0.16),
                      ),
                    ),
                    Center(
                      child: Text(
                        page.emoji,
                        style: const TextStyle(
                          fontSize: 110,
                          shadows: [
                            Shadow(
                              color: Color(0x66000000),
                              blurRadius: 24,
                              offset: Offset(0, 8),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Expanded(
            flex: 2,
            child: SingleChildScrollView(
              child: Text(
                page.text,
                textAlign: TextAlign.center,
                style: theme.textTheme.headlineSmall?.copyWith(height: 1.5),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
