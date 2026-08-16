import 'package:bookaboo/features/auth/data/auth_service.dart';
import 'package:bookaboo/features/auth/data/models/auth_user_model.dart';
import 'package:bookaboo/features/auth/riverpod/auth_controller.dart';
import 'package:bookaboo/features/books/data/books_service.dart';
import 'package:bookaboo/features/books/data/models/book_model.dart';
import 'package:bookaboo/features/profile/data/models/app_settings_model.dart';
import 'package:bookaboo/features/profile/data/profile_service.dart';
import 'package:bookaboo/riverpod/books_providers.dart';
import 'package:bookaboo/riverpod/profile_service_provider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'test_catalogue.dart';

/// A container wired to in-memory stand-ins for the Supabase-backed services,
/// so tests never touch the network. Behaviour mirrors the real tables: the
/// same seeded catalogue, the same error messages, the same field tagging.
ProviderContainer createTestContainer() => ProviderContainer(
      overrides: [
        authServiceProvider.overrideWithValue(FakeAuthService()),
        booksServiceProvider.overrideWithValue(FakeBooksService()),
        profileServiceProvider.overrideWithValue(FakeProfileService()),
      ],
    );

/// Favorites and settings held in memory, keyed by user id.
class FakeProfileService implements ProfileService {
  final _favorites = <String, Set<String>>{};
  final _settings = <String, AppSettings>{};

  @override
  Future<Set<String>> fetchFavorites(String userId) async =>
      _favorites[userId] ?? const {};

  @override
  Future<void> addFavorite(String userId, String bookId) async =>
      _favorites.putIfAbsent(userId, () => {}).add(bookId);

  @override
  Future<void> removeFavorite(String userId, String bookId) async =>
      _favorites.putIfAbsent(userId, () => {}).remove(bookId);

  @override
  Future<AppSettings?> fetchSettings(String userId) async => _settings[userId];

  @override
  Future<void> saveSettings(String userId, AppSettings settings) async =>
      _settings[userId] = settings;
}

class FakeAuthService implements AuthService {
  FakeAuthService() {
    _passwords[_demoEmail] = AuthService.demoCredentials.password;
    _users[_demoEmail] = const AuthUser(
      id: 'u_demo',
      email: _demoEmail,
      displayName: 'Sam',
      avatarIndex: 0,
    );
  }

  static const _demoEmail = 'hello@bookaboo.app';

  final _users = <String, AuthUser>{};
  final _passwords = <String, String>{};

  AuthUser? _current;

  @override
  AuthUser? get currentUser => _current;

  @override
  Stream<AuthUser?> authStateChanges() => const Stream.empty();

  @override
  Future<AuthUser?> fetchProfile() async => _current;

  @override
  Future<AuthUser> signIn({
    required String email,
    required String password,
  }) async {
    final key = _normalize(email);
    if (!_users.containsKey(key)) {
      throw const AuthException(
        'We could not find an account with that email.',
        field: 'email',
      );
    }
    if (_passwords[key] != password) {
      throw const AuthException(
        'That password does not match. Try again?',
        field: 'password',
      );
    }
    return _current = _users[key]!;
  }

  @override
  Future<AuthUser> signUp({
    required String name,
    required String email,
    required String password,
    required int avatarIndex,
  }) async {
    final key = _normalize(email);
    if (_users.containsKey(key)) {
      throw const AuthException(
        'That email already has an account. Sign in instead?',
        field: 'email',
      );
    }
    final user = AuthUser(
      id: 'u_${_users.length + 1}',
      email: key,
      displayName: name.trim(),
      avatarIndex: avatarIndex,
    );
    _users[key] = user;
    _passwords[key] = password;
    return _current = user;
  }

  @override
  Future<AuthUser> updateProfile({String? displayName, int? avatarIndex}) async {
    final user = _current!;
    return _current = _users[user.email] = user.copyWith(
      displayName: displayName?.trim() ?? user.displayName,
      avatarIndex: avatarIndex ?? user.avatarIndex,
    );
  }

  @override
  Future<void> signOut() async {
    _current = null;
  }

  String _normalize(String email) => email.trim().toLowerCase();
}

class FakeBooksService implements BooksService {
  /// Mirrors the round-trip the real queries take, so the widget tests still
  /// exercise the loading skeletons. (Auth, which runs before the first pump,
  /// stays instant — a pending timer there would stall the test clock.)
  static const _latency = Duration(milliseconds: 300);

  @override
  Future<List<Book>> fetchBooks() async {
    await Future<void>.delayed(_latency);
    return testBooks;
  }

  @override
  Future<List<BookCategory>> fetchCategories() async {
    await Future<void>.delayed(_latency);
    return testCategories;
  }

  @override
  Future<Book> fetchBookById(String id) async {
    await Future<void>.delayed(_latency);
    return testBooks.firstWhere(
      (book) => book.id == id,
      orElse: () => throw StateError('Book not found: $id'),
    );
  }

  @override
  Future<List<Book>> fetchFeaturedBooks() async {
    await Future<void>.delayed(_latency);
    return testBooks.where((book) => book.featured).toList();
  }

  @override
  Future<List<Book>> fetchBooksByIds(Iterable<String> ids) async {
    final wanted = ids.toSet();
    return testBooks.where((book) => wanted.contains(book.id)).toList();
  }
}
