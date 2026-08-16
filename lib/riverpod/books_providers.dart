import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/books/data/books_service.dart';
import '../features/books/data/models/book_model.dart';

part 'books_providers.g.dart';

@riverpod
BooksService booksService(Ref ref) => BooksService();

@riverpod
Future<List<Book>> books(Ref ref) =>
    ref.watch(booksServiceProvider).fetchBooks();

@riverpod
Future<List<BookCategory>> categories(Ref ref) =>
    ref.watch(booksServiceProvider).fetchCategories();

@riverpod
Future<Book> bookById(Ref ref, String id) =>
    ref.watch(booksServiceProvider).fetchBookById(id);

/// Filtered server side so the home carousel does not wait on the full list.
@riverpod
Future<List<Book>> featuredBooks(Ref ref) =>
    ref.watch(booksServiceProvider).fetchFeaturedBooks();
