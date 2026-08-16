// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'search_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning
/// Current text typed in the search bar.

@ProviderFor(SearchQuery)
const searchQueryProvider = SearchQueryProvider._();

/// Current text typed in the search bar.
final class SearchQueryProvider extends $NotifierProvider<SearchQuery, String> {
  /// Current text typed in the search bar.
  const SearchQueryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchQueryProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchQueryHash();

  @$internal
  @override
  SearchQuery create() => SearchQuery();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String>(value),
    );
  }
}

String _$searchQueryHash() => r'1b2400a29b7903cdb3a47d355dd9257f12274bff';

/// Current text typed in the search bar.

abstract class _$SearchQuery extends $Notifier<String> {
  String build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String, String>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String, String>, String, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

/// Currently selected category filter (null = all).
///
/// Kept alive because the home tab sets it before the search tab is built.

@ProviderFor(SelectedCategory)
const selectedCategoryProvider = SelectedCategoryProvider._();

/// Currently selected category filter (null = all).
///
/// Kept alive because the home tab sets it before the search tab is built.
final class SelectedCategoryProvider
    extends $NotifierProvider<SelectedCategory, String?> {
  /// Currently selected category filter (null = all).
  ///
  /// Kept alive because the home tab sets it before the search tab is built.
  const SelectedCategoryProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'selectedCategoryProvider',
          isAutoDispose: false,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$selectedCategoryHash();

  @$internal
  @override
  SelectedCategory create() => SelectedCategory();

  /// {@macro riverpod.override_with_value}
  Override overrideWithValue(String? value) {
    return $ProviderOverride(
      origin: this,
      providerOverride: $SyncValueProvider<String?>(value),
    );
  }
}

String _$selectedCategoryHash() => r'363648dcd912ffa67a2c650632ae131a06475a59';

/// Currently selected category filter (null = all).
///
/// Kept alive because the home tab sets it before the search tab is built.

abstract class _$SelectedCategory extends $Notifier<String?> {
  String? build();
  @$mustCallSuper
  @override
  void runBuild() {
    final created = build();
    final ref = this.ref as $Ref<String?, String?>;
    final element = ref.element as $ClassProviderElement<
        AnyNotifier<String?, String?>, String?, Object?, Object?>;
    element.handleValue(ref, created);
  }
}

/// Books matching the current query + category filter.

@ProviderFor(searchResults)
const searchResultsProvider = SearchResultsProvider._();

/// Books matching the current query + category filter.

final class SearchResultsProvider extends $FunctionalProvider<
        AsyncValue<List<Book>>, List<Book>, FutureOr<List<Book>>>
    with $FutureModifier<List<Book>>, $FutureProvider<List<Book>> {
  /// Books matching the current query + category filter.
  const SearchResultsProvider._()
      : super(
          from: null,
          argument: null,
          retry: null,
          name: r'searchResultsProvider',
          isAutoDispose: true,
          dependencies: null,
          $allTransitiveDependencies: null,
        );

  @override
  String debugGetCreateSourceHash() => _$searchResultsHash();

  @$internal
  @override
  $FutureProviderElement<List<Book>> $createElement($ProviderPointer pointer) =>
      $FutureProviderElement(pointer);

  @override
  FutureOr<List<Book>> create(Ref ref) {
    return searchResults(ref);
  }
}

String _$searchResultsHash() => r'b8bb3ee04ea97032af825c60296dd3e9562ac162';
