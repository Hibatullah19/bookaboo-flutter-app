import '../../../core/supabase/supabase_config.dart';
import 'models/book_model.dart';

/// Reads the book catalogue from Supabase.
///
/// The `books` / `book_pages` / `categories` tables are world-readable, so
/// these queries work for signed-out visitors too (splash, onboarding).
class BooksService {
  /// Every column the [Book] model needs, plus its pages in reading order.
  static const _bookColumns = '''
id, title, author, cover_asset, cover_emoji, cover_color, category_id,
age_min, age_max, minutes, rating, description, featured,
book_pages (page_number, emoji, text)
''';

  Future<List<Book>> fetchBooks() async {
    final rows = await supabase
        .from('books')
        .select(_bookColumns)
        .order('sort_order', ascending: true)
        .order('page_number', referencedTable: 'book_pages', ascending: true);
    return rows.map(_bookFromRow).toList();
  }

  Future<List<BookCategory>> fetchCategories() async {
    final rows = await supabase
        .from('categories')
        .select('id, name, emoji, color, image_asset')
        .order('sort_order', ascending: true);
    return rows.map(_categoryFromRow).toList();
  }

  Future<Book> fetchBookById(String id) async {
    final row = await supabase
        .from('books')
        .select(_bookColumns)
        .eq('id', id)
        .order('page_number', referencedTable: 'book_pages', ascending: true)
        .maybeSingle();
    if (row == null) throw StateError('Book not found: $id');
    return _bookFromRow(row);
  }

  Future<List<Book>> fetchFeaturedBooks() async {
    final rows = await supabase
        .from('books')
        .select(_bookColumns)
        .eq('featured', true)
        .order('sort_order', ascending: true)
        .order('page_number', referencedTable: 'book_pages', ascending: true);
    return rows.map(_bookFromRow).toList();
  }

  /// The books a user has favourited, resolved to full [Book]s.
  Future<List<Book>> fetchBooksByIds(Iterable<String> ids) async {
    if (ids.isEmpty) return const [];
    final rows = await supabase
        .from('books')
        .select(_bookColumns)
        .inFilter('id', ids.toList())
        .order('page_number', referencedTable: 'book_pages', ascending: true);
    return rows.map(_bookFromRow).toList();
  }

  Book _bookFromRow(Map<String, dynamic> row) {
    final pages = (row['book_pages'] as List<dynamic>? ?? const [])
        .cast<Map<String, dynamic>>()
        .map((page) => BookPage(
              emoji: page['emoji'] as String,
              text: page['text'] as String,
            ))
        .toList();

    return Book(
      id: row['id'] as String,
      title: row['title'] as String,
      author: row['author'] as String,
      coverAsset: row['cover_asset'] as String,
      coverEmoji: row['cover_emoji'] as String,
      coverColor: _color(row['cover_color']),
      categoryId: row['category_id'] as String,
      ageMin: (row['age_min'] as num).toInt(),
      ageMax: (row['age_max'] as num).toInt(),
      minutes: (row['minutes'] as num).toInt(),
      rating: (row['rating'] as num).toDouble(),
      description: row['description'] as String,
      pages: pages,
      featured: row['featured'] as bool? ?? false,
    );
  }

  BookCategory _categoryFromRow(Map<String, dynamic> row) => BookCategory(
        id: row['id'] as String,
        name: row['name'] as String,
        imageAsset: row['image_asset'] as String,
        emoji: row['emoji'] as String,
        color: _color(row['color']),
      );

  /// Colors are stored as ARGB hex text (`0xFFFFB443`) so they survive a
  /// round trip through JSON without sign or precision surprises.
  static int _color(Object? value) {
    if (value is num) return value.toInt();
    final text = (value as String).trim();
    final digits = text.toLowerCase().startsWith('0x') ? text.substring(2) : text;
    return int.parse(digits, radix: 16);
  }
}
