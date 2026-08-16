import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/riverpod/auth_controller.dart';
import 'profile_service_provider.dart';

part 'favorites_provider.g.dart';

/// Ids of books the child has added to their library, stored in the
/// `favorites` table and scoped to the signed-in account by RLS.
///
/// The state stays a plain [Set] so views can read it synchronously: the rows
/// are fetched in the background, and a toggle updates the UI immediately then
/// writes through to Supabase (rolling back if the write fails).
@Riverpod(keepAlive: true)
class Favorites extends _$Favorites {
  @override
  Set<String> build() {
    // Rebuilds — and so reloads — whenever the signed-in user changes.
    final user = ref.watch(authControllerProvider);
    if (user != null) _load(user.id);
    return const {};
  }

  Future<void> _load(String userId) async {
    state = await ref.read(profileServiceProvider).fetchFavorites(userId);
  }

  /// Adds or removes [bookId]. Silently no-ops when signed out.
  Future<void> toggle(String bookId) async {
    final userId = ref.read(authControllerProvider)?.id;
    if (userId == null) return;

    final previous = state;
    final adding = !previous.contains(bookId);
    state = adding
        ? {...previous, bookId}
        : previous.where((id) => id != bookId).toSet();

    final service = ref.read(profileServiceProvider);
    try {
      await (adding
          ? service.addFavorite(userId, bookId)
          : service.removeFavorite(userId, bookId));
    } catch (_) {
      state = previous; // Keep the UI honest if the write did not land.
      rethrow;
    }
  }
}
