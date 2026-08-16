/// Form validators shared by the sign-in and sign-up screens.
abstract class AuthValidators {
  static final _emailPattern = RegExp(r'^[\w.+-]+@[\w-]+\.[\w.-]+$');

  static const minPasswordLength = 8;

  static String? email(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) return 'Please enter your email.';
    if (!_emailPattern.hasMatch(input)) return 'That does not look like an email.';
    return null;
  }

  static String? password(String? value) {
    final input = value ?? '';
    if (input.isEmpty) return 'Please enter a password.';
    if (input.length < minPasswordLength) {
      return 'Use at least $minPasswordLength characters.';
    }
    return null;
  }

  /// Sign-in only: any non-empty password is accepted so an old short
  /// password still surfaces as a server-side error, not a format error.
  static String? requiredPassword(String? value) {
    if ((value ?? '').isEmpty) return 'Please enter your password.';
    return null;
  }

  static String? name(String? value) {
    final input = value?.trim() ?? '';
    if (input.isEmpty) return 'Please enter a name.';
    if (input.length < 2) return 'That name is a bit too short.';
    return null;
  }

  static String? confirmPassword(String? value, String original) {
    if ((value ?? '').isEmpty) return 'Please confirm your password.';
    if (value != original) return 'Those passwords do not match.';
    return null;
  }
}
