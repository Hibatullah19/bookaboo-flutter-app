import 'package:flutter/material.dart';

import '../../config/theme/theme.dart';

/// Shared surface card. Elevated by a soft two-layer shadow rather than a
/// border, which is what makes the redesigned screens feel layered.
class AppCard extends StatelessWidget {
  const AppCard({
    super.key,
    required this.child,
    this.color,
    this.padding = const EdgeInsets.all(AppSpacing.md),
    this.borderRadius = AppRadius.lg,
    this.onTap,
    this.elevated = true,
    this.bordered = false,
  });

  final Widget child;
  final Color? color;
  final EdgeInsetsGeometry padding;
  final double borderRadius;
  final VoidCallback? onTap;
  final bool elevated;
  final bool bordered;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final radius = BorderRadius.circular(borderRadius);
    final shape = RoundedRectangleBorder(
      borderRadius: radius,
      side: bordered
          ? BorderSide(color: theme.colorScheme.outlineVariant)
          : BorderSide.none,
    );

    final card = Material(
      color: color ?? theme.cardTheme.color,
      shape: shape,
      clipBehavior: Clip.antiAlias,
      child: InkWell(
        onTap: onTap,
        child: Padding(padding: padding, child: child),
      ),
    );

    if (!elevated) return card;
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: radius,
        boxShadow: AppShadows.soft,
      ),
      child: card,
    );
  }
}
