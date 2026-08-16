import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../features/auth/riverpod/auth_controller.dart';
import '../features/profile/data/models/app_settings_model.dart';
import 'profile_service_provider.dart';

part 'settings_provider.g.dart';

/// App-wide user settings, persisted on the user's `profiles` row.
///
/// Like `Favorites` this stays synchronous for the views: defaults show first,
/// the stored values arrive a moment later, and every change writes through.
@Riverpod(keepAlive: true)
class Settings extends _$Settings {
  @override
  AppSettings build() {
    final user = ref.watch(authControllerProvider);
    if (user != null) _load(user.id);
    return const AppSettings();
  }

  Future<void> _load(String userId) async {
    final stored = await ref.read(profileServiceProvider).fetchSettings(userId);
    if (stored != null) state = stored;
  }

  void toggleSoundEffects() =>
      _update(state.copyWith(soundEffects: !state.soundEffects));

  void toggleNightLight() =>
      _update(state.copyWith(nightLight: !state.nightLight));

  void setReadingLevel(ReadingLevel level) =>
      _update(state.copyWith(readingLevel: level));

  /// Applies [next] locally, then persists it; reverts if the write fails.
  void _update(AppSettings next) {
    final previous = state;
    state = next;

    final userId = ref.read(authControllerProvider)?.id;
    if (userId == null) return;

    ref
        .read(profileServiceProvider)
        .saveSettings(userId, next)
        .catchError((Object _) => state = previous);
  }
}
