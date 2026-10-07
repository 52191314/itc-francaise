import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';

/// A full-screen overlay menu with large serif typography,
/// accessed by swiping right or tapping the avatar/logo.
class FullscreenMenu extends StatelessWidget {
  final VoidCallback onClose;

  const FullscreenMenu({super.key, required this.onClose});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tp = context.watch<ThemeProvider>();
    final bg = isDark ? AppTheme.deepInk : AppTheme.parchment;

    return Material(
      color: bg,
      child: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // ── Header: close + FR watermark ────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(8, 8, 16, 0),
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(
                      Icons.close_rounded,
                      color: isDark ? AppTheme.offWhite : AppTheme.ink,
                    ),
                    onPressed: onClose,
                  ),
                  const Spacer(),
                  // Theme toggle as celestial moon/sun switch
                  Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Icon(
                        Icons.light_mode_rounded,
                        size: 16,
                        color: tp.isDark
                            ? AppTheme.mutedGrey
                            : AppTheme.terracotta,
                      ),
                      const SizedBox(width: 8),
                      GestureDetector(
                        onTap: () => tp.toggle(),
                        child: Container(
                          width: 44,
                          height: 24,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            color: isDark
                                ? const Color(0xFF2A2D35)
                                : AppTheme.terracotta.withValues(alpha: 0.2),
                          ),
                          child: AnimatedAlign(
                            duration: const Duration(milliseconds: 300),
                            curve: Curves.easeInOut,
                            alignment: tp.isDark
                                ? Alignment.centerLeft
                                : Alignment.centerRight,
                            child: Container(
                              width: 20,
                              height: 20,
                              margin: const EdgeInsets.all(2),
                              decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                color: tp.isDark
                                    ? AppTheme.deepInk
                                    : AppTheme.terracotta,
                              ),
                              child: Icon(
                                tp.isDark
                                    ? Icons.nightlight_round
                                    : Icons.wb_sunny_rounded,
                                size: 12,
                                color: tp.isDark
                                    ? AppTheme.offWhite
                                    : Colors.white,
                              ),
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 8),
                      Icon(
                        Icons.dark_mode_rounded,
                        size: 16,
                        color: tp.isDark
                            ? AppTheme.offWhite
                            : AppTheme.mutedGrey,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            // ── FR watermark ────────────────────────────────────
            Padding(
              padding: const EdgeInsets.only(left: 24, top: 24),
              child:               Text(
                'FR',
                style: _serif(80,
                    w: FontWeight.w900,
                    c: isDark
                        ? Colors.white.withValues(alpha: 0.04)
                        : Colors.black.withValues(alpha: 0.04)),
              ),
            ),

            const Spacer(),

            // ── Large serif nav items ───────────────────────────
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _MenuLink(
                    label: 'Home',
                    icon: Icons.home_rounded,
                    route: '/',
                    isDark: isDark,
                    onTap: () {
                      onClose();
                      context.go('/');
                    },
                  ),
                  const SizedBox(height: 24),
                  _MenuLink(
                    label: 'Dictionary',
                    icon: Icons.menu_book_rounded,
                    route: '/vocab',
                    isDark: isDark,
                    onTap: () {
                      onClose();
                      context.go('/vocab');
                    },
                  ),
                  const SizedBox(height: 24),
                  _MenuLink(
                    label: 'Grammar Handbook',
                    icon: Icons.library_books_rounded,
                    route: '/grammar',
                    isDark: isDark,
                    onTap: () {
                      onClose();
                      context.go('/grammar');
                    },
                  ),
                  const SizedBox(height: 24),
                  _MenuLink(
                    label: 'Writing Practice',
                    icon: Icons.edit_note_rounded,
                    route: '/writing',
                    isDark: isDark,
                    onTap: () {
                      onClose();
                      context.go('/writing');
                    },
                  ),
                  const SizedBox(height: 24),
                  _MenuLink(
                    label: 'Le Journal',
                    icon: Icons.book_rounded,
                    route: '/journal',
                    isDark: isDark,
                    onTap: () {
                      onClose();
                      context.go('/journal');
                    },
                  ),
                ],
              ),
            ),

            const Spacer(flex: 2),

            // ── Footer ──────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(32, 0, 32, 32),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Divider(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.black.withValues(alpha: 0.06),
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'FrenchPro · A1/A2 Study Companion',
                    style: TextStyle(
                      fontSize: 12,
                      color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    'Atelier v2.0',
                    style: TextStyle(
                      fontSize: 11,
                      color: isDark
                          ? AppTheme.mutedGrey.withValues(alpha: 0.6)
                          : AppTheme.warmGrey.withValues(alpha: 0.6),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Menu link ────────────────────────────────────────────────
class _MenuLink extends StatelessWidget {
  final String label;
  final IconData icon;
  final String route;
  final bool isDark;
  final VoidCallback onTap;

  const _MenuLink({
    required this.label,
    required this.icon,
    required this.route,
    required this.isDark,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    final isActive = GoRouterState.of(context).uri.path == route;
    final color = isActive
        ? (isDark ? AppTheme.warmCoral : AppTheme.terracotta)
        : (isDark ? AppTheme.offWhite : AppTheme.ink);

    return GestureDetector(
      onTap: onTap,
      child: Row(
        children: [
          Icon(icon, size: 22, color: color),
          const SizedBox(width: 16),
          Text(
            label,
            style: _serif(28,
                w: isActive ? FontWeight.w700 : FontWeight.w500, c: color),
          ),
        ],
      ),
    );
  }
}

// Helper to build serif text without exposing private functions
TextStyle _serif(double size, {FontWeight w = FontWeight.w600, Color? c}) =>
    GoogleFonts.playfairDisplay(fontSize: size, fontWeight: w, color: c);
