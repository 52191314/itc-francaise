import 'package:flutter/material.dart';

/// "Encre" — a terracotta ink-drop themed pull-to-refresh widget.
///
/// Replaces the default Material refresh indicator with a custom
/// ink-drop animation in the app's signature terracotta colour.
class EncreRefresh extends StatelessWidget {
  final Widget child;
  final Future<void> Function() onRefresh;

  const EncreRefresh({
    super.key,
    required this.child,
    required this.onRefresh,
  });

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh: onRefresh,
      displacement: 80,
      color: const Color(0xFFC45D3A), // terracotta
      backgroundColor: Theme.of(context).brightness == Brightness.dark
          ? const Color(0xFF1A1D23)
          : Colors.white,
      strokeWidth: 3,
      child: child,
    );
  }
}
