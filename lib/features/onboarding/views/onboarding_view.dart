import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../config/routes/routes.dart';
import '../../../config/theme/theme.dart';
import '../../../core/constants/app_assets.dart';
import '../../../core/widgets/app_button.dart';
import 'widgets/onboarding_page.dart';

/// Three-step intro shown after the splash screen, ending at sign-in.
class OnboardingView extends StatefulWidget {
  const OnboardingView({super.key});

  @override
  State<OnboardingView> createState() => _OnboardingViewState();
}

class _OnboardingViewState extends State<OnboardingView> {
  final _pageController = PageController();
  int _pageIndex = 0;

  static const _pages = [
    OnboardingPageData(
      asset: AppAssets.onboarding1,
      title: 'A world of stories',
      subtitle: 'Hundreds of picture books about lions, rockets, mermaids '
          'and more.',
      color: AppColors.amber,
    ),
    OnboardingPageData(
      asset: AppAssets.onboarding2,
      title: 'Made for little hands',
      subtitle: 'Big buttons, bright pages and stories that are just the '
          'right length.',
      color: AppColors.primary,
    ),
    OnboardingPageData(
      asset: AppAssets.onboarding3,
      title: 'Build your library',
      subtitle: 'Save favorite stories and read them again and again '
          '(and again).',
      color: AppColors.teal,
    ),
  ];

  bool get _isLast => _pageIndex == _pages.length - 1;

  void _next() {
    if (_isLast) {
      context.go(AppRoute.signIn);
      return;
    }
    _pageController.nextPage(
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Align(
              alignment: Alignment.centerRight,
              child: Padding(
                padding: const EdgeInsets.only(right: AppSpacing.xs),
                child: TextButton(
                  onPressed: () => context.go(AppRoute.signIn),
                  child: const Text('Skip'),
                ),
              ),
            ),
            Expanded(
              child: PageView.builder(
                controller: _pageController,
                itemCount: _pages.length,
                onPageChanged: (index) => setState(() => _pageIndex = index),
                itemBuilder: (context, index) =>
                    OnboardingPage(data: _pages[index]),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                for (var i = 0; i < _pages.length; i++)
                  AnimatedContainer(
                    duration: const Duration(milliseconds: 250),
                    curve: Curves.easeOut,
                    margin: const EdgeInsets.symmetric(
                      horizontal: AppSpacing.xxs,
                    ),
                    width: i == _pageIndex ? 26 : 8,
                    height: 8,
                    decoration: BoxDecoration(
                      color: i == _pageIndex
                          ? _pages[_pageIndex].color
                          : Theme.of(context).colorScheme.outlineVariant,
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                    ),
                  ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.all(AppSpacing.xl),
              child: AppButton(
                label: _isLast ? "Let's read" : 'Next',
                icon: _isLast ? Icons.auto_stories_rounded : null,
                onPressed: _next,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
