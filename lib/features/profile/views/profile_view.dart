import 'package:flutter/material.dart';

import 'widgets/profile_view_body.dart';

/// Profile tab — reader profile, stats and settings.
class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      body: SafeArea(child: ProfileViewBody()),
    );
  }
}
