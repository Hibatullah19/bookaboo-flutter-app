import 'package:flutter/material.dart';

import '../constants/app_assets.dart';
import 'app_empty_view.dart';

/// Friendly full-size error state.
class AppErrorView extends StatelessWidget {
  const AppErrorView({
    super.key,
    this.message = 'We could not load that just now.',
    this.onRetry,
  });

  final String message;
  final VoidCallback? onRetry;

  @override
  Widget build(BuildContext context) {
    return AppEmptyView(
      asset: AppAssets.error,
      title: 'Oops!',
      message: message,
      actionLabel: 'Try again',
      onAction: onRetry,
    );
  }
}
