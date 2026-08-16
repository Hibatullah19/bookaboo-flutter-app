import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../core/widgets/app_error_view.dart';
import '../../../core/widgets/app_skeleton.dart';
import '../../../riverpod/books_providers.dart';
import 'widgets/reader_view_body.dart';

/// Full-screen story reader.
class ReaderView extends ConsumerWidget {
  const ReaderView({super.key, required this.bookId});

  final String bookId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final book = ref.watch(bookByIdProvider(bookId));
    return Scaffold(
      body: book.when(
        loading: () => const SafeArea(
          child: Padding(
            padding: EdgeInsets.all(24),
            child: Column(
              children: [
                AppSkeleton(height: 8, borderRadius: 8),
                SizedBox(height: 40),
                Expanded(child: AppSkeleton(borderRadius: 32, height: 400)),
              ],
            ),
          ),
        ),
        error: (error, _) => SafeArea(
          child: AppErrorView(
            message: 'This story wandered off...',
            onRetry: () => ref.invalidate(bookByIdProvider(bookId)),
          ),
        ),
        data: (book) => ReaderViewBody(book: book),
      ),
    );
  }
}
