import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import '../../core/widgets/app_shell.dart';
import '../../features/auth/riverpod/auth_controller.dart';
import '../../features/auth/views/sign_in_view.dart';
import '../../features/auth/views/sign_up_view.dart';
import '../../features/book_details/views/book_details_view.dart';
import '../../features/home/views/home_view.dart';
import '../../features/library/views/library_view.dart';
import '../../features/onboarding/views/onboarding_view.dart';
import '../../features/profile/views/profile_view.dart';
import '../../features/reader/views/reader_view.dart';
import '../../features/search/views/search_view.dart';
import '../../features/splash/views/splash_view.dart';

part 'app_route.g.dart';

/// Central route names for BookaBoo.
abstract class AppRoute {
  static const splash = '/';
  static const onboarding = '/onboarding';
  static const signIn = '/sign-in';
  static const signUp = '/sign-up';
  static const home = '/home';
  static const search = '/search';
  static const library = '/library';
  static const profile = '/profile';

  static String bookDetails(String id) => '/book/$id';
  static String reader(String id) => '/book/$id/read';

  /// Routes reachable without a session.
  static const _public = {splash, onboarding, signIn, signUp};
}

final _rootNavigatorKey = GlobalKey<NavigatorState>();

/// The app's router. Lives in a provider so the redirect guard can read the
/// current session and rebuild when it changes.
@Riverpod(keepAlive: true)
GoRouter router(Ref ref) {
  return GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: AppRoute.splash,
    refreshListenable: _AuthListenable(ref),
    redirect: (context, state) {
      final signedIn = ref.read(authControllerProvider) != null;
      final location = state.matchedLocation;
      final isPublic = AppRoute._public.contains(location);

      // Splash and onboarding drive their own navigation.
      if (location == AppRoute.splash || location == AppRoute.onboarding) {
        return null;
      }
      if (!signedIn && !isPublic) return AppRoute.signIn;
      if (signedIn && isPublic) return AppRoute.home;
      return null;
    },
    routes: [
      GoRoute(
        path: AppRoute.splash,
        builder: (context, state) => const SplashView(),
      ),
      GoRoute(
        path: AppRoute.onboarding,
        builder: (context, state) => const OnboardingView(),
      ),
      GoRoute(
        path: AppRoute.signIn,
        builder: (context, state) => const SignInView(),
      ),
      GoRoute(
        path: AppRoute.signUp,
        parentNavigatorKey: _rootNavigatorKey,
        builder: (context, state) => const SignUpView(),
      ),
      StatefulShellRoute.indexedStack(
        builder: (context, state, navigationShell) =>
            AppShell(navigationShell: navigationShell),
        branches: [
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.home,
                builder: (context, state) => const HomeView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.search,
                builder: (context, state) => const SearchView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.library,
                builder: (context, state) => const LibraryView(),
              ),
            ],
          ),
          StatefulShellBranch(
            routes: [
              GoRoute(
                path: AppRoute.profile,
                builder: (context, state) => const ProfileView(),
              ),
            ],
          ),
        ],
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/book/:id',
        builder: (context, state) =>
            BookDetailsView(bookId: state.pathParameters['id']!),
      ),
      GoRoute(
        parentNavigatorKey: _rootNavigatorKey,
        path: '/book/:id/read',
        builder: (context, state) =>
            ReaderView(bookId: state.pathParameters['id']!),
      ),
    ],
  );
}

/// Bridges the auth provider to the [Listenable] go_router expects.
class _AuthListenable extends ChangeNotifier {
  _AuthListenable(Ref ref) {
    _subscription = ref.listen(
      authControllerProvider,
      (_, __) => notifyListeners(),
    );
  }

  late final ProviderSubscription<Object?> _subscription;

  @override
  void dispose() {
    _subscription.close();
    super.dispose();
  }
}
