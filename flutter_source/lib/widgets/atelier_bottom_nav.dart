import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

/// The floating bottom navigation rail — "Le Sous-Chef"
///
/// A pill-shaped glassmorphic bar with four nav items and a
/// center FAB that is context-aware per the active tab.
class AtelierBottomNav extends StatelessWidget {
  final int currentIndex;

  const AtelierBottomNav({super.key, required this.currentIndex});

  static const _tabs = [
    _NavItem('Home', Icons.home_rounded, '/'),
    _NavItem('Dictionary', Icons.menu_book_rounded, '/vocab'),
    _NavItem('Grammar', Icons.library_books_rounded, '/grammar'),
    _NavItem('Writing', Icons.edit_note_rounded, '/writing'),
  ];

  String get _fabLabel {
    switch (currentIndex) {
      case 0:
        return 'Daily Lesson';
      case 1:
        return 'Study Deck';
      case 2:
        return 'Quick Quiz';
      case 3:
        return 'Focus Mode';
      default:
        return 'Commencer';
    }
  }

  IconData get _fabIcon {
    switch (currentIndex) {
      case 0:
        return Icons.auto_stories_rounded;
      case 1:
        return Icons.style_rounded;
      case 2:
        return Icons.quiz_rounded;
      case 3:
        return Icons.edit_rounded;
      default:
        return Icons.play_arrow_rounded;
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final terracotta = isDark ? const Color(0xFFE07A55) : const Color(0xFFC45D3A);

    return Container(
      height: 72,
      margin: const EdgeInsets.symmetric(horizontal: 12).copyWith(bottom: 8),
      decoration: BoxDecoration(
        color: isDark
            ? const Color(0xFF1A1D23).withValues(alpha: 0.85)
            : Colors.white.withValues(alpha: 0.85),
        borderRadius: BorderRadius.circular(36),
        border: Border.all(
          color: isDark
              ? Colors.white.withValues(alpha: 0.08)
              : Colors.black.withValues(alpha: 0.06),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: isDark ? 0.3 : 0.08),
            blurRadius: 20,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(36),
        child: BackdropFilter(
          filter: isDark
              ? const ColorFilter.mode(
                  Color(0xFF0F1115), BlendMode.overlay)
              : const ColorFilter.mode(
                  Color(0xFFF7F5F0), BlendMode.overlay),
          child: Row(
            children: [
              // Left nav items
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NavItemWidget(
                      item: _tabs[0],
                      isActive: currentIndex == 0,
                      onTap: () => _navigate(context, 0),
                    ),
                    _NavItemWidget(
                      item: _tabs[1],
                      isActive: currentIndex == 1,
                      onTap: () => _navigate(context, 1),
                    ),
                  ],
                ),
              ),

              // Center FAB
              GestureDetector(
                onTap: () {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('✨ $_fabLabel — coming soon!'),
                      duration: const Duration(seconds: 2),
                    ),
                  );
                },
                child: Container(
                  width: 52,
                  height: 52,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        terracotta,
                        terracotta.withValues(alpha: 0.8),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: terracotta.withValues(alpha: 0.35),
                        blurRadius: 12,
                        offset: const Offset(0, 3),
                      ),
                    ],
                  ),
                  child: Icon(
                    _fabIcon,
                    color: Colors.white,
                    size: 22,
                  ),
                ),
              ),

              // Right nav items
              Expanded(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    _NavItemWidget(
                      item: _tabs[2],
                      isActive: currentIndex == 2,
                      onTap: () => _navigate(context, 2),
                    ),
                    _NavItemWidget(
                      item: _tabs[3],
                      isActive: currentIndex == 3,
                      onTap: () => _navigate(context, 3),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _navigate(BuildContext context, int index) {
    final route = _tabs[index].route;
    if (GoRouterState.of(context).uri.path != route) {
      context.go(route);
    }
  }
}

class _NavItem {
  final String label;
  final IconData icon;
  final String route;
  const _NavItem(this.label, this.icon, this.route);
}

class _NavItemWidget extends StatelessWidget {
  final _NavItem item;
  final bool isActive;
  final VoidCallback onTap;

  const _NavItemWidget({
    required this.item,
    required this.isActive,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final terracotta = isDark ? const Color(0xFFE07A55) : const Color(0xFFC45D3A);

    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: SizedBox(
        width: 56,
        height: 64,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            // Active dot indicator
            if (isActive)
              Container(
                width: 5,
                height: 5,
                decoration: BoxDecoration(
                  color: terracotta,
                  shape: BoxShape.circle,
                ),
                margin: const EdgeInsets.only(bottom: 4),
              )
            else
              const SizedBox(height: 9),
            Icon(
              item.icon,
              size: isActive ? 26 : 22,
              color: isActive
                  ? terracotta
                  : (isDark
                      ? Colors.white.withValues(alpha: 0.45)
                      : Colors.black.withValues(alpha: 0.35)),
            ),
            const SizedBox(height: 2),
            Text(
              item.label,
              style: TextStyle(
                fontSize: isActive ? 10 : 9,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive
                    ? terracotta
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.45)
                        : Colors.black.withValues(alpha: 0.35)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
