import 'package:bookaboo/app/bookaboo_app.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:google_fonts/google_fonts.dart';

import 'support/fakes.dart';

void main() {
  testWidgets('app boots to splash, then onboarding, then sign in',
      (tester) async {
    GoogleFonts.config.allowRuntimeFetching = false;

    final container = createTestContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const BookaBooApp(),
      ),
    );
    expect(find.text('BookaBoo'), findsOneWidget);

    // Flush the splash timer + navigation to onboarding.
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('A world of stories'), findsOneWidget);

    // Skipping onboarding lands on the email + password gate.
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();
    expect(find.text('Welcome back'), findsOneWidget);
    expect(find.text('Sign in'), findsOneWidget);
  });

  testWidgets('sign in screen offers no social login', (tester) async {
    GoogleFonts.config.allowRuntimeFetching = false;

    final container = createTestContainer();
    addTearDown(container.dispose);
    await tester.pumpWidget(
      UncontrolledProviderScope(
        container: container,
        child: const BookaBooApp(),
      ),
    );
    await tester.pump(const Duration(seconds: 3));
    await tester.pump(const Duration(seconds: 1));
    await tester.tap(find.text('Skip'));
    await tester.pumpAndSettle();

    expect(find.textContaining('Google'), findsNothing);
    expect(find.textContaining('Apple'), findsNothing);
    expect(find.textContaining('continue with', findRichText: true),
        findsNothing);
  });
}
