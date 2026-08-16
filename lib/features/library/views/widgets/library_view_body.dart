import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/routes.dart';
import '../../../../config/theme/theme.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_skeleton.dart';
import '../../../../riverpod/books_providers.dart';
import '../../../../riverpod/favorites_provider.dart';
import '../../../books/views/widgets/book_card.dart';

/// Body of the library tab: saved favorites or a friendly empty state.
class LibraryViewBody extends ConsumerWidget {
  const LibraryViewBody({super.key});

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: AppSpacing.lg,
    crossAxisSpacing: AppSpacing.md,
    childAspectRatio: 0.60,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final favoriteIds = ref.watch(favoritesProvider);
    final books = ref.watch(booksProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.md,
            AppSpacing.gutter,
            0,
          ),
          child: Row(
            children: [
              Expanded(
                child: Text(
                  'My library',
                  style: theme.textTheme.headlineMedium,
                ),
              ),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: AppSpacing.sm,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppRadius.pill),
                ),
                child: Text(
                  '${favoriteIds.length} saved',
                  style: theme.textTheme.labelMedium
                      ?.copyWith(color: theme.colorScheme.primary),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: books.when(
            loading: () => GridView.builder(
              padding: const EdgeInsets.all(AppSpacing.gutter),
              gridDelegate: _gridDelegate,
              itemCount: 4,
              itemBuilder: (_, __) => const AppSkeleton(
                height: 220,
                borderRadius: AppRadius.lg,
              ),
            ),
            error: (error, _) => AppErrorView(
              onRetry: () => ref.invalidate(booksProvider),
            ),
            data: (books) {
              final favorites = books
                  .where((book) => favoriteIds.contains(book.id))
                  .toList();
              if (favorites.isEmpty) {
                return AppEmptyView(
                  asset: AppAssets.emptyLibrary,
                  title: 'Your shelf is empty',
                  message: 'Tap the heart on any story to keep it here.',
                  actionLabel: 'Find stories',
                  actionIcon: Icons.search_rounded,
                  onAction: () => context.go(AppRoute.search),
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(AppSpacing.gutter),
                gridDelegate: _gridDelegate,
                itemCount: favorites.length,
                itemBuilder: (context, index) =>
                    BookCard(book: favorites[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}
