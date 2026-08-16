import 'package:supabase_flutter/supabase_flutter.dart' as sb;

import '../../../core/supabase/supabase_config.dart';
import 'models/auth_user_model.dart';

/// Something the user needs to see and fix, e.g. wrong password.
class AuthException implements Exception {
  const AuthException(this.message, {this.field});

  final String message;

  /// Which form field the message belongs to, when it maps to one.
  /// One of `email`, `password`, `name`.
  final String? field;

  @override
  String toString() => message;
}

/// Email + password auth backed by Supabase.
///
/// The profile row (display name, avatar, settings) is created server side by
/// the `on_auth_user_created` trigger, so sign-up is a single round trip.
class AuthService {
  static const demoCredentials = (
    email: 'hello@bookaboo.app',
    password: 'bookaboo',
  );

  sb.GoTrueClient get _auth => supabase.auth;

  /// Emits the signed-in user, or `null` after sign-out / token expiry.
  Stream<AuthUser?> authStateChanges() => _auth.onAuthStateChange
      .map((event) => _fromSession(event.session?.user));

  /// The session restored from disk at start-up, if any.
  AuthUser? get currentUser => _fromSession(_auth.currentUser);

  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    try {
      final response = await _auth.signInWithPassword(
        email: _normalize(email),
        password: password,
      );
      final user = _fromSession(response.user);
      if (user == null) {
        throw const AuthException('We could not sign you in. Try again?');
      }
      return user;
    } on sb.AuthException catch (error) {
      throw _translate(error);
    }
  }

  Future<AuthUser> signUp({
    required String name,
    required String email,
    required String password,
    required int avatarIndex,
  }) async {
    try {
      final response = await _auth.signUp(
        email: _normalize(email),
        password: password,
        data: {
          'display_name': name.trim(),
          'avatar_index': avatarIndex,
        },
      );
      final user = _fromSession(response.user);
      if (user == null) {
        throw const AuthException(
          'Check your inbox to confirm your email, then sign in.',
          field: 'email',
        );
      }
      return user;
    } on sb.AuthException catch (error) {
      throw _translate(error);
    }
  }

  Future<void> signOut() async {
    try {
      await _auth.signOut();
    } on sb.AuthException catch (error) {
      throw _translate(error);
    }
  }

  /// Persists profile edits (display name / avatar) for the current user.
  Future<AuthUser> updateProfile({
    String? displayName,
    int? avatarIndex,
  }) async {
    final id = _auth.currentUser?.id;
    if (id == null) {
      throw const AuthException('You need to be signed in to do that.');
    }
    final changes = <String, dynamic>{
      if (displayName != null) 'display_name': displayName.trim(),
      if (avatarIndex != null) 'avatar_index': avatarIndex,
    };
    if (changes.isNotEmpty) {
      await supabase.from('profiles').update(changes).eq('id', id);
      await _auth.updateUser(sb.UserAttributes(data: changes));
    }
    return currentUser!;
  }

  /// Reads the profile row, which is the source of truth for the display
  /// name and avatar once a grown-up has edited them.
  Future<AuthUser?> fetchProfile() async {
    final id = _auth.currentUser?.id;
    if (id == null) return null;
    final row = await supabase
        .from('profiles')
        .select('id, email, display_name, avatar_index')
        .eq('id', id)
        .maybeSingle();
    if (row == null) return currentUser;
    return AuthUser(
      id: row['id'] as String,
      email: row['email'] as String? ?? '',
      displayName: row['display_name'] as String? ?? 'Little Reader',
      avatarIndex: (row['avatar_index'] as num?)?.toInt() ?? 0,
    );
  }

  /// Maps the Supabase user (plus its sign-up metadata) onto our model.
  AuthUser? _fromSession(sb.User? user) {
    if (user == null) return null;
    final metadata = user.userMetadata ?? const <String, dynamic>{};
    return AuthUser(
      id: user.id,
      email: user.email ?? '',
      displayName: (metadata['display_name'] as String?)?.trim().isNotEmpty ==
              true
          ? (metadata['display_name'] as String).trim()
          : 'Little Reader',
      avatarIndex: (metadata['avatar_index'] as num?)?.toInt() ?? 0,
    );
  }

  /// Turns Supabase's technical messages into something a grown-up can act on,
  /// tagged with the form field it belongs to.
  AuthException _translate(sb.AuthException error) {
    final message = error.message.toLowerCase();
    if (message.contains('invalid login credentials')) {
      return const AuthException(
        'That email and password do not match. Try again?',
        field: 'password',
      );
    }
    if (message.contains('already registered') ||
        message.contains('already been registered') ||
        message.contains('user already exists')) {
      return const AuthException(
        'That email already has an account. Sign in instead?',
        field: 'email',
      );
    }
    if (message.contains('email not confirmed')) {
      return const AuthException(
        'Please confirm your email first — check your inbox.',
        field: 'email',
      );
    }
    if (message.contains('password')) {
      return AuthException(error.message, field: 'password');
    }
    if (message.contains('email')) {
      return AuthException(error.message, field: 'email');
    }
    return AuthException(error.message);
  }

  String _normalize(String email) => email.trim().toLowerCase();
}
