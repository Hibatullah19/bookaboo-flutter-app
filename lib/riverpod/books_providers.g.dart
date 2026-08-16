// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'books_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(booksService)
const booksServiceProvider = BooksServiceProvider._();

final class BooksServiceProvider
    extends $FunctionalProvider<BooksService, BooksService, BooksService>
    with $Provider<BooksService> {
  const BooksServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'booksServiceProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$booksServiceHash();

  @$internal
  @override
  $ProviderElement<BooksService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  BooksService create(Ref ref) {
    return booksService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(BooksService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<BooksService>(value),
    );
  }
}

String _$booksServiceHash() => r'a8abe7845b7a32a687a13450f32940aef1e1e526';

@ProviderFor(books)
const booksProvider = BooksProvider._();

final class BooksProvider extends $FunctionalProvider<AsyncValue<List<Book>>,
        List<Book>, FutureOr<List<Book>>>
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  const BooksProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'booksProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$booksHash();

  @$internal
  @override
  $FutureProviderElement<List<Book>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Book>> create(Ref ref) {
    return books(ref);
  }
}

String _$booksHash() => r'b89e8404610b3422ebab2b19cf59a5db4bbc4308';

@ProviderFor(categories)
const categoriesProvider = CategoriesProvider._();

final class CategoriesProvider extends $FunctionalProvider<
        AsyncValue<List<BookCategory>>,
        List<BookCategory>,
        FutureOr<List<BookCategory>>>
    with
        $FutureModifier<List<BookCategory>>,
        $FutureProvider<List<BookCategory>> {
  const CategoriesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'categoriesProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$categoriesHash();

  @$internal
  @override
  $FutureProviderElement<List<BookCategory>> $createElement(
          $ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<BookCategory>> create(Ref ref) {
    return categories(ref);
  }
}

String _$categoriesHash() => r'a690c8f2611d14fd4e8b68a2a728e07431d8e9f6';

@ProviderFor(bookById)
const bookByIdProvider = BookByIdFamily._();

final class BookByIdProvider
    extends $FunctionalProvider<AsyncValue<Book>, Book, FutureOr<Book>>
    with $FutureModifier<Book>, $FutureProvider<Book> {
  const BookByIdProvider._(
      {required BookByIdFamily super.from, required String super.argument})
      : super(
          retry: null,
          name: r'bookByIdProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$bookByIdHash();

  @override
  String toString() {
    return r'bookByIdProvider'
        ''
        '($argument)';
  }

  @$internal
  @override
  $FutureProviderElement<Book> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<Book> create(Ref ref) {
    final argument = this.argument as String;
    return bookById(
      ref,
      argument,
    );
  }

  @override
  bool operator ==(Object other) {
    return other is BookByIdProvider && other.argument == argument;
  }

  @override
  int get hashCode {
    return argument.hashCode;
  }
}

String _$bookByIdHash() => r'1adc1f59df2eddf502cca1d5f59eb8db4839ff35';

final class BookByIdFamily extends $Family
    with $FunctionalFamilyOverride<FutureOr<Book>, String> {
  const BookByIdFamily._()
      : super(
          retry: null,
          name: r'bookByIdProvider',
          dependencies: null,
          $allTransitiveDependencies: null,
          isAutoDispose: true,
        );

  BookByIdProvider call(
    String id,
  ) =>
      BookByIdProvider._(argument: id, from: this);

  @override
  String toString() => r'bookByIdProvider';
}

/// Filtered server side so the home carousel does not wait on the full list.

@ProviderFor(featuredBooks)
const featuredBooksProvider = FeaturedBooksProvider._();

/// Filtered server side so the home carousel does not wait on the full list.

final class FeaturedBooksProvider extends $FunctionalProvider<
        AsyncValue<List<Book>>, List<Book>, FutureOr<List<Book>>>
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  /// Filtered server side so the home carousel does not wait on the full list.
  const FeaturedBooksProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'featuredBooksProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$featuredBooksHash();

  @$internal
  @override
  $FutureProviderElement<List<Book>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Book>> create(Ref ref) {
    return featuredBooks(ref);
  }
}

String _$featuredBooksHash() => r'bdc0e9cbe22e5c946b1954e10b349164ff00b38e';
