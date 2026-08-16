import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/routes.dart';
import '../../../../config/theme/theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../riverpod/favorites_provider.dart';
import '../../../books/data/models/book_model.dart';

/// Body of the book details page: a collapsing cover header over the
/// story blurb, with the read action pinned to the bottom.
class BookDetailsViewBody extends ConsumerWidget {
  const BookDetailsViewBody({super.key, required this.book});

  final Book book;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final isFavorite = ref.watch(favoritesProvider).contains(book.id);

    void toggleFavorite() {
      ref.read(favoritesProvider.notifier).toggle(book.id);
      ScaffoldMessenger.of(context)
        ..hideCurrentSnackBar()
        ..showSnackBar(
          SnackBar(
            content: Text(
              isFavorite
                  ? 'Removed from your library'
                  : 'Saved to your library',
            ),
          ),
        );
    }

    return Stack(
      children: [
        CustomScrollView(
          slivers: [
            SliverAppBar(
              expandedHeight: 380,
              pinned: true,
              stretch: true,
              backgroundColor: Color(book.coverColor),
              foregroundColor: Colors.white,
              leading: _RoundIconButton(
                icon: Icons.arrow_back_rounded,
                onTap: () =>
                    context.canPop() ? context.pop() : context.go(AppRoute.home),
              ),
              actions: [
                _RoundIconButton(
                  icon: isFavorite
                      ? Icons.favorite_rounded
                      : Icons.favorite_border_rounded,
                  iconColor: isFavorite ? AppColors.coral : Colors.white,
                  onTap: toggleFavorite,
                ),
                const SizedBox(width: AppSpacing.xs),
              ],
              flexibleSpace: FlexibleSpaceBar(
                stretchModes: const [
                  StretchMode.zoomBackground,
                  StretchMode.blurBackground,
                ],
                background: Stack(
                  fit: StackFit.expand,
                  children: [
                    AppImage.cover(
                      book.coverAsset,
                      radius: 0,
                      alignment: Alignment.topCenter,
                    ),
                    DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.black.withValues(alpha: 0.28),
                            Colors.transparent,
                            theme.scaffoldBackgroundColor,
                          ],
                          stops: const [0, 0.45, 1],
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: const EdgeInsets.fromLTRB(
                  AppSpacing.gutter,
                  0,
                  AppSpacing.gutter,
                  120,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(book.title, style: theme.textTheme.displaySmall),
                    const SizedBox(height: AppSpacing.xxs),
                    Text(
                      'by ${book.author}',
                      style: theme.textTheme.bodyMedium,
                    ),
                    const SizedBox(height: AppSpacing.md),
                    Wrap(
                      spacing: AppSpacing.xs,
                      runSpacing: AppSpacing.xs,
                      children: [
                        _MetaPill(
                          icon: Icons.star_rounded,
                          label: book.rating.toStringAsFixed(1),
                          color: AppColors.amber,
                        ),
                        _MetaPill(
                          icon: Icons.schedule_rounded,
                          label: '${book.minutes} min',
                          color: AppColors.teal,
                        ),
                        _MetaPill(
                          icon: Icons.cake_rounded,
                          label: 'ages ${book.ageMin}–${book.ageMax}',
                          color: AppColors.rose,
                        ),
                        _MetaPill(
                          icon: Icons.menu_book_rounded,
                          label: '${book.pages.length} pages',
                          color: AppColors.primary,
                        ),
                      ],
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text(
                      'About this story',
                      style: theme.textTheme.titleLarge,
                    ),
                    const SizedBox(height: AppSpacing.xs),
                    Text(
                      book.description,
                      style: theme.textTheme.bodyLarge?.copyWith(height: 1.65),
                    ),
                    const SizedBox(height: AppSpacing.xl),
                    Text('First pages', style: theme.textTheme.titleLarge),
                    const SizedBox(height: AppSpacing.sm),
                    for (final page in book.pages.take(2))
                      Padding(
                        padding: const EdgeInsets.only(bottom: AppSpacing.sm),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              page.emoji,
                              style: const TextStyle(fontSize: 24),
                            ),
                            const SizedBox(width: AppSpacing.sm),
                            Expanded(
                              child: Text(
                                page.text,
                                style: theme.textTheme.bodyMedium,
                              ),
                            ),
                          ],
                        ),
                      ),
                  ],
                ),
              ),
            ),
          ],
        ),

        // Pinned actions
        Positioned(
          left: 0,
          right: 0,
          bottom: 0,
          child: Container(
            padding: EdgeInsets.fromLTRB(
              AppSpacing.gutter,
              AppSpacing.md,
              AppSpacing.gutter,
              AppSpacing.md + MediaQuery.of(context).padding.bottom,
            ),
            decoration: BoxDecoration(
              color: theme.scaffoldBackgroundColor,
              boxShadow: AppShadows.medium,
            ),
            child: Row(
              children: [
                Expanded(
                  child: AppButton(
                    label: 'Read now',
                    icon: Icons.menu_book_rounded,
                    onPressed: () => context.push(AppRoute.reader(book.id)),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                SizedBox(
                  height: 56,
                  width: 56,
                  child: OutlinedButton(
                    onPressed: toggleFavorite,
                    style: OutlinedButton.styleFrom(
                      padding: EdgeInsets.zero,
                      minimumSize: const Size(56, 56),
                    ),
                    child: Icon(
                      isFavorite
                          ? Icons.favorite_rounded
                          : Icons.favorite_border_rounded,
                      color: isFavorite
                          ? AppColors.coral
                          : theme.colorScheme.onSurface,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class _RoundIconButton extends StatelessWidget {
  const _RoundIconButton({
    required this.icon,
    required this.onTap,
    this.iconColor = Colors.white,
  });

  final IconData icon;
  final VoidCallback onTap;
  final Color iconColor;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Material(
        color: Colors.black.withValues(alpha: 0.28),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.xs),
            child: Icon(icon, color: iconColor, size: 20),
          ),
        ),
      ),
    );
  }
}

class _MetaPill extends StatelessWidget {
  const _MetaPill({
    required this.icon,
    required this.label,
    required this.color,
  });

  final IconData icon;
  final String label;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
        horizontal: AppSpacing.sm,
        vertical: AppSpacing.xs,
      ),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(AppRadius.pill),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 14, color: color),
          const SizedBox(width: 6),
          Text(
            label,
            style: Theme.of(context)
                .textTheme
                .labelMedium
                ?.copyWith(color: Theme.of(context).colorScheme.onSurface),
          ),
        ],
      ),
    );
  }
}
