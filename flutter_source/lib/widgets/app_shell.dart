import 'package:flutter/material.dart';

import 'atelier_bottom_nav.dart';
import 'fullscreen_menu.dart';

/// Wraps each screen with the Atelier bottom nav rail.
///
/// Provides [AppShellMenu.of(context)] to open the full-screen menu
/// from any descendant widget.
class AppShell extends StatefulWidget {
  final Widget child;
  final int routeIndex;

  const AppShell({
    super.key,
    required this.child,
    required this.routeIndex,
  });

  @override
  State<AppShell> createState() => _AppShellState();
}

class _AppShellState extends State<AppShell> {
  bool _menuOpen = false;

  void openMenu() => setState(() => _menuOpen = true);
  void _closeMenu() => setState(() => _menuOpen = false);

  @override
  Widget build(BuildContext context) {
    if (_menuOpen) {
      return FullscreenMenu(onClose: _closeMenu);
    }

      return ShellMenuNotifier(
      openMenu: openMenu,
      child: Stack(
        children: [
          widget.child,
          // Bottom nav overlay
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            child: AtelierBottomNav(currentIndex: widget.routeIndex),
          ),
        ],
      ),
    );
  }
}

// ── InheritedWidget to propagate openMenu ──────────────────────

class ShellMenuNotifier extends InheritedWidget {
  final VoidCallback openMenu;

  const ShellMenuNotifier({
    required this.openMenu,
    required super.child,
  });

  @override
  bool updateShouldNotify(covariant ShellMenuNotifier oldWidget) => false;

  static void open(BuildContext context) {
    final notifier =
        context.findAncestorWidgetOfExactType<ShellMenuNotifier>();
    notifier?.openMenu();
  }
}

/// Helper to determine the route index from the current path.
int routeIndexFromPath(String path) {
  if (path.startsWith('/vocab')) return 1;
  if (path.startsWith('/grammar')) return 2;
  if (path.startsWith('/writing') || path.startsWith('/journal')) return 3;
  return 0;
}
