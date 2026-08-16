import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/routes.dart';
import '../../../../config/theme/theme.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/app_skeleton.dart';
import '../../../../riverpod/books_providers.dart';
import '../../../search/views/riverpod/search_providers.dart';

/// Horizontal row of illustrated category tiles. Tapping one jumps to the
/// search tab with that filter already applied.
class CategoryRow extends ConsumerWidget {
  const CategoryRow({super.key});

  static const _height = 116.0;
  static const _width = 150.0;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final categories = ref.watch(categoriesProvider);
    final theme = Theme.of(context);

    return SizedBox(
      height: _height,
      child: categories.when(
        loading: () => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
          itemCount: 4,
          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (_, __) => const AppSkeleton(
            width: _width,
            height: _height,
            borderRadius: AppRadius.lg,
          ),
        ),
        error: (_, __) => const SizedBox.shrink(),
        data: (categories) => ListView.separated(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: AppSpacing.gutter),
          itemCount: categories.length,
          separatorBuilder: (_, __) => const SizedBox(width: AppSpacing.sm),
          itemBuilder: (context, index) {
            final category = categories[index];
            return GestureDetector(
              onTap: () {
                ref
                    .read(selectedCategoryProvider.notifier)
                    .select(category.id);
                context.go(AppRoute.search);
              },
              child: SizedBox(
                width: _width,
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    boxShadow: AppShadows.soft,
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(AppRadius.lg),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        AppImage.cover(category.imageAsset, radius: 0),
                        const DecoratedBox(
                          decoration: BoxDecoration(
                            gradient: LinearGradient(
                              begin: Alignment.center,
                              end: Alignment.bottomCenter,
                              colors: [
                                Colors.transparent,
                                Color(0xB312102B),
                              ],
                            ),
                          ),
                        ),
                        Positioned(
                          left: AppSpacing.sm,
                          right: AppSpacing.xs,
                          bottom: AppSpacing.xs + 2,
                          child: Text(
                            category.name,
                            style: theme.textTheme.titleSmall
                                ?.copyWith(color: Colors.white),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
