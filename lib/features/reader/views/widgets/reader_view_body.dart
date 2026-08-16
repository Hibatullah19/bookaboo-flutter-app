import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../../config/routes/routes.dart';
import '../../../../config/theme/theme.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../books/data/models/book_model.dart';
import 'story_page.dart';

/// Swipeable pages of the story plus progress bar and controls.
class ReaderViewBody extends StatefulWidget {
  const ReaderViewBody({super.key, required this.book});

  final Book book;

  @override
  State<ReaderViewBody> createState() => _ReaderViewBodyState();
}

class _ReaderViewBodyState extends State<ReaderViewBody> {
  final _pageController = PageController();
  int _pageIndex = 0;

  int get _totalPages => widget.book.pages.length + 1; // +1 for The End page

  void _goTo(int index) {
    _pageController.animateToPage(
      index,
      duration: const Duration(milliseconds: 350),
      curve: Curves.easeOutCubic,
    );
  }

  void _close() =>
      context.canPop() ? context.pop() : context.go(AppRoute.home);

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final book = widget.book;
    final accent = Color(book.coverColor);
    final progress = (_pageIndex + 1) / _totalPages;

    return SafeArea(
      child: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.xs,
              AppSpacing.xs,
              AppSpacing.gutter,
              AppSpacing.xs,
            ),
            child: Row(
              children: [
                IconButton(
                  onPressed: _close,
                  icon: const Icon(Icons.close_rounded),
                  tooltip: 'Close',
                ),
                Expanded(
                  child: TweenAnimationBuilder<double>(
                    tween: Tween(begin: 0, end: progress),
                    duration: const Duration(milliseconds: 300),
                    builder: (context, value, _) => ClipRRect(
                      borderRadius: BorderRadius.circular(AppRadius.pill),
                      child: LinearProgressIndicator(
                        value: value,
                        minHeight: 8,
                        backgroundColor:
                            theme.colorScheme.surfaceContainerHighest,
                        valueColor: AlwaysStoppedAnimation<Color>(accent),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: AppSpacing.sm),
                Text(
                  '${_pageIndex + 1}/$_totalPages',
                  style: theme.textTheme.labelMedium,
                ),
              ],
            ),
          ),
          Expanded(
            child: PageView.builder(
              controller: _pageController,
              itemCount: _totalPages,
              onPageChanged: (index) => setState(() => _pageIndex = index),
              itemBuilder: (context, index) {
                if (index < book.pages.length) {
                  return StoryPage(page: book.pages[index], book: book);
                }
                return _TheEndPage(
                  onReadAgain: () => _goTo(0),
                  onDone: _close,
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(
              AppSpacing.gutter,
              0,
              AppSpacing.gutter,
              AppSpacing.md,
            ),
            child: Row(
              children: [
                _NavButton(
                  icon: Icons.arrow_back_rounded,
                  color: accent,
                  onTap: _pageIndex > 0 ? () => _goTo(_pageIndex - 1) : null,
                ),
                const Spacer(),
                // Flexible so a long label on a narrow phone shrinks the hint
                // rather than pushing the forward arrow off the screen.
                Flexible(
                  child: Text(
                    'Swipe to turn the page',
                    style: theme.textTheme.bodySmall,
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                const Spacer(),
                _NavButton(
                  icon: Icons.arrow_forward_rounded,
                  color: accent,
                  onTap: _pageIndex < _totalPages - 1
                      ? () => _goTo(_pageIndex + 1)
                      : null,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class _NavButton extends StatelessWidget {
  const _NavButton({
    required this.icon,
    required this.color,
    this.onTap,
  });

  final IconData icon;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    final enabled = onTap != null;
    return DecoratedBox(
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        boxShadow: enabled ? AppShadows.glow(color) : null,
      ),
      child: Material(
        color: enabled ? color : color.withValues(alpha: 0.22),
        shape: const CircleBorder(),
        child: InkWell(
          onTap: onTap,
          customBorder: const CircleBorder(),
          child: Padding(
            padding: const EdgeInsets.all(AppSpacing.md),
            child: Icon(icon, color: Colors.white, size: 24),
          ),
        ),
      ),
    );
  }
}

class _TheEndPage extends StatelessWidget {
  const _TheEndPage({required this.onReadAgain, required this.onDone});

  final VoidCallback onReadAgain;
  final VoidCallback onDone;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.all(AppSpacing.xxl),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            height: 120,
            width: 120,
            decoration: BoxDecoration(
              gradient: const LinearGradient(
                colors: AppColors.brandGradient,
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              shape: BoxShape.circle,
              boxShadow: AppShadows.glow(theme.colorScheme.primary),
            ),
            child: const Icon(
              Icons.celebration_rounded,
              size: 52,
              color: Colors.white,
            ),
          ),
          const SizedBox(height: AppSpacing.xl),
          Text('The End', style: theme.textTheme.displayMedium),
          const SizedBox(height: AppSpacing.xs),
          Text(
            'Great reading! You finished the whole story.',
            style: theme.textTheme.bodyLarge,
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: AppSpacing.xxl),
          AppButton(
            label: 'Read it again',
            icon: Icons.replay_rounded,
            onPressed: onReadAgain,
          ),
          const SizedBox(height: AppSpacing.sm),
          AppButton(
            label: 'All done',
            variant: AppButtonVariant.secondary,
            onPressed: onDone,
          ),
        ],
      ),
    );
  }
}
