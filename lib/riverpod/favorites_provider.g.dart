// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Ids of books the child has added to their library, stored in the
/// `favorites` table and scoped to the signed-in account by RLS.
///
/// The state stays a plain [Set] so views can read it synchronously: the rows
/// are fetched in the background, and a toggle updates the UI immediately then
/// writes through to Supabase (rolling back if the write fails).

@ProviderFor(Favorites)
const favoritesProvider = FavoritesProvider._();

/// Ids of books the child has added to their library, stored in the
/// `favorites` table and scoped to the signed-in account by RLS.
///
/// The state stays a plain [Set] so views can read it synchronously: the rows
/// are fetched in the background, and a toggle updates the UI immediately then
/// writes through to Supabase (rolling back if the write fails).
final class FavoritesProvider
    extends $NotifierProvider<Favorites, Set<String>> {
  /// Ids of books the child has added to their library, stored in the
  /// `favorites` table and scoped to the signed-in account by RLS.
  ///
  /// The state stays a plain [Set] so views can read it synchronously: the rows
  /// are fetched in the background, and a toggle updates the UI immediately then
  /// writes through to Supabase (rolling back if the write fails).
  const FavoritesProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'favoritesProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$favoritesHash();

  @$internal
  @override
  Favorites create() => Favorites();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(Set<String> value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<Set<String>>(value),
    );
  }
}

String _$favoritesHash() => r'a6888f1529fa5d6ae77427af1d5e8e149af77349';

/// Ids of books the child has added to their library, stored in the
/// `favorites` table and scoped to the signed-in account by RLS.
///
/// The state stays a plain [Set] so views can read it synchronously: the rows
/// are fetched in the background, and a toggle updates the UI immediately then
/// writes through to Supabase (rolling back if the write fails).

abstract class _$Favorites extends $Notifier<Set<String>> {
  Set<String> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<Set<String>, Set<String>>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<Set<String>, Set<String>>, Set<String>, Object?, Object?>;
    element.handleValue(ref, created);
  }
}
