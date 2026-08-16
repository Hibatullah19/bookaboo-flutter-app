import 'package:flutter/material.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/widgets/app_image.dart';

/// Static content for one onboarding page.
class OnboardingPageData {
  const OnboardingPageData({
    required this.asset,
    required this.title,
    required this.subtitle,
    required this.color,
  });

  final String asset;
  final String title;
  final String subtitle;
  final Color color;
}

/// A single onboarding page: full-bleed illustration over a tinted glow,
/// with the copy sitting below it.
class OnboardingPage extends StatelessWidget {
  const OnboardingPage({super.key, required this.data});

  final OnboardingPageData data;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSpacing.xl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Expanded(
            child: Center(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(AppRadius.xl),
                  boxShadow: AppShadows.medium,
                ),
                child: AppImage.cover(
                  data.asset,
                  width: 320,
                  height: 260,
                  radius: AppRadius.xl,
                ),
              ),
            ),
          ),
          const SizedBox(height: AppSpacing.xxl),
          Text(
            data.title,
            style: textTheme.displaySmall,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.sm),
          Text(
            data.subtitle,
            style: textTheme.bodyLarge?.copyWith(
              color: Theme.of(context).colorScheme.onSurface
                  .withValues(alpha: 0.68),
            ),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.lg),
        ],
      ),
    );
  }
}
