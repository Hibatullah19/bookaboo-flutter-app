// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_controller.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(authService)
const authServiceProvider = AuthServiceProvider._();

final class AuthServiceProvider
    extends $FunctionalProvider<AuthService, AuthService, AuthService>
    with $Provider<AuthService> {
  const AuthServiceProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authServiceProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authServiceHash();

  @$internal
  @override
  $ProviderElement<AuthService> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  AuthService create(Ref ref) {
    return authService(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthService value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthService>(value),
    );
  }
}

String _$authServiceHash() => r'21d842d4dceafa3d239c0196a0f2b890d37c0b71';

/// Holds the current session. `null` state means signed out.
///
/// Seeded from the session Supabase restored from disk, then kept in sync with
/// the auth stream so token refreshes and sign-outs on other tabs land here too.

@ProviderFor(AuthController)
const authControllerProvider = AuthControllerProvider._();

/// Holds the current session. `null` state means signed out.
///
/// Seeded from the session Supabase restored from disk, then kept in sync with
/// the auth stream so token refreshes and sign-outs on other tabs land here too.
final class AuthControllerProvider
    extends $NotifierProvider<AuthController, AuthUser?> {
  /// Holds the current session. `null` state means signed out.
  ///
  /// Seeded from the session Supabase restored from disk, then kept in sync with
  /// the auth stream so token refreshes and sign-outs on other tabs land here too.
  const AuthControllerProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'authControllerProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$authControllerHash();

  @$internal
  @override
  AuthController create() => AuthController();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(AuthUser? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<AuthUser?>(value),
    );
  }
}

String _$authControllerHash() => r'7816ff6c98d63565161b0fa6824626bb1ab398a2';

/// Holds the current session. `null` state means signed out.
///
/// Seeded from the session Supabase restored from disk, then kept in sync with
/// the auth stream so token refreshes and sign-outs on other tabs land here too.

abstract class _$AuthController extends $Notifier<AuthUser?> {
  AuthUser? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<AuthUser?, AuthUser?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<AuthUser?, AuthUser?>, AuthUser?, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

/// Convenience for widgets that only care whether someone is signed in.

@ProviderFor(isSignedIn)
const isSignedInProvider = IsSignedInProvider._();

/// Convenience for widgets that only care whether someone is signed in.

final class IsSignedInProvider extends $FunctionalProvider<bool, bool, bool>
    with $Provider<bool> {
  /// Convenience for widgets that only care whether someone is signed in.
  const IsSignedInProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'isSignedInProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$isSignedInHash();

  @$internal
  @override
  $ProviderElement<bool> $createElement($ProviderPointer pointer) =>
      $ProviderElement(pointer);

  @override
  bool create(Ref ref) {
    return isSignedIn(ref);
  }

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(bool value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<bool>(value),
    );
  }
}

String _$isSignedInHash() => r'09a5889f347d1b738a7b04feba9e69e2b05bd6b2';
