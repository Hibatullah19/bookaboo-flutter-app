import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/routes.dart';
import '../../../../config/theme/theme.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/app_error_view.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/app_skeleton.dart';
import '../../../../riverpod/books_providers.dart';
import '../../../auth/riverpod/auth_controller.dart';
import '../../../books/views/widgets/book_card.dart';
import 'category_row.dart';
import 'featured_book_card.dart';

/// Scrollable body of the home tab.
class HomeViewBody extends ConsumerWidget {
  const HomeViewBody({super.key});

  static const _gridDelegate = SliverGridDelegateWithFixedCrossAxisCount(
    crossAxisCount: 2,
    mainAxisSpacing: AppSpacing.lg,
    crossAxisSpacing: AppSpacing.md,
    childAspectRatio: 0.60,
  );

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final theme = Theme.of(context);
    final featured = ref.watch(featuredBooksProvider);
    final books = ref.watch(booksProvider);
    final user = ref.watch(authControllerProvider);

    return RefreshIndicator(
      onRefresh: () async => ref.invalidate(booksProvider),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(
                AppSpacing.gutter,
                AppSpacing.md,
                AppSpacing.gutter,
                0,
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          user == null
                              ? 'Hi there'
                              : 'Hi ${user.displayName}',
                          style: theme.textTheme.bodyMedium,
                        ),
                        Text(
                          'What shall we read today?',
                          style: theme.textTheme.headlineMedium,
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: AppSpacing.sm),
                  GestureDetector(
                    onTap: () => context.go(AppRoute.profile),
                    child: AppImage.cover(
                      AppAssets.avatar(user?.avatarIndex ?? 0),
                      width: 48,
                      height: 48,
                      radius: AppRadius.pill,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const _SectionHeader('Featured today'),
          SliverToBoxAdapter(
            child: SizedBox(
              height: 200,
              child: featured.when(
                loading: () => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.gutter,
                  ),
                  itemCount: 2,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.md),
                  itemBuilder: (_, __) => const AppSkeleton(
                    width: 300,
                    height: 200,
                    borderRadius: AppRadius.xl,
                  ),
                ),
                error: (error, _) => AppErrorView(
                  onRetry: () => ref.invalidate(booksProvider),
                ),
                data: (books) => ListView.separated(
                  scrollDirection: Axis.horizontal,
                  padding: const EdgeInsets.symmetric(
                    horizontal: AppSpacing.gutter,
                  ),
                  itemCount: books.length,
                  separatorBuilder: (_, __) =>
                      const SizedBox(width: AppSpacing.md),
                  itemBuilder: (context, index) =>
                      FeaturedBookCard(book: books[index]),
                ),
              ),
            ),
          ),
          const _SectionHeader('Browse by mood'),
          const SliverToBoxAdapter(child: CategoryRow()),
          const _SectionHeader('All stories'),
          SliverPadding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.gutter,
              0,
              AppSpacing.gutter,
              AppSpacing.xl,
            ),
            sliver: books.when(
              loading: () => SliverGrid.builder(
                gridDelegate: _gridDelegate,
                itemCount: 6,
                itemBuilder: (_, __) => const AppSkeleton(
                  height: 220,
                  borderRadius: AppRadius.lg,
                ),
              ),
              error: (error, _) => SliverToBoxAdapter(
                child: AppErrorView(
                  onRetry: () => ref.invalidate(booksProvider),
                ),
              ),
              data: (books) => SliverGrid.builder(
                gridDelegate: _gridDelegate,
                itemCount: books.length,
                itemBuilder: (context, index) => BookCard(book: books[index]),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _SectionHeader extends StatelessWidget {
  const _SectionHeader(this.title);

  final String title;

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: const EdgeInsets.fromLTRB(
          AppSpacing.gutter,
          AppSpacing.xl,
          AppSpacing.gutter,
          AppSpacing.sm,
        ),
        child: Text(title, style: Theme.of(context).textTheme.titleLarge),
      ),
    );
  }
}
