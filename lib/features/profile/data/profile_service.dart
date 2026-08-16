import '../../../core/supabase/supabase_config.dart';
import 'models/app_settings_model.dart';

/// Reads and writes the per-user rows: the `favorites` table and the settings
/// columns on `profiles`. Row Level Security scopes every query to the caller,
/// so the user id here is only used for filtering and insert payloads.
class ProfileService {
  Future<Set<String>> fetchFavorites(String userId) async {
    final rows =
        await supabase.from('favorites').select('book_id').eq('user_id', userId);
    return rows.map((row) => row['book_id'] as String).toSet();
  }

  Future<void> addFavorite(String userId, String bookId) => supabase
      .from('favorites')
      .upsert({'user_id': userId, 'book_id': bookId});

  Future<void> removeFavorite(String userId, String bookId) => supabase
      .from('favorites')
      .delete()
      .eq('user_id', userId)
      .eq('book_id', bookId);

  Future<AppSettings?> fetchSettings(String userId) async {
    final row = await supabase
        .from('profiles')
        .select('sound_effects, night_light, reading_level')
        .eq('id', userId)
        .maybeSingle();
    if (row == null) return null;
    return AppSettings(
      soundEffects: row['sound_effects'] as bool? ?? true,
      nightLight: row['night_light'] as bool? ?? false,
      readingLevel: readingLevelFrom(row['reading_level'] as String?),
    );
  }

  Future<void> saveSettings(String userId, AppSettings settings) =>
      supabase.from('profiles').update({
        'sound_effects': settings.soundEffects,
        'night_light': settings.nightLight,
        'reading_level': settings.readingLevel.name,
      }).eq('id', userId);

  static ReadingLevel readingLevelFrom(String? name) =>
      ReadingLevel.values.firstWhere(
        (level) => level.name == name,
        orElse: () => ReadingLevel.earlyReader,
      );
}
