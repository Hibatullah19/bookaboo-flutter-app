import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/routes.dart';
import '../../../config/theme/theme.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/app_image.dart';
import '../../auth/riverpod/auth_controller.dart';

/// Animated launch screen. Hands off to onboarding, sign-in or home
/// depending on whether there is already a session.
class SplashView extends ConsumerStatefulWidget {
  const SplashView({super.key});

  @override
  ConsumerState<SplashView> createState() => _SplashViewState();
}

class _SplashViewState extends ConsumerState<SplashView>
    with SingleTickerProviderStateMixin {
  late final AnimationController _controller = AnimationController(
    vsync: this,
    duration: const Duration(milliseconds: 1100),
  );
  late final Animation<double> _pop = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0, 0.7, curve: Curves.easeOutBack),
  );
  late final Animation<double> _fade = CurvedAnimation(
    parent: _controller,
    curve: const Interval(0.35, 1, curve: Curves.easeOut),
  );
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _controller.forward();
    _timer = Timer(const Duration(milliseconds: 2100), () {
      if (!mounted) return;
      final signedIn = ref.read(authControllerProvider) != null;
      context.go(signedIn ? AppRoute.home : AppRoute.onboarding);
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    return Scaffold(
      body: DecoratedBox(
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            colors: AppColors.duskGradient,
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Stack(
          fit: StackFit.expand,
          children: [
            const AppPatternOverlay(
              asset: AppAssets.patternStars,
              opacity: 0.4,
            ),
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ScaleTransition(
                    scale: _pop,
                    child: const AppImage.illustration(
                      AppAssets.splashMark,
                      width: 200,
                      height: 200,
                    ),
                  ),
                  const SizedBox(height: AppSpacing.lg),
                  FadeTransition(
                    opacity: _fade,
                    child: Column(
                      children: [
                        Text(
                          'BookaBoo',
                          style: textTheme.displayLarge
                              ?.copyWith(color: Colors.white),
                        ),
                        const SizedBox(height: AppSpacing.xxs),
                        Text(
                          'Stories that make you smile',
                          style: textTheme.bodyLarge?.copyWith(
                            color: Colors.white.withValues(alpha: 0.82),
                          ),
                        ),
                      ],
                    ),
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
