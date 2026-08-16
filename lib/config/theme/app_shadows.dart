import 'package:flutter/material.dart';

import 'app_colors.dart';

/// Two-layer shadows tinted with the brand color rather than pure black —
/// a tight ambient contact shadow plus a wide diffuse one. This is what makes
/// cards feel lifted instead of pasted on.
abstract class AppShadows {
  static List<BoxShadow> get soft => [
        BoxShadow(
          color: AppColors.primaryDeep.withValues(alpha: 0.05),
          blurRadius: 4,
          offset: const Offset(0, 2),
        ),
        BoxShadow(
          color: AppColors.primaryDeep.withValues(alpha: 0.06),
          blurRadius: 18,
          offset: const Offset(0, 10),
        ),
      ];

  static List<BoxShadow> get medium => [
        BoxShadow(
          color: AppColors.primaryDeep.withValues(alpha: 0.07),
          blurRadius: 6,
          offset: const Offset(0, 3),
        ),
        BoxShadow(
          color: AppColors.primaryDeep.withValues(alpha: 0.10),
          blurRadius: 28,
          offset: const Offset(0, 16),
        ),
      ];

  static List<BoxShadow> get lifted => [
        BoxShadow(
          color: AppColors.primaryDeep.withValues(alpha: 0.10),
          blurRadius: 10,
          offset: const Offset(0, 6),
        ),
        BoxShadow(
          color: AppColors.primaryDeep.withValues(alpha: 0.16),
          blurRadius: 44,
          offset: const Offset(0, 24),
        ),
      ];

  /// Colored glow used under primary buttons.
  static List<BoxShadow> glow(Color color) => [
        BoxShadow(
          color: color.withValues(alpha: 0.32),
          blurRadius: 20,
          offset: const Offset(0, 10),
        ),
      ];
}
