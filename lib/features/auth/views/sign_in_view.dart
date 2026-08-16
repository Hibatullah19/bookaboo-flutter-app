import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/routes.dart';
import '../../../config/theme/theme.dart';
import '../../../core/widgets/app_button.dart';
import '../data/auth_service.dart';
import '../data/auth_validators.dart';
import '../riverpod/auth_controller.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/auth_text_field.dart';

/// Email + password sign in. There is no social sign-in by design.
class SignInView extends ConsumerStatefulWidget {
  const SignInView({super.key});

  @override
  ConsumerState<SignInView> createState() => _SignInViewState();
}

class _SignInViewState extends ConsumerState<SignInView> {
  final _formKey = GlobalKey<FormState>();
  final _email = TextEditingController();
  final _password = TextEditingController();

  bool _submitting = false;
  String? _emailError;
  String? _passwordError;

  @override
  void initState() {
    super.initState();
    // A server-side error only applies to the value that produced it.
    _email.addListener(() {
      if (_emailError != null) setState(() => _emailError = null);
    });
    _password.addListener(() {
      if (_passwordError != null) setState(() => _passwordError = null);
    });
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() {
      _emailError = null;
      _passwordError = null;
    });
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);
    try {
      await ref.read(authControllerProvider.notifier).signIn(
            email: _email.text,
            password: _password.text,
          );
      // The router redirect takes over from here.
    } on AuthException catch (error) {
      if (!mounted) return;
      setState(() {
        if (error.field == 'email') _emailError = error.message;
        if (error.field == 'password') _passwordError = error.message;
      });
      _formKey.currentState!.validate();
      if (error.field == null) {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  void _useDemoAccount() {
    _email.text = AuthService.demoCredentials.email;
    _password.text = AuthService.demoCredentials.password;
    _submit();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthScaffold(
      title: 'Welcome back',
      subtitle: 'Sign in to pick up your stories where you left off.',
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            AuthTextField(
              controller: _email,
              label: 'Email',
              hint: 'you@example.com',
              icon: Icons.mail_outline_rounded,
              keyboardType: TextInputType.emailAddress,
              autofillHints: const [AutofillHints.email],
              enabled: !_submitting,
              validator: (value) => _emailError ?? AuthValidators.email(value),
            ),
            const SizedBox(height: AppSpacing.md),
            AuthTextField(
              controller: _password,
              label: 'Password',
              hint: 'Your password',
              icon: Icons.lock_outline_rounded,
              obscure: true,
              textInputAction: TextInputAction.done,
              autofillHints: const [AutofillHints.password],
              enabled: !_submitting,
              onSubmitted: _submit,
              validator: (value) =>
                  _passwordError ?? AuthValidators.requiredPassword(value),
            ),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: _submitting
                    ? null
                    : () => ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              'Password resets are coming soon.',
                            ),
                          ),
                        ),
                child: const Text('Forgot password?'),
              ),
            ),
            const SizedBox(height: AppSpacing.xs),
            AppButton(
              label: 'Sign in',
              icon: Icons.arrow_forward_rounded,
              loading: _submitting,
              onPressed: _submit,
            ),
            const SizedBox(height: AppSpacing.sm),
            AppButton(
              label: 'Try the demo account',
              variant: AppButtonVariant.secondary,
              onPressed: _submitting ? null : _useDemoAccount,
            ),
            const SizedBox(height: AppSpacing.lg),
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text('New to BookaBoo?', style: theme.textTheme.bodyMedium),
                  TextButton(
                    onPressed: _submitting
                        ? null
                        : () => context.push(AppRoute.signUp),
                    child: const Text('Create an account'),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
