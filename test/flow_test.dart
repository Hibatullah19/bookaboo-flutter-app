import 'package:bookaboo/app/bookaboo_app.dart';
import 'package:bookaboo/features/auth/data/auth_service.dart';
import 'package:bookaboo/features/auth/riverpod/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'support/fakes.dart';

/// Walks the signed-in app end to end so a regression in any tab, the book
/// details page or the reader shows up as a failing test rather than a
/// blank screen on device.
void main() {
  setUp(() => GoogleFonts.config.allowRuntimeFetching = false);

  /// Advances past route transitions and the mock service delays without
  /// waiting for the skeleton loaders' endless pulse to stop.
  Future<void> settle(WidgetTester tester) async {
    for (var i = 0; i < 6; i++) {
      await tester.pump(const Duration(milliseconds: 400));
    }
  }

  Future<ProviderContainer> pumpSignedInApp(WidgetTester tester) async {
    final container = createTestContainer();
    addTearDown(container.dispose);

    await container.read(authControllerProvider.notifier).signIn(
          email: AuthService.demoCredentials.email,
          password: AuthService.demoCredentials.password,
        );

    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const BookaBooApp(),
      ),
    );
    // Skip the splash timer and land on home via the redirect guard.
    // Explicit pumps rather than pumpAndSettle: AppSkeleton runs a
    // repeating animation while the mock fetch is in flight, so settling
    // never completes.
    await tester.pump(const Duration(seconds: 3));
    await settle(tester);
    return container;
  }

  testWidgets('signed-in user lands on home with real content',
      (tester) async {
    tester.view.physicalSize = const Size(1179, 2556);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await pumpSignedInApp(tester);

    expect(find.text('Hi Sam'), findsOneWidget);
    expect(find.text('What shall we read today?'), findsOneWidget);
    expect(find.text('Featured today'), findsOneWidget);
    expect(find.text('Leo the Brave Little Lion'), findsWidgets);
  });

  testWidgets('every tab renders', (tester) async {
    tester.view.physicalSize = const Size(1179, 2556);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await pumpSignedInApp(tester);

    await tester.tap(find.text('Search'));
    await settle(tester);
    expect(find.text('Find a story'), findsOneWidget);

    await tester.tap(find.text('Library'));
    await settle(tester);
    expect(find.text('My library'), findsOneWidget);

    await tester.tap(find.text('Profile'));
    await settle(tester);
    expect(find.text('Sam'), findsOneWidget);
    expect(find.text('Sign out'), findsOneWidget);
    expect(find.text('Settings'), findsOneWidget);
  });

  testWidgets('book details opens and the reader turns pages',
      (tester) async {
    tester.view.physicalSize = const Size(1179, 2556);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await pumpSignedInApp(tester);

    await tester.tap(find.text('Leo the Brave Little Lion').first);
    await settle(tester);
    expect(find.text('About this story'), findsOneWidget);
    expect(find.text('Read now'), findsOneWidget);

    await tester.tap(find.text('Read now'));
    await settle(tester);
    expect(find.text('1/6'), findsOneWidget);

    await tester.tap(find.byIcon(Icons.arrow_forward_rounded));
    await settle(tester);
    expect(find.text('2/6'), findsOneWidget);
  });

  testWidgets('signing out returns to the email + password gate',
      (tester) async {
    tester.view.physicalSize = const Size(1179, 2556);
    tester.view.devicePixelRatio = 3;
    addTearDown(tester.view.reset);

    await pumpSignedInApp(tester);

    await tester.tap(find.text('Profile'));
    await settle(tester);
    // The button sits low enough to fall under the bottom bar on a small
    // phone, so scroll it clear before tapping.
    await tester.drag(find.byType(ListView), const Offset(0, -200));
    await settle(tester);
    await tester.tap(find.text('Sign out'));
    await settle(tester);

    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.textContaining('Google'), findsNothing);
  });
}
