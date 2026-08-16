import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/theme/theme.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/app_button.dart';
import '../../../core/widgets/app_image.dart';
import '../data/auth_service.dart';
import '../data/auth_validators.dart';
import '../riverpod/auth_controller.dart';
import 'widgets/auth_scaffold.dart';
import 'widgets/auth_text_field.dart';

/// Email + password account creation. No social sign-in by design.
class SignUpView extends ConsumerStatefulWidget {
  const SignUpView({super.key});

  @override
  ConsumerState<SignUpView> createState() => _SignUpViewState();
}

class _SignUpViewState extends ConsumerState<SignUpView> {
  final _formKey = GlobalKey<FormState>();
  final _name = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _confirm = TextEditingController();

  int _avatarIndex = 0;
  bool _submitting = false;
  String? _emailError;

  @override
  void initState() {
    super.initState();
    _email.addListener(() {
      if (_emailError != null) setState(() => _emailError = null);
    });
  }

  @override
  void dispose() {
    _name.dispose();
    _email.dispose();
    _password.dispose();
    _confirm.dispose();
    super.dispose();
  }

  Future<void> _submit() async {
    FocusScope.of(context).unfocus();
    setState(() => _emailError = null);
    if (!_formKey.currentState!.validate()) return;

    setState(() => _submitting = true);
    try {
      await ref.read(authControllerProvider.notifier).signUp(
            name: _name.text,
            email: _email.text,
            password: _password.text,
            avatarIndex: _avatarIndex,
          );
      // The router redirect takes over from here.
    } on AuthException catch (error) {
      if (!mounted) return;
      if (error.field == 'email') {
        setState(() => _emailError = error.message);
        _formKey.currentState!.validate();
      } else {
        ScaffoldMessenger.of(context)
            .showSnackBar(SnackBar(content: Text(error.message)));
      }
    } finally {
      if (mounted) setState(() => _submitting = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return AuthScaffold(
      title: 'Create your account',
      subtitle: 'One account keeps every bedtime story in one place.',
      onBack: context.canPop() ? context.pop : null,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Pick a reading buddy', style: theme.textTheme.titleSmall),
            const SizedBox(height: AppSpacing.sm),
            _AvatarPicker(
              selected: _avatarIndex,
              onSelected: _submitting
                  ? null
                  : (index) => setState(() => _avatarIndex = index),
            ),
            const SizedBox(height: AppSpacing.lg),
            AuthTextField(
              controller: _name,
              label: "Child's name",
              hint: 'Sam',
              icon: Icons.face_retouching_natural_rounded,
              keyboardType: TextInputType.name,
              autofillHints: const [AutofillHints.name],
              enabled: !_submitting,
              validator: AuthValidators.name,
            ),
            const SizedBox(height: AppSpacing.md),
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
              hint: 'At least ${AuthValidators.minPasswordLength} characters',
              icon: Icons.lock_outline_rounded,
              obscure: true,
              autofillHints: const [AutofillHints.newPassword],
              enabled: !_submitting,
              validator: AuthValidators.password,
            ),
            const SizedBox(height: AppSpacing.md),
            AuthTextField(
              controller: _confirm,
              label: 'Confirm password',
              hint: 'Type it once more',
              icon: Icons.lock_reset_rounded,
              obscure: true,
              textInputAction: TextInputAction.done,
              enabled: !_submitting,
              onSubmitted: _submit,
              validator: (value) =>
                  AuthValidators.confirmPassword(value, _password.text),
            ),
            const SizedBox(height: AppSpacing.lg),
            AppButton(
              label: 'Create account',
              icon: Icons.arrow_forward_rounded,
              loading: _submitting,
              onPressed: _submit,
            ),
            const SizedBox(height: AppSpacing.md),
            Center(
              child: Wrap(
                crossAxisAlignment: WrapCrossAlignment.center,
                children: [
                  Text(
                    'Already have an account?',
                    style: theme.textTheme.bodyMedium,
                  ),
                  TextButton(
                    onPressed: _submitting
                        ? null
                        : () => context.canPop() ? context.pop() : null,
                    child: const Text('Sign in'),
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

class _AvatarPicker extends StatelessWidget {
  const _AvatarPicker({required this.selected, required this.onSelected});

  final int selected;
  final ValueChanged<int>? onSelected;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    return Row(
      children: List.generate(AppAssets.avatars.length, (index) {
        final isSelected = index == selected;
        return Padding(
          padding: const EdgeInsets.only(right: AppSpacing.sm),
          child: GestureDetector(
            onTap: onSelected == null ? null : () => onSelected!(index),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              curve: Curves.easeOut,
              padding: const EdgeInsets.all(3),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected ? scheme.primary : Colors.transparent,
                  width: 2.5,
                ),
                boxShadow: isSelected ? AppShadows.soft : null,
              ),
              child: AppImage.cover(
                AppAssets.avatar(index),
                width: 58,
                height: 58,
                radius: AppRadius.pill,
              ),
            ),
          ),
        );
      }),
    );
  }
}
