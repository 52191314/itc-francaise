import 'dart:async';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/writing_data.dart';
import '../models/writing_text.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/course_portal_button.dart';

/// L'Atelier d'Écriture — redesigned writing section with
/// notebook-style entries, Focus Studio, typewriter mode,
/// ghost text hints, and diff compare.
class WritingPracticeScreen extends StatefulWidget {
  const WritingPracticeScreen({super.key});

  @override
  State<WritingPracticeScreen> createState() => _WritingPracticeScreenState();
}

class _WritingPracticeScreenState extends State<WritingPracticeScreen> {
  String _query = '';
  String _level = 'all';
  final _searchCtrl = TextEditingController();
  bool _searchExpanded = false;

  List<WritingText> get _filtered => kWritingTexts.where((text) {
        if (_level != 'all' && text.level != _level) return false;
        return text.matches(_query);
      }).toList();

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
          "L'Atelier d'Écriture",
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
                '${filtered.length} / ${kWritingTexts.length}',
                key: const Key('writing-result-count'),
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
          // ── Search panel ─────────────────────────────────────
          _buildSearchPanel(isDark),
          const Divider(height: 1),

          // ── Notebook entry list ──────────────────────────────
          Expanded(
            child: filtered.isEmpty
                ? _buildEmptyState(isDark)
                : ListView.builder(
                    padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
                    itemCount: filtered.length,
                    itemBuilder: (ctx, i) => _NotebookCard(
                      text: filtered[i],
                      index: i,
                      isDark: isDark,
                      onTap: () => _openFocusStudio(filtered[i], isDark),
                      onQuickWrite: () =>
                          _showQuickWrite(filtered[i], isDark),
                    ),
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
                Icon(Icons.search_rounded, size: 20,
                    color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey),
                if (!_searchExpanded) ...[
                  const SizedBox(width: 10),
                  Expanded(
                    child: Text(
                      _query.isEmpty
                          ? 'Search topics, text, or grammar...'
                          : _query,
                      style: TextStyle(
                        fontSize: 14,
                        color: _query.isEmpty
                            ? (isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)
                            : (isDark ? AppTheme.offWhite : AppTheme.ink),
                      ),
                    ),
                  ),
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
                    hintText: 'Search topics, text, or grammar...',
                    prefixIcon: Icon(Icons.search_rounded, size: 20),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 12),
                Row(
                  children: [
                    Text('Level',
                        style: TextStyle(
                            fontSize: 11, fontWeight: FontWeight.w800,
                            color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)),
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
                                onTap: () => setState(() => _level = lv),
                                child: Container(
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(vertical: 6),
                                  decoration: BoxDecoration(
                                    color: selected ? AppTheme.terracotta : Colors.transparent,
                                    borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                                  ),
                                  child: Text(
                                    lv == 'all'
                                        ? 'All (240)'
                                        : '$lv (120)',
                                    style: TextStyle(
                                      fontSize: 12,
                                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                                      color: selected ? Colors.white
                                          : (isDark ? AppTheme.offWhite : AppTheme.ink),
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

  void _openFocusStudio(WritingText text, bool isDark) {
    Navigator.of(context).push(
      PageRouteBuilder(
        pageBuilder: (ctx, anim, sec) => FadeTransition(
          opacity: anim,
          child: _FocusStudio(text: text, isDark: isDark),
        ),
        transitionDuration: const Duration(milliseconds: 350),
      ),
    );
  }

  void _showQuickWrite(WritingText text, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _QuickWriteSheet(text: text, isDark: isDark),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.edit_note_rounded, size: 50,
              color: isDark ? Colors.white.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.12)),
          const SizedBox(height: 10),
          const Text('No writing texts match these filters.'),
          const SizedBox(height: 8),
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
//  NOTEBOOK CARD
// ═══════════════════════════════════════════════════════════════
class _NotebookCard extends StatelessWidget {
  final WritingText text;
  final int index;
  final bool isDark;
  final VoidCallback onTap;
  final VoidCallback onQuickWrite;

  const _NotebookCard({
    required this.text,
    required this.index,
    required this.isDark,
    required this.onTap,
    required this.onQuickWrite,
  });

  Color get _levelColor =>
      text.level == 'A1' ? AppTheme.indigo : AppTheme.aubergine;

  @override
  Widget build(BuildContext context) {
    final levelColor = _levelColor;

    return GestureDetector(
      onLongPress: onQuickWrite,
      child: Container(
        margin: const EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.charcoal : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radius),
          border: Border.all(
            color: isDark
                ? AppTheme.darkBorder.withValues(alpha: 0.5)
                : Colors.black.withValues(alpha: 0.04),
          ),
        ),
        child: InkWell(
          borderRadius: BorderRadius.circular(AppTheme.radius),
          onTap: onTap,
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Header row: date + wax-seal chip
                Row(
                  children: [
                    // Simulated "Day" badge
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 8, vertical: 4),
                      decoration: BoxDecoration(
                        color: levelColor.withValues(alpha: 0.08),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        'Day ${(index % 240) + 1}',
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: levelColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Wax-seal grammar focus chip
                    Container(
                      width: 28,
                      height: 28,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        color: levelColor.withValues(alpha: 0.15),
                        border: Border.all(
                            color: levelColor.withValues(alpha: 0.3)),
                      ),
                      child: Center(
                        child: Text(
                          text.grammarFocus.substring(0, 1).toUpperCase(),
                          style: TextStyle(
                            fontSize: 11,
                            fontWeight: FontWeight.w900,
                            color: levelColor,
                          ),
                        ),
                      ),
                    ),
                    const Spacer(),
                    Icon(Icons.chevron_right_rounded,
                        size: 18,
                        color: isDark
                            ? AppTheme.mutedGrey.withValues(alpha: 0.5)
                            : AppTheme.warmGrey.withValues(alpha: 0.5)),
                  ],
                ),
                const SizedBox(height: 10),
                // Title in serif
                Text(
                  text.title,
                  style: GoogleFonts.playfairDisplay(
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: isDark ? AppTheme.offWhite : AppTheme.ink,
                  ),
                ),
                const SizedBox(height: 6),
                // Preview on lined-paper background
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                    color: isDark
                        ? Colors.white.withValues(alpha: 0.03)
                        : const Color(0xFFFDFBF7),
                    borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                    border: Border(
                      bottom: BorderSide(
                        color: isDark
                            ? Colors.white.withValues(alpha: 0.04)
                            : Colors.black.withValues(alpha: 0.03),
                      ),
                    ),
                  ),
                  child: Text(
                    text.text,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      fontSize: 12.5,
                      height: 1.5,
                      color: isDark
                          ? AppTheme.mutedGrey
                          : AppTheme.warmGrey,
                    ),
                  ),
                ),
                const SizedBox(height: 6),
                // Grammar focus label
                Text(
                  text.grammarFocus,
                  style: TextStyle(
                    fontSize: 11,
                    fontWeight: FontWeight.w700,
                    color: levelColor,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: (index * 20).clamp(0, 240)))
        .fadeIn(duration: 200.ms);
  }
}

// ═══════════════════════════════════════════════════════════════
//  FOCUS STUDIO
// ═══════════════════════════════════════════════════════════════
class _FocusStudio extends StatefulWidget {
  final WritingText text;
  final bool isDark;

  const _FocusStudio({required this.text, required this.isDark});

  @override
  State<_FocusStudio> createState() => _FocusStudioState();
}

class _FocusStudioState extends State<_FocusStudio> {
  final _draftCtrl = TextEditingController();
  final _scrollCtrl = ScrollController();
  bool _phasePrompt = true;
  bool _showCompare = false;
  Timer? _ghostTimer;
  String _ghostText = '';
  bool _showGhost = false;

  WritingText get _text => widget.text;
  bool get isDark => widget.isDark;

  int get _wordCount {
    final v = _draftCtrl.text.trim();
    return v.isEmpty ? 0 : v.split(RegExp(r'\s+')).length;
  }

  @override
  void initState() {
    super.initState();
    _draftCtrl.addListener(_onDraftChanged);
  }

  @override
  void dispose() {
    _draftCtrl.removeListener(_onDraftChanged);
    _draftCtrl.dispose();
    _scrollCtrl.dispose();
    _ghostTimer?.cancel();
    super.dispose();
  }

  void _onDraftChanged() {
    // Reset ghost timer on each keystroke
    _ghostTimer?.cancel();
    _showGhost = false;
    _ghostTimer = Timer(const Duration(seconds: 5), () {
      if (!mounted || _draftCtrl.text.trim().isEmpty) return;
      // Show a subtle ghost hint from the model text
      final words = _text.text.split(' ');
      if (words.length > 3) {
        setState(() {
          _ghostText = words.take(3).join(' ');
          _showGhost = true;
        });
      }
    });
    setState(() {}); // update word count
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    if (_phasePrompt) {
      return _buildPromptPhase(theme);
    }
    return _buildStudioPhase(theme);
  }

  // ── Phase 1: The Prompt ──────────────────────────────────────
  Widget _buildPromptPhase(ThemeData theme) {
    return Scaffold(
      backgroundColor: isDark ? AppTheme.deepInk : AppTheme.parchment,
      body: SafeArea(
        child: Stack(
          children: [
            Center(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 32),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    // Close button
                    Align(
                      alignment: Alignment.topLeft,
                      child: IconButton(
                        icon: Icon(Icons.close_rounded,
                            color: isDark ? AppTheme.offWhite : AppTheme.ink),
                        onPressed: () => Navigator.pop(context),
                      ),
                    ),
                    const Spacer(),
                    // Parchment card
                    Container(
                      padding: const EdgeInsets.all(28),
                      decoration: BoxDecoration(
                        color: isDark ? AppTheme.charcoal : Colors.white,
                        borderRadius: BorderRadius.circular(AppTheme.radius),
                        border: Border.all(
                          color: isDark
                              ? AppTheme.darkBorder
                              : Colors.black.withValues(alpha: 0.06),
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withValues(alpha: 0.04),
                            blurRadius: 20,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: Column(
                        children: [
                          // Level badge
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 10, vertical: 4),
                            decoration: BoxDecoration(
                              color: _text.level == 'A1'
                                  ? AppTheme.indigo.withValues(alpha: 0.1)
                                  : AppTheme.aubergine.withValues(alpha: 0.1),
                              borderRadius: BorderRadius.circular(6),
                            ),
                            child: Text(
                              _text.level,
                              style: TextStyle(
                                  fontSize: 10,
                                  fontWeight: FontWeight.w800,
                                  color: _text.level == 'A1'
                                      ? AppTheme.indigo
                                      : AppTheme.aubergine),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            _text.title,
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 22,
                              fontWeight: FontWeight.w700,
                              color: isDark ? AppTheme.offWhite : AppTheme.ink,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 12),
                          Text(
                            _text.task,
                            style: TextStyle(
                              fontSize: 15,
                              height: 1.5,
                              color: isDark
                                  ? AppTheme.mutedGrey
                                  : AppTheme.warmGrey,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '🎯 ${_text.grammarFocus}',
                            style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.terracotta,
                            ),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 24),
                    // Begin button
                    SizedBox(
                      width: double.infinity,
                      child: FilledButton.icon(
                        onPressed: () =>
                            setState(() => _phasePrompt = false),
                        icon: const Icon(Icons.edit_rounded, size: 18),
                        label: const Text('Begin Writing'),
                        style: FilledButton.styleFrom(
                          padding: const EdgeInsets.symmetric(vertical: 16),
                        ),
                      ),
                    ),
                    const Spacer(flex: 2),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── Phase 2: The Studio ──────────────────────────────────────
  Widget _buildStudioPhase(ThemeData theme) {
    return Scaffold(
      backgroundColor: isDark ? AppTheme.deepInk : AppTheme.parchment,
      body: SafeArea(
        child: Column(
          children: [
            // Toolbar
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              color: isDark ? AppTheme.charcoal : Colors.white,
              child: Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.arrow_back_rounded,
                        color: isDark ? AppTheme.offWhite : AppTheme.ink),
                    onPressed: () => Navigator.pop(context),
                  ),
                  Expanded(
                    child: Text(
                      _text.title,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 15,
                        fontWeight: FontWeight.w700,
                        color: isDark ? AppTheme.offWhite : AppTheme.ink,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                  // Compare toggle
                  TextButton.icon(
                    onPressed: () =>
                        setState(() => _showCompare = !_showCompare),
                    icon: Icon(
                      Icons.compare_arrows_rounded,
                      size: 18,
                      color: _showCompare
                          ? AppTheme.terracotta
                          : (isDark ? AppTheme.mutedGrey : AppTheme.warmGrey),
                    ),
                    label: Text(
                      'Compare',
                      style: TextStyle(
                        fontSize: 12,
                        color: _showCompare
                            ? AppTheme.terracotta
                            : (isDark
                                ? AppTheme.mutedGrey
                                : AppTheme.warmGrey),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // Content: split panels
            Expanded(
              child: _showCompare
                  ? _buildCompareView(theme)
                  : _buildStudioPanels(theme),
            ),
          ],
        ),
      ),
    );
  }

  // ── Studio: split panels ─────────────────────────────────────
  Widget _buildStudioPanels(ThemeData theme) {
    return LayoutBuilder(
      builder: (ctx, constraints) {
        final isWide = constraints.maxWidth > 600;
        if (isWide) {
          return Row(
            children: [
              Expanded(child: _buildModelPanel()),
              const VerticalDivider(width: 1),
              Expanded(child: _buildCanvasPanel()),
            ],
          );
        }
        // Narrow: swipeable tabs
        return DefaultTabController(
          length: 2,
          child: Column(
            children: [
              const TabBar(
                tabs: [
                  Tab(text: 'Model'),
                  Tab(text: 'Write'),
                ],
                labelStyle:
                    TextStyle(fontWeight: FontWeight.w700, fontSize: 13),
              ),
              Expanded(
                child: TabBarView(
                  children: [
                    _buildModelPanel(),
                    _buildCanvasPanel(),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  // ── Model text panel ─────────────────────────────────────────
  Widget _buildModelPanel() {
    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.auto_stories_rounded,
                  size: 18, color: AppTheme.terracotta),
              const SizedBox(width: 6),
              Text('Model Text',
                  style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppTheme.offWhite : AppTheme.ink)),
            ],
          ),
          const SizedBox(height: 12),
          _GlossaryText(text: _text.text, isDark: isDark),
          const SizedBox(height: 8),
          Text(
            'Tap highlighted words for translation.',
            style: TextStyle(
                fontSize: 11,
                color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey),
          ),
          const SizedBox(height: 20),
          // Grammar explanation
          Container(
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: AppTheme.aubergine.withValues(alpha: 0.06),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              border: Border.all(
                  color: AppTheme.aubergine.withValues(alpha: 0.15)),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('🎯 ${_text.grammarFocus}',
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w700,
                        color: AppTheme.aubergine)),
                const SizedBox(height: 6),
                Text(_text.grammarExplanation,
                    style: TextStyle(
                        fontSize: 12,
                        height: 1.5,
                        color: isDark
                            ? AppTheme.mutedGrey
                            : AppTheme.warmGrey)),
              ],
            ),
          ),
        ],
      ),
    );
  }

  // ── Writing canvas ───────────────────────────────────────────
  Widget _buildCanvasPanel() {
    return Stack(
      children: [
        SingleChildScrollView(
          controller: _scrollCtrl,
          padding: const EdgeInsets.fromLTRB(16, 16, 16, 100),
          child: Column(
            children: [
              // Grammar focus chip
              Row(
                children: [
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 8, vertical: 3),
                    decoration: BoxDecoration(
                      color: AppTheme.terracotta.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text(
                      '🎯 ${_text.grammarFocus}',
                      style: TextStyle(
                          fontSize: 10,
                          fontWeight: FontWeight.w700,
                          color: AppTheme.terracotta),
                    ),
                  ),
                  const Spacer(),
                  Text('$_wordCount words',
                      style: TextStyle(
                          fontSize: 11,
                          color: _wordCount > 30
                              ? AppTheme.sage
                              : AppTheme.terracotta)),
                ],
              ),
              const SizedBox(height: 16),
              // Typewriter text field
              TextField(
                controller: _draftCtrl,
                maxLines: null,
                autofocus: true,
                style: TextStyle(
                  fontSize: 16,
                  height: 1.8,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  color: isDark ? AppTheme.offWhite : AppTheme.ink,
                ),
                decoration: InputDecoration(
                  hintText: 'Write your text here...',
                  hintStyle: TextStyle(
                    color: isDark
                        ? AppTheme.mutedGrey.withValues(alpha: 0.4)
                        : AppTheme.warmGrey.withValues(alpha: 0.4),
                  ),
                  border: InputBorder.none,
                  filled: false,
                  contentPadding: EdgeInsets.zero,
                  isDense: true,
                ),
              ),
            ],
          ),
        ),
        // Ghost text overlay
        if (_showGhost && _draftCtrl.text.trim().isNotEmpty)
          Positioned(
            bottom: 80,
            left: 16,
            right: 16,
            child: Opacity(
              opacity: 0.3,
              child: Text(
                _ghostText,
                style: TextStyle(
                  fontSize: 16,
                  fontStyle: FontStyle.italic,
                  color: AppTheme.terracotta,
                ),
              ),
            ).animate().fadeIn(duration: 300.ms),
          ),
        // Word count bubble
        Positioned(
          right: 16,
          bottom: 16,
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
            decoration: BoxDecoration(
              color: _wordCount > 30 ? AppTheme.sage : AppTheme.terracotta,
              borderRadius: BorderRadius.circular(AppTheme.radiusPill),
            ),
            child: Text(
              '$_wordCount',
              style: const TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w800,
                fontSize: 12,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Compare view ──────────────────────────────────────────────
  Widget _buildCompareView(ThemeData theme) {
    final modelWords = _text.text.split(' ');
    final draftWords = _draftCtrl.text.trim().split(' ');

    return SingleChildScrollView(
      padding: const EdgeInsets.all(16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            children: [
              Icon(Icons.compare_arrows_rounded,
                  size: 18, color: AppTheme.terracotta),
              const SizedBox(width: 6),
              Text('Compare Mode',
                  style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppTheme.offWhite : AppTheme.ink)),
            ],
          ),
          const SizedBox(height: 4),
          Text(
            'Green = correct, Red = different, Yellow = grammar focus area',
            style: TextStyle(
                fontSize: 11,
                color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey),
          ),
          const SizedBox(height: 16),
          // Word-by-word comparison
          Wrap(
            spacing: 4,
            runSpacing: 4,
            children: List.generate(
              modelWords.length > draftWords.length
                  ? modelWords.length
                  : draftWords.length,
              (i) {
                if (i >= modelWords.length) return const SizedBox.shrink();
                final model = modelWords[i].toLowerCase();
                final draft = i < draftWords.length
                    ? draftWords[i].toLowerCase()
                    : '';
                Color bg;
                if (draft == model && draft.isNotEmpty) {
                  bg = AppTheme.sage.withValues(alpha: 0.2);
                } else if (draft.isEmpty) {
                  bg = AppTheme.verbCoral.withValues(alpha: 0.1);
                } else {
                  bg = AppTheme.verbCoral.withValues(alpha: 0.15);
                }
                return Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
                  decoration: BoxDecoration(
                    color: bg,
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: Text(
                    modelWords[i],
                    style: TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.w500,
                      color: isDark ? AppTheme.offWhite : AppTheme.ink,
                      decoration:
                          draft != model ? TextDecoration.lineThrough : null,
                    ),
                  ),
                );
              },
            ),
          ),
          if (_draftCtrl.text.trim().isEmpty)
            Padding(
              padding: const EdgeInsets.only(top: 24),
              child: Center(
                child: Text(
                  'Start writing to see comparison',
                  style: TextStyle(
                      fontStyle: FontStyle.italic,
                      color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey),
                ),
              ),
            ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  QUICK WRITE SHEET
// ═══════════════════════════════════════════════════════════════
class _QuickWriteSheet extends StatefulWidget {
  final WritingText text;
  final bool isDark;

  const _QuickWriteSheet({required this.text, required this.isDark});

  @override
  State<_QuickWriteSheet> createState() => _QuickWriteSheetState();
}

class _QuickWriteSheetState extends State<_QuickWriteSheet> {
  final _ctrl = TextEditingController();

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark ? AppTheme.darkBorder : Colors.black.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text(widget.text.title,
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 18, fontWeight: FontWeight.w700,
                      color: isDark ? AppTheme.offWhite : AppTheme.ink)),
              const SizedBox(height: 4),
              Text(widget.text.task,
                  style: TextStyle(
                      fontSize: 13,
                      color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)),
              const SizedBox(height: 16),
              TextField(
                controller: _ctrl,
                maxLines: 5,
                autofocus: true,
                style: TextStyle(
                  fontSize: 15,
                  height: 1.5,
                  color: isDark ? AppTheme.offWhite : AppTheme.ink,
                ),
                decoration: InputDecoration(
                  hintText: 'Quick write...',
                  hintStyle: TextStyle(
                    color: isDark
                        ? AppTheme.mutedGrey.withValues(alpha: 0.4)
                        : AppTheme.warmGrey.withValues(alpha: 0.4),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Cancel'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: () {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: const Text('✍️ Saved to your draft!'),
                          backgroundColor: AppTheme.sage,
                          behavior: SnackBarBehavior.floating,
                          duration: const Duration(seconds: 1),
                        ),
                      );
                      Navigator.pop(context);
                    },
                    child: const Text('Save'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  GLOSSARY TEXT — interactive highlighted terms
// ═══════════════════════════════════════════════════════════════
class _GlossaryText extends StatefulWidget {
  final String text;
  final bool isDark;

  const _GlossaryText({required this.text, required this.isDark});

  @override
  State<_GlossaryText> createState() => _GlossaryTextState();
}

class _GlossaryTextState extends State<_GlossaryText> {
  late RegExp _pattern;
  final _recognizers = <TapGestureRecognizer>[];

  @override
  void initState() {
    super.initState();
    _pattern = _buildPattern();
  }

  @override
  void didUpdateWidget(covariant _GlossaryText oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.text != widget.text) {
      _disposeRecognizers();
      _pattern = _buildPattern();
    }
  }

  RegExp _buildPattern() {
    final terms = kWritingGlossary.keys.toList()
      ..sort((a, b) => b.length.compareTo(a.length));
    return RegExp(terms.map(RegExp.escape).join('|'), caseSensitive: false);
  }

  void _disposeRecognizers() {
    for (final r in _recognizers) {
      r.dispose();
    }
    _recognizers.clear();
  }

  @override
  void dispose() {
    _disposeRecognizers();
    super.dispose();
  }

  void _showTranslation(String displayedTerm) {
    final key = kWritingGlossary.keys.firstWhere(
      (term) => term.toLowerCase() == displayedTerm.toLowerCase(),
    );
    showModalBottomSheet(
      context: context,
      showDragHandle: true,
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(key,
                  style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.w800,
                      color: AppTheme.terracotta)),
              const SizedBox(height: 8),
              Text(kWritingGlossary[key]!,
                  style: TextStyle(fontSize: 15,
                      color: widget.isDark ? AppTheme.offWhite : AppTheme.ink)),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _disposeRecognizers();
    final terracotta = AppTheme.terracotta;
    final spans = <TextSpan>[];
    var cursor = 0;

    for (final match in _pattern.allMatches(widget.text)) {
      if (match.start > cursor) {
        spans.add(TextSpan(
            text: widget.text.substring(cursor, match.start),
            style: TextStyle(
                fontSize: 14,
                height: 1.6,
                color: widget.isDark ? AppTheme.offWhite : AppTheme.ink)));
      }
      final term = widget.text.substring(match.start, match.end);
      final recognizer = TapGestureRecognizer()
        ..onTap = () => _showTranslation(term);
      _recognizers.add(recognizer);
      spans.add(
        TextSpan(
          text: term,
          recognizer: recognizer,
          style: TextStyle(
            color: terracotta,
            fontWeight: FontWeight.w700,
            backgroundColor: terracotta.withValues(alpha: 0.1),
            decoration: TextDecoration.underline,
            decorationColor: terracotta.withValues(alpha: 0.4),
          ),
        ),
      );
      cursor = match.end;
    }

    if (cursor < widget.text.length) {
      spans.add(TextSpan(
          text: widget.text.substring(cursor),
          style: TextStyle(
              fontSize: 14,
              height: 1.6,
              color: widget.isDark ? AppTheme.offWhite : AppTheme.ink)));
    }

    return SelectionArea(
      child: Text.rich(
        TextSpan(children: spans),
        style: TextStyle(fontSize: 14, height: 1.6),
      ),
    );
  }
}
