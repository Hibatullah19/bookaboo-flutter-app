import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/app_empty_view.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_search_bar.dart';
import '../../../../core/widgets/app_skeleton.dart';
import '../../../../riverpod/books_providers.dart';
import '../../../books/views/widgets/book_card.dart';
import '../riverpod/search_providers.dart';

/// Body of the search tab: search bar, category filters and results grid.
class SearchViewBody extends ConsumerWidget {
  const SearchViewBody({super.key});

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: AppSpacing.lg,
    crossAxisSpacing: AppSpacing.md,
    childAspectRatio: 0.60,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final results = ref.watch(searchResultsProvider);
    final categories = ref.watch(categoriesProvider);
    final selected = ref.watch(selectedCategoryProvider);

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.fromLTRB(
            AppSpacing.gutter,
            AppSpacing.md,
            AppSpacing.gutter,
            AppSpacing.md,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text('Find a story', style: theme.textTheme.headlineMedium),
              const SizedBox(height: AppSpacing.md),
              AppSearchBar(
                onChanged: (value) =>
                    ref.read(searchQueryProvider.notifier).setQuery(value),
              ),
            ],
          ),
        ),
        SizedBox(
          height: 40,
          child: categories.when(
            loading: () => const SizedBox.shrink(),
            error: (_, __) => const SizedBox.shrink(),
            data: (categories) => ListView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(
                horizontal: AppSpacing.gutter,
              ),
              children: [
                _FilterPill(
                  label: 'All',
                  selected: selected == null,
                  onTap: () =>
                      ref.read(selectedCategoryProvider.notifier).select(null),
                ),
                for (final category in categories)
                  _FilterPill(
                    label: category.name,
                    color: Color(category.color),
                    selected: selected == category.id,
                    onTap: () =>
                        ref.read(selectedCategoryProvider.notifier).select(
                              selected == category.id ? null : category.id,
                            ),
                  ),
              ],
            ),
          ),
        ),
        Expanded(
          child: results.when(
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
              if (books.isEmpty) {
                return const AppEmptyView(
                  asset: AppAssets.emptySearch,
                  title: 'No stories found',
                  message: 'Try a different word, or pick another mood.',
                );
              }
              return GridView.builder(
                padding: const EdgeInsets.all(AppSpacing.gutter),
                gridDelegate: _gridDelegate,
                itemCount: books.length,
                itemBuilder: (context, index) => BookCard(book: books[index]),
              );
            },
          ),
        ),
      ],
    );
  }
}

class _FilterPill extends StatelessWidget {
  const _FilterPill({
    required this.label,
    required this.selected,
    required this.onTap,
    this.color,
  });

  final String label;
  final bool selected;
  final VoidCallback onTap;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = color ?? theme.colorScheme.primary;
    return Padding(
      padding: const EdgeInsets.only(right: AppSpacing.xs),
      child: GestureDetector(
        onTap: onTap,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 180),
          padding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.md,
            vertical: AppSpacing.xs,
          ),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            color: selected
                ? accent
                : theme.colorScheme.surfaceContainerHighest,
            borderRadius: BorderRadius.circular(AppRadius.pill),
            boxShadow: selected ? AppShadows.glow(accent) : null,
          ),
          child: Text(
            label,
            style: theme.textTheme.labelMedium?.copyWith(
              color: selected ? Colors.white : theme.colorScheme.onSurface,
            ),
          ),
        ),
      ),
    );
  }
}
