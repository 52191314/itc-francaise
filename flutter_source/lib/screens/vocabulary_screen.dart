import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../data/vocab_data.dart';
import '../models/filter_state.dart';
import '../models/word.dart';
import '../providers/journal_provider.dart';
import '../services/haptic_service.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../widgets/conj_bottom_sheet.dart';
import '../widgets/course_portal_button.dart';
import '../widgets/filter_bar.dart';
import '../widgets/filter_overlay.dart'
    show FilterScreen; // only the FilterScreen class

/// Le Lexique — dictionary with new Atelier filter system.
class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  String _query = '';
  double _ttsSpeed = 0.85;
  final _searchCtrl = TextEditingController();
  bool _isDeckMode = false;
  bool _searchExpanded = false;

  // New filter state
  final FilterState _filter = FilterState();

  List<Word> get _filtered {
    final journal = context.read<JournalProvider>();
    return _filter.apply(kVocab, isInJournal: (word) => journal.contains(word));
  }

  void _openFilter() async {
    final changed = await Navigator.of(context).push<bool>(
      MaterialPageRoute(
        builder: (_) => FilterScreen(
          filter: _filter,
          isDark: Theme.of(context).brightness == Brightness.dark,
          totalCount: kVocab.length,
          filteredCount: _filtered.length,
        ),
      ),
    );
    if (changed == true) setState(() {});
  }

  void _toggleJournal(Word w) {
    final inJournal = context.read<JournalProvider>().contains(w.fr);
    context.read<JournalProvider>().toggle(w.fr, w.en, w.type, w.level);
    if (!inJournal) {
      HapticService.instance.journalThud();
    }
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
    TtsService.instance.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final filtered = _filtered;
    final journal = context.watch<JournalProvider>();

    return Scaffold(
      appBar: AppBar(
        title: Text(
          _isDeckMode ? 'Deck Mode' : 'Le Lexique',
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? AppTheme.offWhite : AppTheme.ink,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(
              _isDeckMode ? Icons.list_rounded : Icons.style_rounded,
              color: isDark ? AppTheme.offWhite : AppTheme.ink,
            ),
            onPressed: () => setState(() => _isDeckMode = !_isDeckMode),
            tooltip: _isDeckMode ? 'List mode' : 'Deck mode',
          ),
          IconButton(
            icon: Icon(Icons.menu_rounded,
                color: isDark ? AppTheme.offWhite : AppTheme.ink),
            onPressed: () => ShellMenuNotifier.open(context),
          ),
          const CoursePortalButton(),
          if (!_isDeckMode)
            Padding(
              padding: const EdgeInsets.only(right: 8),
              child: Center(
                child: Text(
                  '${filtered.length} / ${kVocab.length}',
                  style: theme.textTheme.bodySmall?.copyWith(
                    color: theme.colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
        ],
      ),
      body: _isDeckMode
          ? _buildDeckMode(theme, isDark)
          : _buildListMode(theme, isDark, filtered, journal),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  //  LIST MODE
  // ═══════════════════════════════════════════════════════════════
  Widget _buildListMode(ThemeData theme, bool isDark, List<Word> filtered,
      JournalProvider journal) {
    return Column(
      children: [
        // ── Floating search pill ─────────────────────────────────
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
              boxShadow: _searchExpanded
                  ? [
                      BoxShadow(
                        color: Colors.black.withValues(alpha: 0.08),
                        blurRadius: 16,
                        offset: const Offset(0, 4),
                      ),
                    ]
                  : null,
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
                          ? 'Search French or English...'
                          : _query,
                      style: TextStyle(
                        fontSize: 14,
                        color: _query.isEmpty
                            ? (isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)
                            : (isDark ? AppTheme.offWhite : AppTheme.ink),
                      ),
                    ),
                  ),
                  GestureDetector(
                    onLongPressStart: (_) => _showTtsSpeedSelector(context),
                    child: Padding(
                      padding: const EdgeInsets.all(8),
                      child: Icon(
                        Icons.volume_up_rounded,
                        size: 20,
                        color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
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

        // ── Search expanded panel ────────────────────────────────
        if (_searchExpanded)
          _buildSearchPanel(isDark),

        // ── Filter bar ───────────────────────────────────────────
        FilterBar(
          filter: _filter,
          isDark: isDark,
          totalCount: kVocab.length,
          filteredCount: filtered.length,
          onTap: _openFilter,
        ),

        // ── Word list ────────────────────────────────────────────
        Expanded(
          child: filtered.isEmpty
              ? _buildEmptyState(isDark)
              : ListView.builder(
                  padding: const EdgeInsets.fromLTRB(16, 8, 16, 80),
                  itemCount: filtered.length,
                  itemBuilder: (ctx, i) {
                    final word = filtered[i];
                    final inJournal = journal.contains(word.fr);
                    return _LexiqueTile(
                      word: word,
                      index: i,
                      query: _query,
                      ttsSpeed: _ttsSpeed,
                      inJournal: inJournal,
                      isDark: isDark,
                      onAddToJournal: () => _toggleJournal(word),
                      onListen: () => _speak(word),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // ── Search expanded panel ──────────────────────────────────────
  Widget _buildSearchPanel(bool isDark) {
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 0),
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: isDark ? const Color(0xFF14161C) : Colors.white,
        borderRadius:
            const BorderRadius.vertical(bottom: Radius.circular(AppTheme.radiusSm)),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withValues(alpha: 0.06),
            blurRadius: 12,
          ),
        ],
      ),
      child: Column(
        children: [
          TextField(
            controller: _searchCtrl,
            autofocus: true,
            onChanged: (v) {
              setState(() => _query = v);
              _filter.query = v;
            },
            decoration: InputDecoration(
              hintText: 'Search French or English...',
              prefixIcon: const Icon(Icons.search_rounded, size: 20),
              suffixIcon: _query.isNotEmpty
                  ? IconButton(
                      icon: const Icon(Icons.clear_rounded, size: 18),
                      onPressed: () {
                        _searchCtrl.clear();
                        setState(() {
                          _query = '';
                          _filter.query = '';
                        });
                      },
                    )
                  : null,
              isDense: true,
              contentPadding:
                  const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
            ),
          ),
          const SizedBox(height: 8),
          // Search scope hint
          Row(
            children: [
              Icon(Icons.search_rounded,
                  size: 12,
                  color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey),
              const SizedBox(width: 4),
              Text(
                'Searching: ${_scopeLabel(_filter.searchScope)}',
                style: TextStyle(
                  fontSize: 11,
                  fontStyle: FontStyle.italic,
                  color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  String _scopeLabel(String scope) {
    switch (scope) {
      case 'french': return 'French only';
      case 'english': return 'English only';
      case 'example': return 'Examples only';
      default: return 'All fields';
    }
  }

  // ═══════════════════════════════════════════════════════════════
  //  EMPTY STATE
  // ═══════════════════════════════════════════════════════════════
  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Open empty book illustration
          Container(
            width: 80,
            height: 80,
            decoration: BoxDecoration(
              color: isDark
                  ? Colors.white.withValues(alpha: 0.04)
                  : Colors.black.withValues(alpha: 0.03),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Icon(
              Icons.menu_book_rounded,
              size: 40,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.12),
            ),
          ),
          const SizedBox(height: 16),
          Text(
            'Aucun mot ne correspond',
            style: GoogleFonts.playfairDisplay(
              fontSize: 18,
              fontWeight: FontWeight.w700,
              color: isDark ? AppTheme.offWhite : AppTheme.ink,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Try adjusting your filters or search terms.',
            style: TextStyle(
              fontSize: 13,
              color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
            ),
          ),
          const SizedBox(height: 16),
          OutlinedButton.icon(
            onPressed: () {
              _filter.reset();
              _searchCtrl.clear();
              setState(() => _query = '');
            },
            icon: const Icon(Icons.refresh_rounded, size: 18),
            label: const Text('Réinitialiser les filtres'),
          ),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  //  DECK MODE
  // ═══════════════════════════════════════════════════════════════
  Widget _buildDeckMode(ThemeData theme, bool isDark) {
    final filtered = _filtered;
    if (filtered.isEmpty) return _buildEmptyState(isDark);

    return _DeckView(
      words: filtered,
      ttsSpeed: _ttsSpeed,
      isDark: isDark,
    );
  }

  void _speak(Word word) async {
    await TtsService.instance.setRate(_ttsSpeed);
    await TtsService.instance.speak(word.fr);
  }

  void _showTtsSpeedSelector(BuildContext context) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) {
        return StatefulBuilder(
          builder: (ctx, setSheetState) => Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 32),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text('Speech Speed',
                    style: GoogleFonts.playfairDisplay(
                        fontSize: 18, fontWeight: FontWeight.w700)),
                const SizedBox(height: 16),
                Row(
                  children: [
                    const Text('🐢'),
                    Expanded(
                      child: Slider(
                        value: _ttsSpeed,
                        min: 0.4,
                        max: 1.2,
                        divisions: 16,
                        label: '${_ttsSpeed.toStringAsFixed(2)}x',
                        onChanged: (v) {
                          setState(() => _ttsSpeed = v);
                          setSheetState(() {});
                        },
                      ),
                    ),
                    const Text('🐇'),
                  ],
                ),
                Text('${_ttsSpeed.toStringAsFixed(2)}x',
                    style: const TextStyle(
                        fontWeight: FontWeight.w800, fontSize: 16)),
                const SizedBox(height: 8),
                TextButton(
                  onPressed: () => Navigator.of(ctx).pop(),
                  child: const Text('Done'),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  LEXIQUE TILE
// ═══════════════════════════════════════════════════════════════
class _LexiqueTile extends StatelessWidget {
  final Word word;
  final int index;
  final String query;
  final double ttsSpeed;
  final bool inJournal;
  final bool isDark;
  final VoidCallback onAddToJournal;
  final VoidCallback onListen;

  const _LexiqueTile({
    required this.word,
    required this.index,
    required this.query,
    required this.ttsSpeed,
    required this.inJournal,
    required this.isDark,
    required this.onAddToJournal,
    required this.onListen,
  });

  Color get _color => switch (word.type) {
        'verb' => AppTheme.verbCoral,
        'noun' => AppTheme.nounOchre,
        'adjective' => AppTheme.aubergine,
        'adverb' => AppTheme.indigo,
        _ => AppTheme.terracotta,
      };

  @override
  Widget build(BuildContext context) {
    final color = _color;
    final terracotta = isDark ? AppTheme.warmCoral : AppTheme.terracotta;

    return Dismissible(
      key: ValueKey('word-${word.fr}-$index'),
      background: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 24),
        decoration: BoxDecoration(
          color: inJournal
              ? AppTheme.sage.withValues(alpha: 0.2)
              : terracotta.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppTheme.radius),
        ),
        child: Icon(
          inJournal
              ? Icons.bookmark_remove_rounded
              : Icons.bookmark_add_rounded,
          color: inJournal ? AppTheme.sage : terracotta,
        ),
      ),
      secondaryBackground: Container(
        alignment: Alignment.centerRight,
        padding: const EdgeInsets.only(right: 24),
        decoration: BoxDecoration(
          color: terracotta.withValues(alpha: 0.15),
          borderRadius: BorderRadius.circular(AppTheme.radius),
        ),
        child: Icon(Icons.volume_up_rounded, color: terracotta),
      ),
      confirmDismiss: (direction) async {
        if (direction == DismissDirection.startToEnd) {
          onAddToJournal();
          return false;
        } else {
          onListen();
          return false;
        }
      },
      child: MouseRegion(
        cursor: SystemMouseCursors.click,
        child: GestureDetector(
          onTap: () {
            if (word.isVerb) {
              showConjBottomSheet(context, word, ttsSpeed);
            } else {
              _showContextMenu(context, terracotta);
            }
          },
          onLongPress: () => _showContextMenu(context, terracotta),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 200),
            margin: const EdgeInsets.only(bottom: 8),
            padding: const EdgeInsets.all(14),
            decoration: BoxDecoration(
              color: isDark ? AppTheme.charcoal : Colors.white,
              borderRadius: BorderRadius.circular(AppTheme.radius),
              border: Border.all(
                color: inJournal
                    ? AppTheme.sage.withValues(alpha: 0.25)
                    : (isDark
                        ? AppTheme.darkBorder.withValues(alpha: 0.5)
                        : Colors.black.withValues(alpha: 0.04)),
              ),
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                // Type badge
                GestureDetector(
                  onTap: word.isVerb
                      ? () => showConjBottomSheet(context, word, ttsSpeed)
                      : null,
                  child: Container(
                    width: 38,
                    height: 38,
                    decoration: BoxDecoration(
                      color: color.withValues(alpha: word.isVerb ? 0.15 : 0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: word.isVerb
                        ? Icon(Icons.loop_rounded, color: color, size: 18)
                        : Center(
                            child: Text(
                              word.type.substring(0, 1).toUpperCase(),
                              style: TextStyle(
                                  color: color,
                                  fontWeight: FontWeight.w800,
                                  fontSize: 14),
                            ),
                          ),
                  ),
                ),
                const SizedBox(width: 14),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Flexible(
                            child: Text(
                              word.fr,
                              style: GoogleFonts.playfairDisplay(
                                fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: isDark ? AppTheme.offWhite : AppTheme.ink,
                                letterSpacing: 0.3,
                              ),
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                          if (inJournal) ...[
                            const SizedBox(width: 4),
                            Icon(Icons.bookmark_rounded,
                                size: 14, color: AppTheme.sage),
                          ],
                        ],
                      ),
                      const SizedBox(height: 2),
                      Text(
                        word.en,
                        style: TextStyle(
                          fontSize: 13,
                          color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
                        ),
                      ),
                      if (word.example.isNotEmpty) ...[
                        const SizedBox(height: 4),
                        Text(
                          word.example,
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                          style: TextStyle(
                            fontSize: 12,
                            fontStyle: FontStyle.italic,
                            color: isDark
                                ? AppTheme.mutedGrey.withValues(alpha: 0.7)
                                : AppTheme.warmGrey.withValues(alpha: 0.7),
                          ),
                        ),
                      ],
                    ],
                  ),
                ),
                if (word.isVerb) ...[
                  const SizedBox(width: 6),
                  Tooltip(
                    message: 'Voir la conjugaison',
                    child: InkWell(
                      onTap: () =>
                          showConjBottomSheet(context, word, ttsSpeed),
                      borderRadius: BorderRadius.circular(6),
                      child: Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 4),
                        decoration: BoxDecoration(
                          color: AppTheme.verbCoral.withValues(alpha: 0.12),
                          borderRadius: BorderRadius.circular(6),
                          border: Border.all(
                            color: AppTheme.verbCoral.withValues(alpha: 0.35),
                          ),
                        ),
                        child: const Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(Icons.table_chart_rounded,
                                size: 12, color: AppTheme.verbCoral),
                            SizedBox(width: 4),
                            Text(
                              'Conjugaison',
                              style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: AppTheme.verbCoral,
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
                const SizedBox(width: 8),
                // Level pill
                Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
                  decoration: BoxDecoration(
                    color: word.level == 'A1'
                        ? AppTheme.indigo.withValues(alpha: 0.12)
                        : AppTheme.aubergine.withValues(alpha: 0.12),
                    borderRadius: BorderRadius.circular(6),
                  ),
                  child: Text(
                    word.level,
                    style: TextStyle(
                      fontSize: 10,
                      fontWeight: FontWeight.w800,
                      color: word.level == 'A1'
                          ? AppTheme.indigo
                          : AppTheme.aubergine,
                    ),
                  ),
                ),
                const SizedBox(width: 6),
                // TTS button
                GestureDetector(
                  onTap: () async {
                    await TtsService.instance.setRate(ttsSpeed);
                    await TtsService.instance.speak(word.fr);
                  },
                  child: Container(
                    width: 32,
                    height: 32,
                    decoration: BoxDecoration(
                      color: terracotta.withValues(alpha: 0.08),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Icon(Icons.waves,
                        size: 18, color: terracotta.withValues(alpha: 0.6)),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void _showContextMenu(BuildContext context, Color terracotta) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(8, 8, 8, 16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Padding(
                padding: const EdgeInsets.all(16),
                child: Column(
                  children: [
                    Text(word.fr,
                        style: GoogleFonts.playfairDisplay(
                            fontSize: 22, fontWeight: FontWeight.w700)),
                    const SizedBox(height: 4),
                    Text(word.en,
                        style: const TextStyle(
                            fontSize: 14, color: AppTheme.warmGrey)),
                  ],
                ),
              ),
              const Divider(height: 1),
              ListTile(
                leading: const Icon(Icons.volume_up_rounded),
                title: const Text('Listen'),
                onTap: () {
                  Navigator.pop(ctx);
                  onListen();
                },
              ),
              if (word.isVerb)
                ListTile(
                  leading: const Icon(Icons.table_chart_rounded),
                  title: const Text('Conjugation'),
                  onTap: () {
                    Navigator.pop(ctx);
                    showConjBottomSheet(context, word, ttsSpeed);
                  },
                ),
              ListTile(
                leading: Icon(
                  inJournal
                      ? Icons.bookmark_remove_rounded
                      : Icons.bookmark_add_rounded,
                ),
                title:
                    Text(inJournal ? 'Remove from Journal' : 'Add to Journal'),
                onTap: () {
                  Navigator.pop(ctx);
                  onAddToJournal();
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

// ══════════════════════════════════════════════════════════════
//  DECK MODE
// ══════════════════════════════════════════════════════════════
class _DeckView extends StatefulWidget {
  final List<Word> words;
  final double ttsSpeed;
  final bool isDark;

  const _DeckView({
    required this.words,
    required this.ttsSpeed,
    required this.isDark,
  });

  @override
  State<_DeckView> createState() => _DeckViewState();
}

class _DeckViewState extends State<_DeckView> {
  int _currentIndex = 0;
  bool _showAnswer = false;

  Word get _word => widget.words[_currentIndex];
  bool get _hasNext => _currentIndex < widget.words.length - 1;

  void _next() {
    if (_hasNext) {
      setState(() {
        _currentIndex++;
        _showAnswer = false;
      });
    }
  }

  void _knowIt() {
    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(
        content: Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Added to review queue'),
          ],
        ),
        duration: Duration(seconds: 1),
      ),
    );
    if (_hasNext) _next();
  }

  void _studyAgain() {
    if (_hasNext) _next();
  }

  @override
  Widget build(BuildContext context) {
    final word = _word;
    final isDark = widget.isDark;
    final terracotta = isDark ? AppTheme.warmCoral : AppTheme.terracotta;
    final color = switch (word.type) {
      'verb' => AppTheme.verbCoral,
      'noun' => AppTheme.nounOchre,
      'adjective' => AppTheme.aubergine,
      'adverb' => AppTheme.indigo,
      _ => terracotta,
    };

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 8, 20, 100),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(2),
                  child: LinearProgressIndicator(
                    value: (_currentIndex + 1) / widget.words.length,
                    backgroundColor: isDark
                        ? Colors.white.withValues(alpha: 0.06)
                        : Colors.black.withValues(alpha: 0.05),
                    valueColor: AlwaysStoppedAnimation(terracotta),
                    minHeight: 4,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Text(
                '${_currentIndex + 1} / ${widget.words.length}',
                style: TextStyle(
                    fontSize: 12,
                    color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey),
              ),
            ],
          ),
          const SizedBox(height: 24),
          Expanded(
            child: GestureDetector(
              onTap: () => setState(() => _showAnswer = !_showAnswer),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(28),
                decoration: BoxDecoration(
                  color: isDark ? AppTheme.charcoal : Colors.white,
                  borderRadius: BorderRadius.circular(AppTheme.radius),
                  border: Border.all(
                    color: isDark
                        ? AppTheme.darkBorder
                        : Colors.black.withValues(alpha: 0.04),
                  ),
                  boxShadow: [
                    BoxShadow(
                      color:
                          Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
                      blurRadius: 20,
                      offset: const Offset(0, 6),
                    ),
                  ],
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 4),
                      decoration: BoxDecoration(
                        color: color.withValues(alpha: 0.12),
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: Text(
                        word.type.capitalize(),
                        style: TextStyle(
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                          color: color,
                        ),
                      ),
                    ),
                    const SizedBox(height: 24),
                    Text(
                      word.fr,
                      style: GoogleFonts.playfairDisplay(
                        fontSize: 36,
                        fontWeight: FontWeight.w800,
                        color: isDark ? AppTheme.offWhite : AppTheme.ink,
                        letterSpacing: 0.5,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    if (!_showAnswer) ...[
                      const SizedBox(height: 24),
                      Text('Tap to reveal',
                          style: TextStyle(
                              fontSize: 13,
                              color: isDark
                                  ? AppTheme.mutedGrey
                                  : AppTheme.warmGrey)),
                    ],
                    if (_showAnswer) ...[
                      const SizedBox(height: 24),
                      const Divider(),
                      const SizedBox(height: 16),
                      Text(
                        word.en,
                        style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: isDark ? AppTheme.offWhite : AppTheme.ink,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (word.example.isNotEmpty) ...[
                        const SizedBox(height: 16),
                        Text(
                          word.example,
                          style: TextStyle(
                            fontSize: 14,
                            fontStyle: FontStyle.italic,
                            color:
                                isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
                          ),
                          textAlign: TextAlign.center,
                        ),
                      ],
                      const SizedBox(height: 20),
                      IconButton(
                        icon: Icon(Icons.volume_up_rounded,
                            color: terracotta, size: 28),
                        onPressed: () async {
                          await TtsService.instance
                              .setRate(widget.ttsSpeed);
                          await TtsService.instance.speak(word.fr);
                        },
                      ),
                      if (word.isVerb) ...[
                        const SizedBox(height: 10),
                        OutlinedButton.icon(
                          onPressed: () => showConjBottomSheet(
                              context, word, widget.ttsSpeed),
                          icon: const Icon(Icons.table_chart_rounded, size: 16),
                          label: const Text('Voir la conjugaison'),
                          style: OutlinedButton.styleFrom(
                            foregroundColor: AppTheme.verbCoral,
                            side: BorderSide(
                              color: AppTheme.verbCoral.withValues(alpha: 0.5),
                            ),
                          ),
                        ),
                      ],
                    ],
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 20),
          if (_showAnswer)
            Row(
              children: [
                Expanded(
                  child: OutlinedButton.icon(
                    onPressed: _studyAgain,
                    icon: const Icon(Icons.refresh_rounded, size: 18),
                    label: const Text('Study Again'),
                    style: OutlinedButton.styleFrom(
                      foregroundColor: terracotta,
                      side:
                          BorderSide(color: terracotta.withValues(alpha: 0.4)),
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusPill),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: FilledButton.icon(
                    onPressed: _knowIt,
                    icon: const Icon(Icons.check_rounded, size: 18),
                    label: const Text('Know it'),
                    style: FilledButton.styleFrom(
                      backgroundColor: AppTheme.sage,
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(vertical: 14),
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(AppTheme.radiusPill),
                      ),
                    ),
                  ),
                ),
              ],
            ),
        ],
      ),
    );
  }
}

extension _StringCapitalize on String {
  String capitalize() =>
      isEmpty ? this : '${this[0].toUpperCase()}${substring(1)}';
}
