import 'package:freezed_annotation/freezed_annotation.dart';

part 'book_model.freezed.dart';
part 'book_model.g.dart';

/// A children's book with its story pages.
@freezed
abstract class Book with _$Book {
  const factory Book({
    required String id,
    required String title,
    required String author,

    /// Bundled cover artwork. [coverEmoji]/[coverColor] remain as the
    /// fallback glyph and the accent color pulled from the artwork.
    required String coverAsset,
    required String coverEmoji,
    required int coverColor,
    required String categoryId,
    required int ageMin,
    required int ageMax,
    required int minutes,
    required double rating,
    required String description,
    @Default(<BookPage>[]) List<BookPage> pages,
    @Default(false) bool featured,
  }) = _Book;

  factory Book.fromJson(Map<String, dynamic> json) => _$BookFromJson(json);
}

/// A single illustrated page of a story.
@freezed
abstract class BookPage with _$BookPage {
  const factory BookPage({
    required String emoji,
    required String text,
  }) = _BookPage;

  factory BookPage.fromJson(Map<String, dynamic> json) =>
      _$BookPageFromJson(json);
}

/// A browsable book category.
@freezed
abstract class BookCategory with _$BookCategory {
  const factory BookCategory({
    required String id,
    required String name,
    required String imageAsset,
    required String emoji,
    required int color,
  }) = _BookCategory;

  factory BookCategory.fromJson(Map<String, dynamic> json) =>
      _$BookCategoryFromJson(json);
}
