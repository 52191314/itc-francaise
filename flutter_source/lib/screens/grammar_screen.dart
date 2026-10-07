import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/grammar_data.dart';
import '../models/grammar_rule.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/course_portal_button.dart';
import '../services/haptic_service.dart';
import '../services/tts_service.dart';

/// Les Règles — redesigned grammar handbook with interactive
/// page-turn cards, tabbed content, Mad Libs patterns, and quizzes.
class GrammarScreen extends StatefulWidget {
  const GrammarScreen({super.key});

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  String _query = '';
  String _level = 'all';
  final _searchCtrl = TextEditingController();
  bool _searchExpanded = false;

  List<GrammarRule> get _filtered {
    return grammarRules.where((r) {
      if (_level != 'all' && r.level.toUpperCase() != _level.toUpperCase()) {
        return false;
      }
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();
      if (r.title.toLowerCase().contains(q)) return true;
      if (r.rule.toLowerCase().contains(q)) return true;
      if (r.pattern.toLowerCase().contains(q)) return true;
      if (r.note != null && r.note!.toLowerCase().contains(q)) return true;
      if (r.summary != null && r.summary!.toLowerCase().contains(q)) return true;
      if (r.explain != null && r.explain!.toLowerCase().contains(q)) return true;
      if (r.trap != null && r.trap!.toLowerCase().contains(q)) return true;
      if (r.steps != null &&
          r.steps!.any((step) => step.toLowerCase().contains(q))) return true;
      if (r.examples.any((ex) =>
          ex.french.toLowerCase().contains(q) ||
          ex.english.toLowerCase().contains(q))) return true;
      if (r.tables != null) {
        for (final t in r.tables!) {
          if (t.title != null && t.title!.toLowerCase().contains(q)) return true;
          if (t.headers.any((h) => h.toLowerCase().contains(q))) return true;
          for (final row in t.rows) {
            if (row.any((cell) => cell.toLowerCase().contains(q))) return true;
          }
        }
      }
      return false;
    }).toList();
  }

  int _levelCount(String level) {
    if (level == 'all') return grammarRules.length;
    return grammarRules
        .where((r) => r.level.toUpperCase() == level.toUpperCase())
        .length;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final filtered = _filtered;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Les Règles',
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? AppTheme.offWhite : AppTheme.ink,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.menu_rounded,
                color: isDark ? AppTheme.offWhite : AppTheme.ink),
            onPressed: () => ShellMenuNotifier.open(context),
          ),
          const CoursePortalButton(),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: Text(
                '${filtered.length} / ${grammarRules.length}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: theme.colorScheme.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search + filters ─────────────────────────────────
          _buildSearchPanel(isDark),
          const Divider(height: 1),

          // ── Rule list ────────────────────────────────────────
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState(isDark)
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
                    itemCount: filtered.length,
                    itemBuilder: (ctx, i) {
                      final rule = filtered[i];
                      return _GrammarPageCard(
                        key: ValueKey('grammar-rule-${rule.id}'),
                        rule: rule,
                        index: i,
                        isDark: isDark,
                        searchQuery: _query,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }

  // ── Search panel ──────────────────────────────────────────────
  Widget _buildSearchPanel(bool isDark) {
    return Column(
      children: [
        GestureDetector(
          onTap: () => setState(() => _searchExpanded = true),
          child: Container(
            margin: const EdgeInsets.fromLTRB(16, 12, 16, 0),
            height: 48,
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF14161C) : Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radiusPill),
              border: Border.all(
                color: _searchExpanded
                    ? AppTheme.terracotta.withValues(alpha: 0.5)
                    : (isDark
                        ? Colors.white.withValues(alpha: 0.08)
                        : Colors.black.withValues(alpha: 0.06)),
              ),
            ),
            child: Row(
              children: [
                const SizedBox(width: 16),
                Icon(Icons.search_rounded,
                    size: 20,
                    color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey),
                if (!_searchExpanded) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _query.isEmpty ? 'Search rules, verbs, examples...' : _query,
                      style: TextStyle(
                        fontSize: 14,
                        color: _query.isEmpty
                            ? (isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)
                            : (isDark ? AppTheme.offWhite : AppTheme.ink),
                      ),
                    ),
                  ),
                  // AI Explain chip
                  Container(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                    decoration: BoxDecoration(
                      color: AppTheme.aubergine.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.auto_awesome_rounded,
                            size: 14, color: AppTheme.aubergine),
                        const SizedBox(width: 4),
                        Text(
                          'AI',
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w700,
                            color: AppTheme.aubergine,
                          ),
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(width: 4),
                ],
                if (_query.isNotEmpty)
                  IconButton(
                    icon: const Icon(Icons.clear_rounded, size: 18),
                    onPressed: () {
                      _searchCtrl.clear();
                      setState(() {
                        _query = '';
                        _searchExpanded = false;
                      });
                    },
                    padding: EdgeInsets.zero,
                    constraints: const BoxConstraints(),
                  ),
                if (!_searchExpanded) const SizedBox(width: 8),
              ],
            ),
          ),
        ),
        if (_searchExpanded)
          Container(
            margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
            padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
            decoration: BoxDecoration(
              color: isDark ? const Color(0xFF14161C) : Colors.white,
              borderRadius: const BorderRadius.vertical(
                  bottom: Radius.circular(AppTheme.radiusSm)),
            ),
            child: Column(
              children: [
                TextField(
                  controller: _searchCtrl,
                  autofocus: true,
                  onChanged: (v) => setState(() => _query = v),
                  decoration: const InputDecoration(
                    hintText: 'Search rules, verbs, examples, or tables...',
                    prefixIcon: Icon(Icons.search_rounded, size: 20),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                // Segmented level filter
                Row(
                  children: [
                    Text('Level',
                        style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppTheme.mutedGrey
                                : AppTheme.warmGrey)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Container(
                        height: 34,
                        decoration: BoxDecoration(
                          color: isDark
                              ? Colors.white.withValues(alpha: 0.04)
                              : Colors.black.withValues(alpha: 0.03),
                          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                        ),
                        child: Row(
                          children: ['all', 'A1', 'A2'].map((lv) {
                            final selected = _level == lv;
                            return Expanded(
                              child: GestureDetector(
                                onTap: () =>
                                    setState(() => _level = lv),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    color: selected
                                        ? AppTheme.terracotta
                                        : Colors.transparent,
                                    borderRadius:
                                        BorderRadius.circular(AppTheme.radiusPill),
                                  ),
                                  child: Text(
                                    lv == 'all'
                                        ? 'All (${_levelCount("all")})'
                                        : '$lv (${_levelCount(lv)})',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: selected
                                          ? FontWeight.w700
                                          : FontWeight.w500,
                                      color: selected
                                          ? Colors.white
                                          : (isDark
                                              ? AppTheme.offWhite
                                              : AppTheme.ink),
                                    ),
                                  ),
                                ),
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
        const SizedBox(height: 8),
      ],
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded,
              size: 48,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.12)),
          const SizedBox(height: 12),
          Text('No grammar rules matched your search',
              style: TextStyle(
                  fontSize: 15,
                  color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)),
          const SizedBox(height: 10),
          OutlinedButton(
            onPressed: () {
              _searchCtrl.clear();
              setState(() {
                _query = '';
                _level = 'all';
              });
            },
            child: const Text('Clear filters'),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  GRAMMAR PAGE CARD — expandable with tabs
// ═══════════════════════════════════════════════════════════════
class _GrammarPageCard extends StatefulWidget {
  final GrammarRule rule;
  final int index;
  final bool isDark;
  final String searchQuery;

  const _GrammarPageCard({
    super.key,
    required this.rule,
    required this.index,
    required this.isDark,
    required this.searchQuery,
  });

  @override
  State<_GrammarPageCard> createState() => _GrammarPageCardState();
}

class _GrammarPageCardState extends State<_GrammarPageCard>
    with SingleTickerProviderStateMixin {
  bool _isExpanded = false;
  int _currentTab = 0;
  Set<int> _answered = {};

  GrammarRule get rule => widget.rule;

  Color get _levelColor =>
      rule.level.toUpperCase() == 'A1' ? AppTheme.indigo : AppTheme.aubergine;

  List<String> get _tabs {
    final tabs = <String>['Règle', 'Exemples'];
    if (rule.tables != null && rule.tables!.isNotEmpty) tabs.add('Tableaux');
    if (rule.trap != null) tabs.add('Pièges');
    tabs.add('Quiz');
    return tabs;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final levelColor = _levelColor;

    return Container(
      margin: const EdgeInsets.only(bottom: 14),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.charcoal : Colors.white,
        borderRadius: BorderRadius.circular(AppTheme.radius),
        border: Border.all(
          color: _isExpanded
              ? levelColor.withValues(alpha: 0.3)
              : (isDark
                  ? AppTheme.darkBorder.withValues(alpha: 0.5)
                  : Colors.black.withValues(alpha: 0.04)),
        ),
        boxShadow: _isExpanded
            ? [
                BoxShadow(
                  color: levelColor.withValues(alpha: 0.04),
                  blurRadius: 12,
                  offset: const Offset(0, 4),
                ),
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radius),
        child: Column(
          children: [
            // ── Colored band + header ───────────────────────────
            Container(
              height: 4,
              color: levelColor,
            ),
            InkWell(
              onTap: () => setState(() {
                _isExpanded = !_isExpanded;
                if (!_isExpanded) _currentTab = 0;
              }),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    // Rule number
                    Text(
                      '#${rule.id}',
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 28,
                        fontWeight: FontWeight.w800,
                        color: levelColor.withValues(alpha: 0.3),
                        height: 1,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            rule.title,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: _isExpanded
                                  ? levelColor
                                  : (isDark ? AppTheme.offWhite : AppTheme.ink),
                            ),
                          ),
                          if (!_isExpanded) ...[
                            const SizedBox(height: 4),
                            Text(
                              rule.rule,
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                              style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppTheme.mutedGrey
                                    : AppTheme.warmGrey,
                              ),
                            ),
                          ],
                        ],
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Level badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 3),
                      decoration: BoxDecoration(
                        color: levelColor.withValues(alpha: 0.1),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        rule.level,
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w900,
                          color: levelColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 6),
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: isDark
                          ? AppTheme.mutedGrey
                          : AppTheme.warmGrey,
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            // ── Expanded content ───────────────────────────────
            AnimatedSize(
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? Column(
                      children: [
                        const Divider(height: 1),
                        // Tab bar
                        SizedBox(
                          height: 40,
                          child: ListView(
                            scrollDirection: Axis.horizontal,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            children: _tabs.asMap().entries.map((entry) {
                              final idx = entry.key;
                              final tab = entry.value;
                              final isActive = _currentTab == idx;
                              return Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 4),
                                child: GestureDetector(
                                  onTap: () =>
                                      setState(() => _currentTab = idx),
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 14, vertical: 8),
                                    decoration: BoxDecoration(
                                      color: isActive
                                          ? levelColor.withValues(alpha: 0.1)
                                          : Colors.transparent,
                                      borderRadius: BorderRadius.circular(
                                          AppTheme.radiusPill),
                                    ),
                                    child: Text(
                                      tab,
                                      style: TextStyle(
                                        fontSize: 12,
                                        fontWeight: isActive
                                            ? FontWeight.w700
                                            : FontWeight.w500,
                                        color: isActive
                                            ? levelColor
                                            : (isDark
                                                ? AppTheme.mutedGrey
                                                : AppTheme.warmGrey),
                                      ),
                                    ),
                                  ),
                                ),
                              );
                            }).toList(),
                          ),
                        ),
                        const Divider(height: 1),
                        // Tab content
                        _buildTabContent(),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: (widget.index * 30).clamp(0, 300)))
        .fadeIn(duration: 250.ms)
        .slideY(begin: 0.08, curve: Curves.easeOut);
  }

  // ── Tab content ───────────────────────────────────────────────
  Widget _buildTabContent() {
    switch (_currentTab) {
      case 0:
        return _buildRegleTab();
      case 1:
        return _buildExemplesTab();
      case 2:
        if (_tabs[2] == 'Tableaux') return _buildTableauxTab();
        if (_tabs[2] == 'Pièges') return _buildPiegesTab();
        return _buildQuizTab();
      case 3:
        if (_tabs.length > 3 && _tabs[3] == 'Pièges') return _buildPiegesTab();
        return _buildQuizTab();
      case 4:
        return _buildQuizTab();
      default:
        return const SizedBox.shrink();
    }
  }

  // ── Règle tab ─────────────────────────────────────────────────
  Widget _buildRegleTab() {
    final isDark = widget.isDark;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // Mad Libs pattern
          _buildPatternMadLibs(),
          const SizedBox(height: 14),
          // Rule explanation
          Text(
            rule.rule,
            style: TextStyle(
              fontSize: 14,
              height: 1.5,
              color: isDark ? AppTheme.offWhite : AppTheme.ink,
            ),
          ),
          // Detailed explanation
          if (rule.explain != null || rule.summary != null) ...[
            const SizedBox(height: 10),
            Text(
              rule.explain ?? rule.summary!,
              style: TextStyle(
                fontSize: 13,
                height: 1.5,
                color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
              ),
            ),
          ],
          // Steps
          if (rule.steps != null && rule.steps!.isNotEmpty) ...[
            const SizedBox(height: 16),
            Text('Steps to Follow',
                style: TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppTheme.offWhite : AppTheme.ink)),
            const SizedBox(height: 8),
            ...rule.steps!.asMap().entries.map((entry) {
              return Padding(
                padding: const EdgeInsets.only(bottom: 6),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: const EdgeInsets.only(top: 2, right: 10),
                      width: 18,
                      height: 18,
                      decoration: BoxDecoration(
                        color: _levelColor.withValues(alpha: 0.12),
                        shape: BoxShape.circle,
                      ),
                      alignment: Alignment.center,
                      child: Text('${entry.key + 1}',
                          style: TextStyle(
                              fontSize: 10,
                              fontWeight: FontWeight.w900,
                              color: _levelColor)),
                    ),
                    Expanded(
                      child: Text(entry.value,
                          style: TextStyle(
                              fontSize: 13,
                              height: 1.4,
                              color:
                                  isDark ? AppTheme.offWhite : AppTheme.ink)),
                    ),
                  ],
                ),
              );
            }),
          ],
          // Note
          if (rule.note != null && rule.note!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('💡 ',
                    style: TextStyle(
                        fontSize: 13,
                        color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)),
                Expanded(
                  child: Text(rule.note!,
                      style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: isDark
                              ? AppTheme.mutedGrey
                              : AppTheme.warmGrey)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ── Mad Libs Pattern ──────────────────────────────────────────
  Widget _buildPatternMadLibs() {
    final isDark = widget.isDark;
    // Parse pattern into tokens: backtick words and regular text
    final regex = RegExp(r'`([^`]+)`');
    final matches = regex.allMatches(rule.pattern);

    if (matches.isEmpty) {
      return Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark
              ? Colors.white.withValues(alpha: 0.03)
              : Colors.black.withValues(alpha: 0.02),
          borderRadius: BorderRadius.circular(AppTheme.radiusSm),
          border: Border(left: BorderSide(color: _levelColor, width: 4)),
        ),
        child: Text(
          rule.pattern,
          style: TextStyle(
            fontFamily: 'JetBrainsMono',
            fontWeight: FontWeight.w600,
            fontSize: 12,
            color: isDark ? const Color(0xFF8BAEE0) : const Color(0xFF4A6FA5),
          ),
        ),
      );
    }

    final tokens = <InlineSpan>[];
    var cursor = 0;

    for (final m in matches) {
      if (m.start > cursor) {
        tokens.add(TextSpan(
            text: rule.pattern.substring(cursor, m.start),
            style: TextStyle(
                fontSize: 12,
                color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)));
      }
      final chipText = m.group(1)!;
      tokens.add(WidgetSpan(
        alignment: PlaceholderAlignment.middle,
        child: GestureDetector(
          onTap: () => _showPatternChipInfo(chipText),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
            margin: const EdgeInsets.symmetric(horizontal: 2),
            decoration: BoxDecoration(
              color: _levelColor.withValues(alpha: 0.12),
              borderRadius: BorderRadius.circular(6),
              border: Border.all(
                  color: _levelColor.withValues(alpha: 0.25)),
            ),
            child: Text(
              chipText,
              style: TextStyle(
                fontFamily: 'JetBrainsMono',
                fontSize: 11,
                fontWeight: FontWeight.w700,
                color: _levelColor,
              ),
            ),
          ),
        ),
      ));
      cursor = m.end;
    }

    if (cursor < rule.pattern.length) {
      tokens.add(TextSpan(
          text: rule.pattern.substring(cursor),
          style: TextStyle(
              fontSize: 12,
              color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)));
    }

    return Container(
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        color: isDark
            ? Colors.white.withValues(alpha: 0.03)
            : Colors.black.withValues(alpha: 0.02),
        borderRadius: BorderRadius.circular(AppTheme.radiusSm),
        border: Border(left: BorderSide(color: _levelColor, width: 4)),
      ),
      child: RichText(
          text: TextSpan(children: tokens),
          textScaleFactor: MediaQuery.textScaleFactorOf(context)),
    ).animate().shakeX(duration: 400.ms);
  }

  void _showPatternChipInfo(String chip) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 32),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(chip,
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 24, fontWeight: FontWeight.w700,
                      color: _levelColor)),
              const SizedBox(height: 8),
              Text(
                'This is a grammatical element in the pattern: $chip',
                style: TextStyle(
                    fontSize: 14,
                    color: widget.isDark
                        ? AppTheme.mutedGrey
                        : AppTheme.warmGrey),
              ),
              const SizedBox(height: 16),
              FilledButton(
                onPressed: () => Navigator.pop(ctx),
                child: const Text('Got it'),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // ── Exemples tab ──────────────────────────────────────────────
  Widget _buildExemplesTab() {
    final isDark = widget.isDark;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Examples',
              style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppTheme.offWhite : AppTheme.ink)),
          const SizedBox(height: 10),
          ...rule.examples.map((ex) => Padding(
                padding: const EdgeInsets.only(bottom: 10),
                child: GestureDetector(
                  onTap: () async {
                    await TtsService.instance.speak(ex.french);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(12),
                    decoration: BoxDecoration(
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.03)
                          : Colors.black.withValues(alpha: 0.02),
                      borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(ex.french,
                                  style: TextStyle(
                                      fontWeight: FontWeight.w700,
                                      fontSize: 14,
                                      color: isDark
                                          ? AppTheme.offWhite
                                          : AppTheme.ink)),
                              const SizedBox(height: 2),
                              Text(ex.english,
                                  style: TextStyle(
                                      fontSize: 12,
                                      fontStyle: FontStyle.italic,
                                      color: isDark
                                          ? AppTheme.mutedGrey
                                          : AppTheme.warmGrey)),
                            ],
                          ),
                        ),
                        Icon(Icons.volume_up_rounded,
                            size: 18,
                            color: isDark
                                ? AppTheme.mutedGrey
                                : AppTheme.warmGrey),
                      ],
                    ),
                  ),
                ),
              )),
        ],
      ),
    );
  }

  // ── Tableaux tab ──────────────────────────────────────────────
  Widget _buildTableauxTab() {
    final isDark = widget.isDark;
    if (rule.tables == null || rule.tables!.isEmpty) {
      return Padding(
        padding: const EdgeInsets.all(16),
        child: Text('No tables available.',
            style: TextStyle(
                color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)),
      );
    }

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: rule.tables!.map((tbl) {
          return Padding(
            padding: const EdgeInsets.only(bottom: 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                if (tbl.title != null) ...[
                  Text(tbl.title!,
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppTheme.offWhite : AppTheme.ink)),
                  const SizedBox(height: 8),
                ],
                Container(
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isDark
                          ? AppTheme.darkBorder
                          : Colors.black.withValues(alpha: 0.08),
                    ),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  ),
                  clipBehavior: Clip.antiAlias,
                  child: Table(
                    border: TableBorder.symmetric(
                      inside: BorderSide(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.05)
                            : Colors.black.withValues(alpha: 0.05),
                      ),
                    ),
                    columnWidths: const {
                      0: FlexColumnWidth(1),
                      1: FlexColumnWidth(1.6),
                    },
                    children: [
                      // Header
                      TableRow(
                        decoration: BoxDecoration(
                          color: _levelColor.withValues(alpha: 0.07),
                        ),
                        children: tbl.headers.map((h) => Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 8),
                          child: Text(h,
                              style: TextStyle(
                                  fontSize: 12,
                                  fontWeight: FontWeight.w800,
                                  color: _levelColor)),
                        )).toList(),
                      ),
                      // Data rows
                      ...tbl.rows.asMap().entries.map((entry) {
                        return TableRow(
                          children: entry.value.map((cell) {
                            return Padding(
                              padding: const EdgeInsets.symmetric(
                                  horizontal: 10, vertical: 8),
                              child: Text(cell,
                                  style: TextStyle(
                                      fontSize: 12.5,
                                      color: isDark
                                          ? AppTheme.offWhite
                                          : AppTheme.ink)),
                            );
                          }).toList(),
                        );
                      }),
                    ],
                  ),
                ).animate().slideX(begin: -0.02, duration: 300.ms),
              ],
            ),
          );
        }).toList(),
      ),
    );
  }

  // ── Pièges (Traps) tab ────────────────────────────────────────
  Widget _buildPiegesTab() {
    final isDark = widget.isDark;
    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (rule.trap != null) ...[
            Container(
              padding: const EdgeInsets.all(14),
              decoration: BoxDecoration(
                color: AppTheme.verbCoral.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                border: Border.all(
                    color: AppTheme.verbCoral.withValues(alpha: 0.2)),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Icon(Icons.warning_amber_rounded,
                      color: AppTheme.verbCoral, size: 20),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Watch Out!',
                            style: TextStyle(
                                fontSize: 12,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.verbCoral)),
                        const SizedBox(height: 4),
                        Text(rule.trap!,
                            style: TextStyle(
                                fontSize: 12.5,
                                height: 1.5,
                                color: isDark
                                    ? const Color(0xFFFCA5A5)
                                    : const Color(0xFFB91C1C))),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
          if (rule.note != null && rule.note!.isNotEmpty) ...[
            const SizedBox(height: 12),
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('💡 ',
                    style: TextStyle(
                        fontSize: 13,
                        color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)),
                Expanded(
                  child: Text(rule.note!,
                      style: TextStyle(
                          fontSize: 12,
                          fontStyle: FontStyle.italic,
                          color: isDark
                              ? AppTheme.mutedGrey
                              : AppTheme.warmGrey)),
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  // ── Quiz tab ──────────────────────────────────────────────────
  Widget _buildQuizTab() {
    final isDark = widget.isDark;
    final questions = _generateQuiz();

    return Padding(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.quiz_rounded, size: 18, color: _levelColor),
              const SizedBox(width: 6),
              Text('Quick Quiz',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppTheme.offWhite : AppTheme.ink)),
            ],
          ),
          const SizedBox(height: 12),
          ...questions.asMap().entries.map((entry) {
            final qi = entry.key;
            final q = entry.value;
            final answered = _answered.contains(qi);

            return Padding(
              padding: const EdgeInsets.only(bottom: 12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('${qi + 1}. ${q.question}',
                      style: TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppTheme.offWhite : AppTheme.ink)),
                  const SizedBox(height: 6),
                  Wrap(
                    spacing: 6,
                    runSpacing: 6,
                    children: q.options.asMap().entries.map((optEntry) {
                      final oi = optEntry.key;
                      final opt = optEntry.value;
                      final isCorrect = oi == q.correctIndex;
                      Color? bg;
                      Color? fg;
                      if (answered) {
                        if (isCorrect) {
                          bg = AppTheme.sage.withValues(alpha: 0.2);
                          fg = AppTheme.sage;
                        } else {
                          bg = AppTheme.verbCoral.withValues(alpha: 0.1);
                          fg = AppTheme.verbCoral;
                        }
                      }
                      return GestureDetector(
                        onTap: answered
                            ? null
                            : () {
                                setState(() {
                                  _answered.add(qi);
                                  if (oi == q.correctIndex) {
                                    _showConfetti();
                                  }
                                });
                              },
                        child: Container(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 8),
                          decoration: BoxDecoration(
                            color: answered
                                ? (bg ?? (isDark
                                    ? Colors.white.withValues(alpha: 0.04)
                                    : Colors.black.withValues(alpha: 0.03)))
                                : (isDark
                                    ? Colors.white.withValues(alpha: 0.04)
                                    : Colors.black.withValues(alpha: 0.03)),
                            borderRadius:
                                BorderRadius.circular(AppTheme.radiusPill),
                            border: Border.all(
                              color: answered
                                  ? (fg ?? (isDark
                                      ? AppTheme.darkBorder
                                      : Colors.black.withValues(alpha: 0.08)))
                                  : (isDark
                                      ? Colors.white.withValues(alpha: 0.08)
                                      : Colors.black.withValues(alpha: 0.08)),
                            ),
                          ),
                          child: Text(opt,
                              style: TextStyle(
                                  fontSize: 12,
                                  color: answered
                                      ? (fg ?? (isDark
                                          ? AppTheme.offWhite
                                          : AppTheme.ink))
                                      : (isDark
                                          ? AppTheme.offWhite
                                          : AppTheme.ink))),
                        ),
                      );
                    }).toList(),
                  ),
                ],
              ),
            );
          }),
          if (_answered.length == questions.length) ...[
            const SizedBox(height: 8),
            Center(
              child: Text('✅ Quiz complete!',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: AppTheme.sage)),
            ),
          ],
        ],
      ),
    );
  }

  List<_QuizQuestion> _generateQuiz() {
    // Generate 3 simple questions from the rule content
    final questions = <_QuizQuestion>[];

    // Q1: What level is this rule?
    questions.add(_QuizQuestion(
      question: 'What level is "${rule.title}"?',
      options: ['A1', 'A2', 'B1'],
      correctIndex: rule.level == 'A1' ? 0 : 1,
    ));

    // Q2: True/False about the rule
    final words = rule.rule.split(' ');
    final tfStatement = words.length > 10
        ? '${words.take(6).join(' ')}...'
        : rule.rule;
    questions.add(_QuizQuestion(
      question: 'Does this rule say: "$tfStatement"?',
      options: ['Yes', 'No'],
      correctIndex: 0,
    ));

    // Q3: Pick a random example's language
    if (rule.examples.isNotEmpty) {
      final ex = rule.examples[0];
      questions.add(_QuizQuestion(
        question: 'What does "${ex.french}" mean?',
        options: [
          ex.english,
          'I don\'t know',
          'Something else',
        ],
        correctIndex: 0,
      ));
    } else {
      questions.add(_QuizQuestion(
        question: 'How many examples does this rule have?',
        options: ['0', '1', '2+'],
        correctIndex: 2,
      ));
    }

    return questions;
  }

  void _showConfetti() {
    HapticService.instance.correctPop();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.celebration_rounded, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Correct! 🎉'),
          ],
        ),
        backgroundColor: AppTheme.sage,
        duration: const Duration(milliseconds: 1200),
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(AppTheme.radiusPill)),
      ),
    );
  }
}

// ── Quiz question model ────────────────────────────────────────
class _QuizQuestion {
  final String question;
  final List<String> options;
  final int correctIndex;

  const _QuizQuestion({
    required this.question,
    required this.options,
    required this.correctIndex,
  });
}
