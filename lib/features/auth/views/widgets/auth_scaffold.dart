import 'package:flutter/material.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/app_image.dart';

/// Shared chrome for the sign-in and sign-up screens: an illustrated
/// gradient hero with a rounded sheet riding over it.
///
/// Laid out as a Column so the sheet always gets bounded height — a
/// `Positioned.fill` inside a Stack lets the form paint outside the
/// stack's bounds and the screen comes up blank.
class AuthScaffold extends StatelessWidget {
  const AuthScaffold({
    super.key,
    required this.title,
    required this.subtitle,
    required this.child,
    this.onBack,
  });

  final String title;
  final String subtitle;
  final Widget child;
  final VoidCallback? onBack;

  /// How far the sheet overlaps the hero.
  static const _overlap = AppRadius.xl;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final media = MediaQuery.of(context);
    final heroHeight = (media.size.height * 0.32).clamp(200.0, 300.0);

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Stack(
        fit: StackFit.expand,
        children: [
          Column(
            children: [
              SizedBox(
                height: heroHeight,
                width: double.infinity,
                child: Stack(
                  fit: StackFit.expand,
                  children: [
                    const DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          colors: AppColors.duskGradient,
                          begin: Alignment.topLeft,
                          end: Alignment.bottomRight,
                        ),
                      ),
                    ),
                    const AppPatternOverlay(
                      asset: AppAssets.patternStars,
                      opacity: 0.35,
                    ),
                    Padding(
                      padding: EdgeInsets.only(
                        top: media.padding.top,
                        bottom: _overlap,
                      ),
                      child: const AppImage.illustration(AppAssets.authHero),
                    ),
                  ],
                ),
              ),
              Expanded(
                child: Transform.translate(
                  offset: const Offset(0, -_overlap),
                  child: Container(
                    decoration: BoxDecoration(
                      color: theme.scaffoldBackgroundColor,
                      borderRadius: const BorderRadius.vertical(
                        top: Radius.circular(AppRadius.xl),
                      ),
                      boxShadow: AppShadows.lifted,
                    ),
                    child: SafeArea(
                      top: false,
                      child: SingleChildScrollView(
                        padding: EdgeInsets.only(
                          left: AppSpacing.xl,
                          right: AppSpacing.xl,
                          top: AppSpacing.lg,
                          bottom: AppSpacing.xl + media.viewInsets.bottom,
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: Container(
                                height: 5,
                                width: 44,
                                margin: const EdgeInsets.only(
                                  bottom: AppSpacing.lg,
                                ),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.outlineVariant,
                                  borderRadius:
                                      BorderRadius.circular(AppRadius.pill),
                                ),
                              ),
                            ),
                            Text(title, style: theme.textTheme.displaySmall),
                            const SizedBox(height: AppSpacing.xs),
                            Text(subtitle, style: theme.textTheme.bodyMedium),
                            const SizedBox(height: AppSpacing.xl),
                            child,
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          if (onBack != null)
            Positioned(
              top: media.padding.top + AppSpacing.xxs,
              left: AppSpacing.xs,
              child: IconButton(
                onPressed: onBack,
                icon: const Icon(Icons.arrow_back_rounded),
                color: Colors.white,
                tooltip: 'Back',
              ),
            ),
        ],
      ),
    );
  }
}
