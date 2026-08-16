import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/app_skeleton.dart';
import '../../../riverpod/books_providers.dart';
import 'widgets/book_details_view_body.dart';

/// Full-screen details page for a single book.
class BookDetailsView extends ConsumerWidget {
  const BookDetailsView({super.key, required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookByIdProvider(bookId));
    return Scaffold(
      body: book.when(
        loading: () => const _BookDetailsSkeleton(),
        error: (error, _) => SafeArea(
          child: AppErrorView(
            message: "We couldn't find that story!",
            onRetry: () => ref.invalidate(bookByIdProvider(bookId)),
          ),
        ),
        data: (book) => BookDetailsViewBody(book: book),
      ),
    );
  }
}

class _BookDetailsSkeleton extends StatelessWidget {
  const _BookDetailsSkeleton();

  @override
  Widget build(BuildContext context) {
    return const SafeArea(
      child: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AppSkeleton(height: 280, borderRadius: 32),
            SizedBox(height: 24),
            AppSkeleton(width: 220, height: 28),
            SizedBox(height: 12),
            AppSkeleton(width: 140, height: 18),
            SizedBox(height: 24),
            AppSkeleton(height: 90, borderRadius: 20),
          ],
        ),
      ),
    );
  }
}
