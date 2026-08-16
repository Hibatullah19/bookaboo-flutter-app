import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../config/theme/theme.dart';

/// Bottom-navigation shell wrapping the four main tabs.
class AppShell extends StatelessWidget {
  const AppShell({super.key, required this.navigationShell});

  final StatefulNavigationShell navigationShell;

  static const _destinations = [
    (icon: Icons.home_outlined, active: Icons.home_rounded, label: 'Home'),
    (
      icon: Icons.search_rounded,
      active: Icons.saved_search_rounded,
      label: 'Search',
    ),
    (
      icon: Icons.favorite_border_rounded,
      active: Icons.favorite_rounded,
      label: 'Library',
    ),
    (
      icon: Icons.person_outline_rounded,
      active: Icons.person_rounded,
      label: 'Profile',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: navigationShell,
      bottomNavigationBar: DecoratedBox(
        decoration: BoxDecoration(boxShadow: AppShadows.soft),
        child: NavigationBar(
          selectedIndex: navigationShell.currentIndex,
          onDestinationSelected: (index) => navigationShell.goBranch(
            index,
            initialLocation: index == navigationShell.currentIndex,
          ),
          destinations: [
            for (final destination in _destinations)
              NavigationDestination(
                icon: Icon(destination.icon),
                selectedIcon: Icon(destination.active),
                label: destination.label,
              ),
          ],
        ),
      ),
    );
  }
}
