import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../providers/theme_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/course_portal_button.dart';
import '../widgets/encre_refresh.dart';
import '../services/haptic_service.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static const _cards = [
    _HomeCard('/vocab', Icons.menu_book_rounded, 'Dictionary',
        '300 A1/A2 words\nwith conjugations', AppTheme.indigo),
    _HomeCard('/grammar', Icons.library_books_rounded, 'Grammar',
        '51 rules from books\nwith examples & tables', AppTheme.aubergine),
    _HomeCard('/writing', Icons.edit_note_rounded, 'Writing Practice',
        '240 short texts\ngrammar & translations', AppTheme.terracotta),
  ];

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final tp = context.watch<ThemeProvider>();
    final width = MediaQuery.sizeOf(context).width;
    final gridColumns = width >= 1200 ? 4 : width >= 760 ? 3 : 2;
    final gridAspect =
        width >= 1200 ? 1.45 : width >= 760 ? 1.25 : 1.1;

    return Scaffold(
      body: EncreRefresh(
        onRefresh: () async {
          HapticService.instance.streakRise();
          await Future.delayed(const Duration(seconds: 1));
        },
        child: CustomScrollView(
        slivers: [
          // ── Watercolour hero ─────────────────────────────────
          SliverAppBar(
            expandedHeight: 280,
            pinned: true,
            actions: [
              // Menu button — opens fullscreen menu
              IconButton(
                icon: Icon(
                  Icons.menu_rounded,
                  color: isDark ? AppTheme.offWhite : AppTheme.ink,
                ),
                onPressed: () => ShellMenuNotifier.open(context),
              ),
              const CoursePortalButton(),
            ],
            flexibleSpace: FlexibleSpaceBar(
              background: _WatercolorHero(isDark: isDark, userName: tp.userName),
            ),
          ),

          // ── Daily goal card ──────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 16, 16, 8),
              child: _DailyGoalCard(isDark: isDark, streak: tp.streak),
            ),
          ),

          // ── Feature cards ─────────────────────────────────────
          SliverPadding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            sliver: SliverGrid(
              delegate: SliverChildBuilderDelegate(
                (context, i) => _HomeCardWidget(card: _cards[i], index: i),
                childCount: _cards.length,
              ),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: gridColumns,
                mainAxisSpacing: 14,
                crossAxisSpacing: 14,
                childAspectRatio: gridAspect,
              ),
            ),
          ),

          // ── Word of the Day ──────────────────────────────────
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(16, 20, 16, 100),
              child: _WordOfTheDay(isDark: isDark),
            ),
          ),
        ],
      ),
    ),
  );
  }
}

// ── Watercolour Hero ──────────────────────────────────────────
class _WatercolorHero extends StatelessWidget {
  final bool isDark;
  final String userName;

  const _WatercolorHero({required this.isDark, required this.userName});

  @override
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: isDark
              ? [
                  const Color(0xFF0B1120),
                  const Color(0xFF1A1040),
                  const Color(0xFF201525),
                ]
              : [
                  const Color(0xFFFDF6F0),
                  const Color(0xFFF7EDE4),
                  const Color(0xFFF0E4D8),
                ],
        ),
      ),
      child: Stack(
        children: [
          // Decorative circles — watercolour blobs
          Positioned(
            right: -30,
            top: -30,
            child: Container(
              width: 160,
              height: 160,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? const Color(0xFF4A3060).withValues(alpha: 0.25)
                    : AppTheme.terracotta.withValues(alpha: 0.08),
              ),
            ),
          ),
          Positioned(
            left: -40,
            bottom: -20,
            child: Container(
              width: 200,
              height: 200,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? const Color(0xFF2A3A60).withValues(alpha: 0.2)
                    : AppTheme.sage.withValues(alpha: 0.06),
              ),
            ),
          ),
          Positioned(
            right: 60,
            bottom: 10,
            child: Container(
              width: 80,
              height: 80,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: isDark
                    ? const Color(0xFF3A2050).withValues(alpha: 0.15)
                    : AppTheme.indigo.withValues(alpha: 0.05),
              ),
            ),
          ),
          // Streak ring — top right
          Positioned(
            right: 60,
            top: 56,
            child: _StreakRing(isDark: isDark),
          ),
          // Content
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 80, 24, 24),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Bonjour${userName.isNotEmpty ? ', $userName' : ''} 👋',
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 32,
                    fontWeight: FontWeight.w800,
                    color: isDark ? AppTheme.offWhite : AppTheme.ink,
                    height: 1.1,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  '"Petit à petit, l\'oiseau fait son nid."',
                  style: TextStyle(
                    fontStyle: FontStyle.italic,
                    fontSize: 14,
                    color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  'Little by little, the bird makes its nest.',
                  style: TextStyle(
                    fontSize: 12,
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
    );
  }
}

// ── Streak Ring ────────────────────────────────────────────────
class _StreakRing extends StatelessWidget {
  final bool isDark;

  const _StreakRing({required this.isDark});

  @override
  Widget build(BuildContext context) {
    final terracotta = isDark ? AppTheme.warmCoral : AppTheme.terracotta;
    return GestureDetector(
      onTap: () {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: const Text('🔥 Keep your streak going!'),
            duration: const Duration(seconds: 2),
          ),
        );
      },
      child: Container(
        width: 52,
        height: 28,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        decoration: BoxDecoration(
          color: isDark
              ? AppTheme.charcoal.withValues(alpha: 0.7)
              : Colors.white.withValues(alpha: 0.7),
          borderRadius: BorderRadius.circular(14),
          border: Border.all(
            color: terracotta.withValues(alpha: 0.3),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              '🔥',
              style: const TextStyle(fontSize: 13),
            ),
            const SizedBox(width: 3),
            Text(
              '12',
              style: TextStyle(
                fontSize: 12,
                fontWeight: FontWeight.w800,
                color: terracotta,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// ── Daily Goal Card ────────────────────────────────────────────
class _DailyGoalCard extends StatelessWidget {
  final bool isDark;
  final int streak;

  const _DailyGoalCard({required this.isDark, required this.streak});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final terracotta = isDark ? AppTheme.warmCoral : AppTheme.terracotta;
    final progress = 0.47; // simulated 47%

    return Container(
      padding: const EdgeInsets.all(20),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            terracotta.withValues(alpha: 0.08),
            (isDark ? AppTheme.sage : AppTheme.secondary).withValues(alpha: 0.05),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(AppTheme.radius),
        border: Border.all(
          color: terracotta.withValues(alpha: 0.15),
        ),
      ),
      child: Row(
        children: [
          // Donut chart
          SizedBox(
            width: 56,
            height: 56,
            child: Stack(
              alignment: Alignment.center,
              children: [
                CircularProgressIndicator(
                  value: progress,
                  strokeWidth: 5,
                  backgroundColor: isDark
                      ? Colors.white.withValues(alpha: 0.06)
                      : Colors.black.withValues(alpha: 0.05),
                  valueColor: AlwaysStoppedAnimation(terracotta),
                ),
                Text(
                  '${(progress * 100).toInt()}%',
                  style: TextStyle(
                    fontSize: 12,
                    fontWeight: FontWeight.w800,
                    color: terracotta,
                  ),
                ),
              ],
            ),
          ),
          const SizedBox(width: 18),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "Today's Goal",
                  style: theme.textTheme.titleMedium?.copyWith(
                    fontWeight: FontWeight.w700,
                    fontSize: 15,
                  ),
                ),
                const SizedBox(height: 2),
                Text(
                  '15 minutes · ${streak > 0 ? "🔥 $streak day streak" : "Start today!"}',
                  style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
                  ),
                ),
              ],
            ),
          ),
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
            decoration: BoxDecoration(
              color: terracotta,
              borderRadius: BorderRadius.circular(AppTheme.radiusPill),
            ),
            child: Text(
              'Resume',
              style: TextStyle(
                fontSize: 13,
                fontWeight: FontWeight.w700,
                color: isDark ? AppTheme.deepInk : Colors.white,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Feature card data ──────────────────────────────────────────
class _HomeCard {
  final String route;
  final IconData icon;
  final String title;
  final String subtitle;
  final Color color;
  const _HomeCard(
      this.route, this.icon, this.title, this.subtitle, this.color);
}

class _HomeCardWidget extends StatelessWidget {
  final _HomeCard card;
  final int index;
  const _HomeCardWidget({required this.card, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return GestureDetector(
      onTap: () => context.go(card.route),
      child: Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          borderRadius: BorderRadius.circular(AppTheme.radius),
          border: Border.all(
            color: isDark
                ? AppTheme.darkBorder.withValues(alpha: 0.5)
                : Colors.black.withValues(alpha: 0.04),
          ),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withValues(alpha: isDark ? 0 : 0.04),
              blurRadius: 8,
              offset: const Offset(0, 2),
            ),
          ],
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
                  color: card.color.withValues(alpha: 0.12),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Icon(card.icon, color: card.color, size: 24),
              ),
              const Spacer(),
              Text(
                card.title,
                style: GoogleFonts.playfairDisplay(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppTheme.offWhite : AppTheme.ink,
                ),
              ),
              const SizedBox(height: 4),
              Text(
                card.subtitle,
                style: TextStyle(
                  fontSize: 11.5,
                  color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
                ),
              ),
            ],
          ),
        ),
      )
          .animate(delay: Duration(milliseconds: index * 80))
          .fadeIn(duration: 350.ms)
          .slideY(begin: 0.1, curve: Curves.easeOut),
    );
  }
}

// ── Word of the Day Carousel ───────────────────────────────────
class _WordOfTheDay extends StatefulWidget {
  final bool isDark;
  const _WordOfTheDay({required this.isDark});

  @override
  State<_WordOfTheDay> createState() => _WordOfTheDayState();
}

class _WordOfTheDayState extends State<_WordOfTheDay> {
  final _words = const [
    _MotDuJour('le journal', '/ʒuʁ.nal/', 'newspaper / diary'),
    _MotDuJour('aujourd\'hui', '/o.ʒuʁ.dɥi/', 'today'),
    _MotDuJour('ensemble', '/ɑ̃.sɑ̃bl/', 'together'),
    _MotDuJour('d\'abord', '/da.bɔʁ/', 'first / at first'),
    _MotDuJour('surtout', '/syʁ.tu/', 'especially'),
  ];

  int _current = 0;

  @override
  void initState() {
    super.initState();
    // Auto-advance every 5 seconds
    Future.delayed(const Duration(seconds: 5), _autoAdvance);
  }

  void _autoAdvance() {
    if (!mounted) return;
    setState(() {
      _current = (_current + 1) % _words.length;
    });
    Future.delayed(const Duration(seconds: 5), _autoAdvance);
  }

  @override
  Widget build(BuildContext context) {
    final word = _words[_current];
    final terracotta =
        widget.isDark ? AppTheme.warmCoral : AppTheme.terracotta;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(bottom: 12),
          child: Row(
            children: [
              Icon(Icons.auto_stories_rounded,
                  size: 18, color: terracotta),
              const SizedBox(width: 8),
              Text(
                'Le Mot du Jour',
                style: GoogleFonts.playfairDisplay(
                  fontSize: 18,
                  fontWeight: FontWeight.w700,
                  color: widget.isDark ? AppTheme.offWhite : AppTheme.ink,
                ),
              ),
            ],
          ),
        ),
        GestureDetector(
          onTap: () => context.go('/vocab'),
          child: AnimatedSwitcher(
            duration: const Duration(milliseconds: 400),
            transitionBuilder: (child, anim) =>
                FadeTransition(opacity: anim, child: child),
            child: Container(
              key: ValueKey(_current),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: widget.isDark
                    ? AppTheme.charcoal
                    : Colors.white,
                borderRadius: BorderRadius.circular(AppTheme.radius),
                border: Border.all(
                  color: terracotta.withValues(alpha: 0.2),
                ),
              ),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          word.french,
                          style: GoogleFonts.playfairDisplay(
                            fontSize: 22,
                            fontWeight: FontWeight.w700,
                            color: widget.isDark
                                ? AppTheme.offWhite
                                : AppTheme.ink,
                          ),
                        ),
                        const SizedBox(height: 4),
                        Text(
                          word.phonetic,
                          style: TextStyle(
                            fontSize: 13,
                            fontFamily: 'JetBrainsMono',
                            color: widget.isDark
                                ? AppTheme.mutedGrey
                                : AppTheme.warmGrey,
                          ),
                        ),
                        const SizedBox(height: 2),
                        Text(
                          word.english,
                          style: TextStyle(
                            fontSize: 13,
                            fontStyle: FontStyle.italic,
                            color: widget.isDark
                                ? AppTheme.mutedGrey
                                : AppTheme.warmGrey,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Icon(
                    Icons.waves,
                    size: 28,
                    color: terracotta.withValues(alpha: 0.6),
                  ),
                ],
              ),
            ),
          ),
        ),
        const SizedBox(height: 10),
        // Dot indicators
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(
            _words.length,
            (i) => Container(
              width: i == _current ? 20 : 6,
              height: 6,
              margin: const EdgeInsets.symmetric(horizontal: 3),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(3),
                color: i == _current
                    ? terracotta
                    : (widget.isDark
                        ? Colors.white.withValues(alpha: 0.15)
                        : Colors.black.withValues(alpha: 0.1)),
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class _MotDuJour {
  final String french;
  final String phonetic;
  final String english;
  const _MotDuJour(this.french, this.phonetic, this.english);
}
