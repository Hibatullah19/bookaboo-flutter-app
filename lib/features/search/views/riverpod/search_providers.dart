import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../../../riverpod/books_providers.dart';
import '../../../books/data/models/book_model.dart';

part 'search_providers.g.dart';

/// Current text typed in the search bar.
@riverpod
class SearchQuery extends _$SearchQuery {
  @override
  String build() => '';

  void setQuery(String value) => state = value;
}

/// Currently selected category filter (null = all).
///
/// Kept alive because the home tab sets it before the search tab is built.
@Riverpod(keepAlive: true)
class SelectedCategory extends _$SelectedCategory {
  @override
  String? build() => null;

  void select(String? categoryId) => state = categoryId;
}

/// Books matching the current query + category filter.
@riverpod
Future<List<Book>> searchResults(Ref ref) async {
  final books = await ref.watch(booksProvider.future);
  final query = ref.watch(searchQueryProvider).trim().toLowerCase();
  final categoryId = ref.watch(selectedCategoryProvider);

  return books.where((book) {
    final matchesQuery = query.isEmpty ||
        book.title.toLowerCase().contains(query) ||
        book.author.toLowerCase().contains(query);
    final matchesCategory =
        categoryId == null || book.categoryId == categoryId;
    return matchesQuery && matchesCategory;
  }).toList();
}
