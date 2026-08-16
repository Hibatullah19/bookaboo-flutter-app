import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../data/auth_service.dart';
import '../data/models/auth_user_model.dart';

part 'auth_controller.g.dart';

@Riverpod(keepAlive: true)
AuthService authService(Ref ref) => AuthService();

/// Holds the current session. `null` state means signed out.
///
/// Seeded from the session Supabase restored from disk, then kept in sync with
/// the auth stream so token refreshes and sign-outs on other tabs land here too.
@Riverpod(keepAlive: true)
class AuthController extends _$AuthController {
  @override
  AuthUser? build() {
    final subscription = _service.authStateChanges().listen((user) {
      state = user;
    });
    ref.onDispose(subscription.cancel);

    // The profile row wins over the sign-up metadata once it is edited.
    if (_service.currentUser != null) {
      _service.fetchProfile().then((profile) {
        if (profile != null && state != null) state = profile;
      }).ignore();
    }

    return _service.currentUser;
  }

  AuthService get _service => ref.read(authServiceProvider);

  /// Throws [AuthException] so the calling form can show the message
  /// against the right field.
  Future<void> signIn({required String email, required String password}) async {
    await _service.signIn(email: email, password: password);
    state = await _service.fetchProfile() ?? _service.currentUser;
  }

  Future<void> signUp({
    required String name,
    required String email,
    required String password,
    required int avatarIndex,
  }) async {
    state = await _service.signUp(
      name: name,
      email: email,
      password: password,
      avatarIndex: avatarIndex,
    );
  }

  Future<void> updateProfile({String? displayName, int? avatarIndex}) async {
    state = await _service.updateProfile(
      displayName: displayName,
      avatarIndex: avatarIndex,
    );
  }

  Future<void> signOut() async {
    await _service.signOut();
    state = null;
  }
}

/// Convenience for widgets that only care whether someone is signed in.
@riverpod
bool isSignedIn(Ref ref) => ref.watch(authControllerProvider) != null;
