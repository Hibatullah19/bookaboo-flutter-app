import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../config/theme/theme.dart';
import '../../../../core/constants/app_assets.dart';
import '../../../../core/widgets/app_button.dart';
import '../../../../core/widgets/app_image.dart';
import '../../../../core/widgets/settings_card.dart';
import '../../../../riverpod/favorites_provider.dart';
import '../../../../riverpod/settings_provider.dart';
import '../../../auth/riverpod/auth_controller.dart';
import '../../data/models/app_settings_model.dart';
import 'stat_bubble.dart';

/// Body of the profile tab.
class ProfileViewBody extends ConsumerStatefulWidget {
  const ProfileViewBody({super.key});

  @override
  ConsumerState<ProfileViewBody> createState() => _ProfileViewBodyState();
}

class _ProfileViewBodyState extends ConsumerState<ProfileViewBody> {
  bool _signingOut = false;

  Future<void> _signOut() async {
    setState(() => _signingOut = true);
    await ref.read(authControllerProvider.notifier).signOut();
    // The router redirect sends us back to sign-in.
    if (mounted) setState(() => _signingOut = false);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final settings = ref.watch(settingsProvider);
    final favoritesCount = ref.watch(favoritesProvider).length;
    final user = ref.watch(authControllerProvider);

    return ListView(
      padding: const EdgeInsets.fromLTRB(
        AppSpacing.gutter,
        AppSpacing.gutter,
        AppSpacing.gutter,
        AppSpacing.xxxl,
      ),
      children: [
        Center(
          child: Column(
            children: [
              DecoratedBox(
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  boxShadow: AppShadows.medium,
                ),
                child: AppImage.cover(
                  AppAssets.avatar(user?.avatarIndex ?? 0),
                  width: 104,
                  height: 104,
                  radius: AppRadius.pill,
                ),
              ),
              const SizedBox(height: AppSpacing.sm),
              Text(
                user?.displayName ?? 'Little Reader',
                style: theme.textTheme.headlineMedium,
              ),
              Text(
                user?.email ?? 'Not signed in',
                style: theme.textTheme.bodyMedium,
              ),
            ],
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        Row(
          children: [
            const Expanded(
              child: StatBubble(
                icon: Icons.menu_book_rounded,
                value: '12',
                label: 'Books read',
                color: AppColors.teal,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            Expanded(
              child: StatBubble(
                icon: Icons.favorite_rounded,
                value: '$favoritesCount',
                label: 'Favorites',
                color: AppColors.coral,
              ),
            ),
            const SizedBox(width: AppSpacing.sm),
            const Expanded(
              child: StatBubble(
                icon: Icons.local_fire_department_rounded,
                value: '5',
                label: 'Day streak',
                color: AppColors.amber,
              ),
            ),
          ],
        ),
        const SizedBox(height: AppSpacing.xxl),
        Text('Settings', style: theme.textTheme.titleLarge),
        const SizedBox(height: AppSpacing.sm),
        SettingsCard(
          icon: Icons.volume_up_rounded,
          iconColor: AppColors.sky,
          title: 'Sound effects',
          subtitle: 'Fun sounds while reading',
          trailing: Switch(
            value: settings.soundEffects,
            onChanged: (_) =>
                ref.read(settingsProvider.notifier).toggleSoundEffects(),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SettingsCard(
          icon: Icons.nightlight_round,
          iconColor: AppColors.primary,
          title: 'Night light',
          subtitle: 'Softer colors for bedtime',
          trailing: Switch(
            value: settings.nightLight,
            onChanged: (_) =>
                ref.read(settingsProvider.notifier).toggleNightLight(),
          ),
        ),
        const SizedBox(height: AppSpacing.sm),
        SettingsCard(
          icon: Icons.school_rounded,
          iconColor: AppColors.teal,
          title: 'Reading level',
          subtitle: settings.readingLevel.label,
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: _pickReadingLevel,
        ),
        const SizedBox(height: AppSpacing.sm),
        SettingsCard(
          icon: Icons.groups_rounded,
          iconColor: AppColors.rose,
          title: "Grown-ups' corner",
          subtitle: 'Reading tips and progress reports',
          trailing: const Icon(Icons.chevron_right_rounded),
          onTap: () => ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Coming soon.')),
          ),
        ),
        const SizedBox(height: AppSpacing.xl),
        AppButton(
          label: 'Sign out',
          icon: Icons.logout_rounded,
          variant: AppButtonVariant.secondary,
          loading: _signingOut,
          onPressed: _signOut,
        ),
        const SizedBox(height: AppSpacing.lg),
        Center(
          child: Text(
            'BookaBoo v1.0.0',
            style: theme.textTheme.bodySmall,
          ),
        ),
      ],
    );
  }

  void _pickReadingLevel() {
    showModalBottomSheet<void>(
      context: context,
      builder: (sheetContext) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(AppSpacing.gutter),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                'Pick a reading level',
                style: Theme.of(sheetContext).textTheme.titleLarge,
              ),
              const SizedBox(height: AppSpacing.sm),
              for (final level in ReadingLevel.values)
                ListTile(
                  leading: Text(
                    level.emoji,
                    style: const TextStyle(fontSize: 26),
                  ),
                  title: Text(
                    level.label,
                    style: Theme.of(sheetContext).textTheme.titleSmall,
                  ),
                  trailing: ref.read(settingsProvider).readingLevel == level
                      ? const Icon(Icons.check_rounded)
                      : null,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppRadius.md),
                  ),
                  onTap: () {
                    ref.read(settingsProvider.notifier).setReadingLevel(level);
                    Navigator.of(sheetContext).pop();
                  },
                ),
            ],
          ),
        ),
      ),
    );
  }
}
