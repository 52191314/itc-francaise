import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../services/course_portal_navigation.dart';
import '../theme/app_theme.dart';

class AppDrawer extends StatelessWidget {
  const AppDrawer({super.key});

  static const _items = [
    _DrawerItem('/', Icons.home_rounded, 'Home'),
    _DrawerItem('/vocab', Icons.menu_book_rounded, 'Vocabulary'),
    _DrawerItem('/flash', Icons.style_rounded, 'Flashcards'),
    _DrawerItem('/quiz', Icons.quiz_rounded, 'Quiz'),
    _DrawerItem('/roleplay', Icons.mic_rounded, 'Roleplay'),
    _DrawerItem('/grammar', Icons.library_books_rounded, 'Grammar Handbook'),
    _DrawerItem('/writing', Icons.edit_note_rounded, 'Writing Practice'),
    _DrawerItem('/progress', Icons.bar_chart_rounded, 'Progress'),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final accent = theme.colorScheme.primary;
    final current = GoRouterState.of(context).uri.path;

    return Drawer(
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // ── Header ────────────────────────────────────────────────
            Container(
              padding: const EdgeInsets.fromLTRB(20, 24, 20, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [
                    accent.withOpacity(0.15),
                    theme.colorScheme.secondary.withOpacity(0.08),
                  ],
                ),
                border: Border(
                  bottom: BorderSide(
                    color: isDark
                        ? Colors.white.withOpacity(0.07)
                        : Colors.black.withOpacity(0.06),
                  ),
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Logo
                  Container(
                    width: 48,
                    height: 48,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [accent, theme.colorScheme.secondary],
                      ),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    ),
                    child: const Center(
                      child: Text(
                        'FR',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w900,
                          fontSize: 18,
                          letterSpacing: 1,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    'FrenchPro',
                    style: theme.textTheme.titleLarge?.copyWith(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                    ),
                  ),
                  Text(
                    'A1 / A2 Study Companion',
                    style: theme.textTheme.bodySmall?.copyWith(fontSize: 12),
                  ),
                ],
              ),
            ),

            // ── Nav items ─────────────────────────────────────────────
            const SizedBox(height: 8),
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                children: [
                  if (supportsCoursePortalNavigation)
                    ListTile(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                      ),
                      leading: Icon(
                        Icons.arrow_back_rounded,
                        color: theme.colorScheme.primary,
                      ),
                      title: const Text(
                        'Back to Course Portal',
                        style: TextStyle(fontWeight: FontWeight.w700),
                      ),
                      onTap: openCoursePortal,
                    ),
                  if (supportsCoursePortalNavigation) const Divider(),
                  ..._items.map((item) {
                    final isActive = current == item.route ||
                        (item.route != '/' && current.startsWith(item.route));
                    return _DrawerTile(item: item, isActive: isActive);
                  }),
                ],
              ),
            ),

            // ── Footer: theme toggle ───────────────────────────────────
            Divider(
              height: 1,
              color: isDark
                  ? Colors.white.withOpacity(0.07)
                  : Colors.black.withOpacity(0.06),
            ),
            Padding(
              padding: const EdgeInsets.all(12),
              child: Consumer<ThemeProvider>(
                builder: (ctx, tp, _) => ListTile(
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  leading: Icon(
                    tp.isDark
                        ? Icons.light_mode_rounded
                        : Icons.dark_mode_rounded,
                    color: theme.colorScheme.primary,
                  ),
                  title: Text(
                    tp.isDark ? 'Switch to Light mode' : 'Switch to Dark mode',
                    style: const TextStyle(
                        fontWeight: FontWeight.w600, fontSize: 14),
                  ),
                  trailing: Switch(
                    value: !tp.isDark,
                    onChanged: (_) => tp.toggle(),
                    activeColor: theme.colorScheme.primary,
                  ),
                  onTap: () => tp.toggle(),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Individual nav tile ────────────────────────────────────────
class _DrawerItem {
  final String route;
  final IconData icon;
  final String label;
  const _DrawerItem(this.route, this.icon, this.label);
}

class _DrawerTile extends StatelessWidget {
  final _DrawerItem item;
  final bool isActive;
  const _DrawerTile({super.key, required this.item, required this.isActive});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final accent = theme.colorScheme.primary;

    return Container(
      margin: const EdgeInsets.symmetric(vertical: 2),
      decoration: isActive
          ? BoxDecoration(
              color: accent.withOpacity(0.12),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              border: Border.all(color: accent.withOpacity(0.25)),
            )
          : null,
      child: ListTile(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        ),
        leading: Icon(
          item.icon,
          color:
              isActive ? accent : theme.colorScheme.onSurface.withOpacity(0.6),
          size: 22,
        ),
        title: Text(
          item.label,
          style: TextStyle(
            fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
            fontSize: 14.5,
            color: isActive ? accent : theme.colorScheme.onSurface,
          ),
        ),
        onTap: () {
          Navigator.of(context).pop(); // close drawer
          context.go(item.route);
        },
      ),
    );
  }
}
