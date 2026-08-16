import 'package:flutter/material.dart';

import '../../config/theme/theme.dart';

/// Pill search field with a clear affordance.
class AppSearchBar extends StatefulWidget {
  const AppSearchBar({
    super.key,
    this.hint = 'Search stories, authors…',
    this.onChanged,
    this.autofocus = false,
  });

  final String hint;
  final ValueChanged<String>? onChanged;
  final bool autofocus;

  @override
  State<AppSearchBar> createState() => _AppSearchBarState();
}

class _AppSearchBarState extends State<AppSearchBar> {
  final _controller = TextEditingController();

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _handleChanged(String value) {
    setState(() {});
    widget.onChanged?.call(value);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(AppRadius.pill),
        boxShadow: AppShadows.soft,
      ),
      child: TextField(
        controller: _controller,
        onChanged: _handleChanged,
        autofocus: widget.autofocus,
        textInputAction: TextInputAction.search,
        style: theme.textTheme.bodyLarge,
        decoration: InputDecoration(
          hintText: widget.hint,
          filled: true,
          fillColor: theme.cardTheme.color,
          prefixIcon: const Icon(Icons.search_rounded, size: 20),
          suffixIcon: _controller.text.isEmpty
              ? null
              : IconButton(
                  tooltip: 'Clear',
                  icon: const Icon(Icons.close_rounded, size: 18),
                  onPressed: () {
                    _controller.clear();
                    _handleChanged('');
                  },
                ),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: AppSpacing.lg,
            vertical: AppSpacing.md,
          ),
          border: _border(Colors.transparent),
          enabledBorder: _border(theme.colorScheme.outlineVariant),
          focusedBorder: _border(theme.colorScheme.primary, width: 1.6),
        ),
      ),
    );
  }

  OutlineInputBorder _border(Color color, {double width = 1.2}) {
    return OutlineInputBorder(
      borderRadius: BorderRadius.circular(AppRadius.pill),
      borderSide: BorderSide(color: color, width: width),
    );
  }
}
