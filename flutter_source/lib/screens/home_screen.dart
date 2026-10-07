import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';

import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/course_portal_button.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _cards = [
    _HomeCard('/vocab', Icons.menu_book_rounded, 'Vocabulary',
        '300 A1/A2 words\nwith conjugations', AppTheme.accentLight),
    _HomeCard('/flash', Icons.style_rounded, 'Flashcards',
        'Multiple choice\nsession practice', AppTheme.blue),
    _HomeCard('/quiz', Icons.quiz_rounded, 'Quiz', 'Test your\ngrammar & vocab',
        AppTheme.gold),
    _HomeCard('/roleplay', Icons.mic_rounded, 'Roleplay',
        'A2 oral exam\nprep with timer', AppTheme.coral),
    _HomeCard('/grammar', Icons.library_books_rounded, 'Grammar',
        '51 rules from books\nwith examples & tables', AppTheme.accentDark),
    _HomeCard('/writing', Icons.edit_note_rounded, 'Writing Practice',
        '240 short texts\ngrammar & translations', AppTheme.purple),
    _HomeCard('/progress', Icons.bar_chart_rounded, 'Progress',
        'Track your\nstudy sessions', AppTheme.purple),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final width = MediaQuery.sizeOf(context).width;
    final gridColumns = width >= 1200
        ? 4
        : width >= 760
            ? 3
            : 2;
    final gridAspect = width >= 1200
        ? 1.45
        : width >= 760
            ? 1.25
            : 1.1;

    return Scaffold(
      drawer: const AppDrawer(),
      body: CustomScrollView(
        slivers: [
          // ── Gradient hero app bar ────────────────────────────────
          SliverAppBar(
            expandedHeight: 200,
            pinned: true,
            actions: const [CoursePortalButton()],
            flexibleSpace: FlexibleSpaceBar(
              background: Container(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topLeft,
                    end: Alignment.bottomRight,
                    colors: [
                      isDark
                          ? const Color(0xFF0F1729)
                          : const Color(0xFFE8F5F2),
                      isDark
                          ? const Color(0xFF16213E)
                          : const Color(0xFFEEF2FF),
                    ],
                  ),
                ),
                child: Stack(
                  children: [
                    // decorative circles
                    Positioned(
                      right: -40,
                      top: -40,
                      child: Container(
                        width: 180,
                        height: 180,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.primary.withOpacity(0.08),
                        ),
                      ),
                    ),
                    Positioned(
                      left: -30,
                      bottom: -30,
                      child: Container(
                        width: 140,
                        height: 140,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: theme.colorScheme.secondary.withOpacity(0.06),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(20, 80, 20, 20),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.end,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Bonjour 👋',
                            style: theme.textTheme.headlineMedium?.copyWith(
                              fontWeight: FontWeight.w800,
                              fontSize: 26,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            'Ready to practice French today?',
                            style: theme.textTheme.bodyMedium?.copyWith(
                              color: theme.textTheme.bodySmall?.color,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),

          // ── Feature grid ─────────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.all(16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _HomeCardWidget(card: _cards[i], index: i),
                childCount: _cards.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridColumns,
                mainAxisSpacing: 12,
                crossAxisSpacing: 12,
                childAspectRatio: gridAspect,
              ),
            ),
          ),

          // ── Tip banner ───────────────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 4, 16, 32),
              child: Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: theme.colorScheme.primary.withOpacity(0.08),
                  borderRadius: BorderRadius.circular(AppTheme.radius),
                  border: Border.all(
                    color: theme.colorScheme.primary.withOpacity(0.2),
                  ),
                ),
                child: Row(
                  children: [
                    Icon(Icons.tips_and_updates_rounded,
                        color: theme.colorScheme.primary, size: 20),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        'Tap any word in Vocabulary to hear it spoken in French!',
                        style: theme.textTheme.bodySmall?.copyWith(
                          color: theme.colorScheme.onSurface.withOpacity(0.8),
                          fontSize: 13,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Card data ──────────────────────────────────────────────────
class _HomeCard {
  final String route;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  const _HomeCard(this.route, this.icon, this.title, this.subtitle, this.color);
}

// ── Card widget ────────────────────────────────────────────────
class _HomeCardWidget extends StatelessWidget {
  final _HomeCard card;
  final int index;
  const _HomeCardWidget({super.key, required this.card, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return GestureDetector(
      onTap: () => context.go(card.route),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radius),
          border: Border.all(
            color: card.color.withOpacity(0.25),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: card.color.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Icon(card.icon, color: card.color, size: 24),
              ),
              const Spacer(),
              Text(
                card.title,
                style: theme.textTheme.titleMedium?.copyWith(
                  fontWeight: FontWeight.w700,
                  fontSize: 15,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                card.subtitle,
                style: theme.textTheme.bodySmall?.copyWith(fontSize: 11.5),
              ),
            ],
          ),
        ),
      )
          .animate(delay: Duration(milliseconds: index * 60))
          .fadeIn(duration: 300.ms)
          .slideY(begin: 0.1, curve: Curves.easeOut),
    );
  }
}
