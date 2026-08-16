import 'package:bookaboo/features/auth/data/auth_service.dart';
import 'package:bookaboo/features/auth/data/auth_validators.dart';
import 'package:bookaboo/features/auth/riverpod/auth_controller.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';

import 'support/fakes.dart';

void main() {
  group('AuthValidators', () {
    test('rejects malformed emails and accepts good ones', () {
      expect(AuthValidators.email(''), isNotNull);
      expect(AuthValidators.email('nope'), isNotNull);
      expect(AuthValidators.email('a@b'), isNotNull);
      expect(AuthValidators.email('sam@example.com'), isNull);
    });

    test('requires a long enough password on sign up', () {
      expect(AuthValidators.password('short'), isNotNull);
      expect(AuthValidators.password('longenough'), isNull);
    });

    test('confirm password must match', () {
      expect(AuthValidators.confirmPassword('abc', 'abd'), isNotNull);
      expect(AuthValidators.confirmPassword('abc', 'abc'), isNull);
    });
  });

  group('AuthController', () {
    late ProviderContainer container;

    setUp(() => container = createTestContainer());
    tearDown(() => container.dispose());

    test('starts signed out', () {
      expect(container.read(authControllerProvider), isNull);
    });

    test('signs in with the demo credentials', () async {
      await container.read(authControllerProvider.notifier).signIn(
            email: AuthService.demoCredentials.email,
            password: AuthService.demoCredentials.password,
          );
      expect(container.read(authControllerProvider)?.displayName, 'Sam');
      expect(container.read(isSignedInProvider), isTrue);
    });

    test('rejects a wrong password against the password field', () async {
      await expectLater(
        container.read(authControllerProvider.notifier).signIn(
              email: AuthService.demoCredentials.email,
              password: 'wrong-password',
            ),
        throwsA(isA<AuthException>()
            .having((e) => e.field, 'field', 'password')),
      );
      expect(container.read(authControllerProvider), isNull);
    });

    test('rejects an unknown email against the email field', () async {
      await expectLater(
        container
            .read(authControllerProvider.notifier)
            .signIn(email: 'nobody@example.com', password: 'whatever'),
        throwsA(
          isA<AuthException>().having((e) => e.field, 'field', 'email'),
        ),
      );
    });

    test('signs up, then refuses a duplicate email', () async {
      final notifier = container.read(authControllerProvider.notifier);
      await notifier.signUp(
        name: 'Ada',
        email: 'Ada@Example.com',
        password: 'supersecret',
        avatarIndex: 2,
      );
      final user = container.read(authControllerProvider);
      expect(user?.displayName, 'Ada');
      expect(user?.email, 'ada@example.com', reason: 'email is normalized');
      expect(user?.avatarIndex, 2);

      await expectLater(
        notifier.signUp(
          name: 'Ada again',
          email: 'ada@example.com',
          password: 'supersecret',
          avatarIndex: 0,
        ),
        throwsA(isA<AuthException>().having((e) => e.field, 'field', 'email')),
      );
    });

    test('sign out clears the session', () async {
      final notifier = container.read(authControllerProvider.notifier);
      await notifier.signIn(
        email: AuthService.demoCredentials.email,
        password: AuthService.demoCredentials.password,
      );
      await notifier.signOut();
      expect(container.read(authControllerProvider), isNull);
    });
  });
}
