import 'package:flutter/material.dart';

import '../../config/theme/theme.dart';

enum AppButtonVariant {
  /// Filled brand button with a soft colored glow.
  primary,

  /// Outlined button for the lower-priority action next to a primary.
  secondary,

  /// Borderless button for tertiary actions inside dense layouts.
  ghost,
}

/// The app's standard action button. Handles its own loading state so forms
/// don't have to swap widgets mid-submit.
class AppButton extends StatelessWidget {
  const AppButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.variant = AppButtonVariant.primary,
    this.expanded = true,
    this.loading = false,
  });

  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final AppButtonVariant variant;
  final bool expanded;
  final bool loading;

  @override
  Widget build(BuildContext context) {
    final scheme = Theme.of(context).colorScheme;
    final enabled = onPressed != null && !loading;

    final content = loading
        ? SizedBox(
            height: 22,
            width: 22,
            child: CircularProgressIndicator(
              strokeWidth: 2.4,
              color: variant == AppButtonVariant.primary
                  ? scheme.onPrimary
                  : scheme.primary,
            ),
          )
        : Row(
            mainAxisSize: MainAxisSize.min,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (icon != null) ...[
                Icon(icon, size: 20),
                const SizedBox(width: AppSpacing.xs),
              ],
              Flexible(
                child: Text(label, overflow: TextOverflow.ellipsis),
              ),
            ],
          );

    Widget button;
    switch (variant) {
      case AppButtonVariant.primary:
        button = DecoratedBox(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(AppRadius.md),
            boxShadow: enabled ? AppShadows.glow(scheme.primary) : null,
          ),
          child: FilledButton(
            onPressed: enabled ? onPressed : null,
            child: content,
          ),
        );
      case AppButtonVariant.secondary:
        button = OutlinedButton(
          onPressed: enabled ? onPressed : null,
          child: content,
        );
      case AppButtonVariant.ghost:
        button = TextButton(
          onPressed: enabled ? onPressed : null,
          style: TextButton.styleFrom(
            minimumSize: const Size(0, 48),
            padding: const EdgeInsets.symmetric(horizontal: AppSpacing.md),
            textStyle: Theme.of(context).textTheme.labelLarge,
          ),
          child: content,
        );
    }

    if (!expanded) return button;
    return SizedBox(width: double.infinity, child: button);
  }
}
