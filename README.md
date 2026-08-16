# BookaBoo 📚

A playful, colorful storybook app for kids, built with Flutter, Riverpod, freezed and GoRouter using a feature-first architecture.

## Screens

Splash (animated logo) → Onboarding (3 pages) → bottom-nav shell with Home (featured carousel, categories, book grid), Search (query + category filters), Library (favorites), Profile (stats + settings), plus Book Details and a swipeable story Reader. All book content is mock data served by `BooksService`.

## Getting started

```bash
flutter create .            # adds android/ios/etc. platform folders
flutter pub get
dart run build_runner build --delete-conflicting-outputs
flutter run
```

Note on generated files: the `*.freezed.dart` / `*.g.dart` files in the repo are hand-written bridge stubs so the project compiles immediately after `pub get`. Running `build_runner` (step 3) replaces them with the real generated output — the annotated sources are the single source of truth.

## Architecture

```
lib/
├── app/                  # Root widget (MaterialApp.router)
├── config/
│   ├── theme/            # AppTheme + AppColors (import via theme.dart)
│   └── routes/           # AppRoute names + GoRouter (import via routes.dart)
├── core/widgets/         # AppCard, AppButton, AppSearchBar, AppErrorView,
│                         # AppSkeleton, GradientAppBar, SettingsCard, AppShell
├── riverpod/             # App-wide providers (books, favorites, settings)
└── features/
    ├── splash/           # views/
    ├── onboarding/       # views/ + widgets/
    ├── home/             # views/ + widgets/ (featured carousel, categories)
    ├── search/           # views/ + widgets/ + views/riverpod/ (local state)
    ├── library/          # views/ + widgets/ (favorites)
    ├── profile/          # views/ + widgets/ + data/models/ (settings)
    ├── book_details/     # views/ + widgets/
    ├── reader/           # views/ + widgets/ (story pages)
    └── books/            # shared data: BooksService + freezed models + BookCard
```

- State: Riverpod with `riverpod_generator` (`@riverpod` / notifier classes).
- Models: `freezed` + `json_serializable`.
- Navigation: GoRouter with `StatefulShellRoute.indexedStack` for the 4 tabs; details/reader push on the root navigator.
- Swap `BooksService` internals for Supabase/Firebase later — the UI only talks to providers.

## App icon & splash

When you're ready, wire real launch assets with `flutter_launcher_icons` and `flutter_native_splash`.
