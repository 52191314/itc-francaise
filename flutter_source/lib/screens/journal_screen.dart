import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:go_router/go_router.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import '../models/journal_entry.dart';
import '../providers/journal_provider.dart';
import '../theme/app_theme.dart';
import '../widgets/app_shell.dart';
import '../services/haptic_service.dart';
import '../services/tts_service.dart';

/// Le Journal — personal vocabulary book with notes, tags,
/// SRS review, and text export.
class JournalScreen extends StatefulWidget {
  const JournalScreen({super.key});

  @override
  State<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends State<JournalScreen> {
  String _filterQuery = '';
  String _filterLevel = 'all';

  List<JournalEntry> get _filtered {
    final journal = context.watch<JournalProvider>();
    return journal.entries.where((e) {
      if (_filterLevel != 'all' && e.level != _filterLevel) return false;
      if (_filterQuery.isEmpty) return true;
      final q = _filterQuery.toLowerCase();
      return e.word.toLowerCase().contains(q) ||
          e.english.toLowerCase().contains(q) ||
          e.notes.toLowerCase().contains(q);
    }).toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final journal = context.watch<JournalProvider>();
    final filtered = _filtered;

    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Le Journal',
          style: GoogleFonts.playfairDisplay(
            fontSize: 18,
            fontWeight: FontWeight.w700,
            color: isDark ? AppTheme.offWhite : AppTheme.ink,
          ),
        ),
        actions: [
          if (journal.reviewQueueCount > 0)
            GestureDetector(
              onTap: () => _startReview(context, isDark),
              child: Padding(
                padding: const EdgeInsets.only(right: 4),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                  decoration: BoxDecoration(
                    color: AppTheme.terracotta.withValues(alpha: 0.1),
                    borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.autorenew_rounded,
                          size: 14, color: AppTheme.terracotta),
                      const SizedBox(width: 4),
                      Text('${journal.reviewQueueCount} to review',
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: AppTheme.terracotta)),
                    ],
                  ),
                ),
              ),
            ),
          IconButton(
            icon: Icon(Icons.menu_rounded,
                color: isDark ? AppTheme.offWhite : AppTheme.ink),
            onPressed: () => ShellMenuNotifier.open(context),
          ),
          PopupMenuButton<String>(
            icon: Icon(Icons.more_vert_rounded,
                color: isDark ? AppTheme.offWhite : AppTheme.ink),
            onSelected: (v) {
              if (v == 'export') _exportJournal(context, isDark);
              if (v == 'clear') _confirmClear(context);
            },
            itemBuilder: (_) => [
              const PopupMenuItem(
                  value: 'export',
                  child: ListTile(
                      leading: Icon(Icons.share_rounded),
                      title: Text('Export as text'))),
              const PopupMenuItem(
                  value: 'clear',
                  child: ListTile(
                      leading: Icon(Icons.delete_sweep_rounded),
                      title: Text('Clear all'))),
            ],
          ),
        ],
      ),
      body: journal.entries.isEmpty
          ? _buildEmptyState(isDark)
          : Column(
              children: [
                _buildFilterBar(isDark),
                const Divider(height: 1),
                Expanded(
                  child: filtered.isEmpty
                      ? _buildNoMatch(isDark)
                      : ListView.builder(
                          padding: const EdgeInsets.fromLTRB(16, 12, 16, 80),
                          itemCount: filtered.length,
                          itemBuilder: (ctx, i) => _JournalCard(
                            entry: filtered[i],
                            index: i,
                            isDark: isDark,
                            onTap: () =>
                                _openDetail(filtered[i], isDark),
                          ),
                        ),
                ),
              ],
            ),
    );
  }

  Widget _buildEmptyState(bool isDark) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: 72,
              height: 72,
              decoration: BoxDecoration(
                color: AppTheme.terracotta.withValues(alpha: 0.08),
                borderRadius: BorderRadius.circular(20),
              ),
              child: Icon(Icons.book_rounded,
                  size: 36, color: AppTheme.terracotta),
            ),
            const SizedBox(height: 20),
            Text(
              'Your journal is empty',
              style: GoogleFonts.playfairDisplay(
                fontSize: 22,
                fontWeight: FontWeight.w700,
                color: isDark ? AppTheme.offWhite : AppTheme.ink,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              'Swipe right on any word in the Dictionary\nto add it to your personal vocabulary book.',
              textAlign: TextAlign.center,
              style: TextStyle(
                fontSize: 14,
                height: 1.4,
                color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
              ),
            ),
            const SizedBox(height: 24),
            OutlinedButton.icon(
              onPressed: () => context.go('/vocab'),
              icon: const Icon(Icons.menu_book_rounded, size: 18),
              label: const Text('Go to Dictionary'),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNoMatch(bool isDark) {
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.search_off_rounded,
              size: 40,
              color: isDark
                  ? Colors.white.withValues(alpha: 0.15)
                  : Colors.black.withValues(alpha: 0.1)),
          const SizedBox(height: 8),
          Text('No matching entries',
              style: TextStyle(
                  color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)),
        ],
      ),
    );
  }

  Widget _buildFilterBar(bool isDark) {
    final journal = context.watch<JournalProvider>();
    return Container(
      padding: const EdgeInsets.fromLTRB(16, 8, 16, 4),
      child: Row(
        children: [
          // Level filter
          ...['all', 'A1', 'A2'].map((lv) {
            final selected = _filterLevel == lv;
            return Padding(
              padding: const EdgeInsets.only(right: 6),
              child: GestureDetector(
                onTap: () => setState(() => _filterLevel = lv),
                child: Container(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                  decoration: BoxDecoration(
                    color: selected
                        ? AppTheme.terracotta.withValues(alpha: 0.12)
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.04)
                            : Colors.black.withValues(alpha: 0.03)),
                    borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                    border: Border.all(
                      color: selected
                          ? AppTheme.terracotta.withValues(alpha: 0.3)
                          : (isDark
                              ? Colors.white.withValues(alpha: 0.06)
                              : Colors.black.withValues(alpha: 0.06)),
                    ),
                  ),
                  child: Text(
                    lv == 'all' ? 'All (${journal.count})' : '$lv',
                    style: TextStyle(
                      fontSize: 12,
                      fontWeight: selected ? FontWeight.w700 : FontWeight.w500,
                      color: selected
                          ? AppTheme.terracotta
                          : (isDark ? AppTheme.offWhite : AppTheme.ink),
                    ),
                  ),
                ),
              ),
            );
          }),
          const Spacer(),
          // Word count
          Text('${journal.count} words',
              style: TextStyle(
                  fontSize: 11,
                  color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey)),
        ],
      ),
    );
  }

  void _openDetail(JournalEntry entry, bool isDark) {
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _JournalDetail(
        entry: entry,
        isDark: isDark,
      ),
    );
  }

  void _startReview(BuildContext context, bool isDark) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => ChangeNotifierProvider.value(
          value: context.read<JournalProvider>(),
          child: _SRSReviewScreen(isDark: isDark),
        ),
      ),
    );
  }

  void _exportJournal(BuildContext context, bool isDark) {
    final journal = context.read<JournalProvider>();
    final buffer = StringBuffer();
    buffer.writeln('=== Le Journal — French Vocabulary ===');
    buffer.writeln('Exported: ${DateTime.now().toLocal().toString().substring(0, 16)}');
    buffer.writeln('Total words: ${journal.count}');
    buffer.writeln('');

    for (final entry in journal.entries) {
      buffer.writeln('${entry.word} — ${entry.english} [${entry.level} ${entry.type}]');
      if (entry.notes.isNotEmpty) {
        buffer.writeln('  Notes: ${entry.notes}');
      }
      if (entry.tags.isNotEmpty) {
        buffer.writeln('  Tags: ${entry.tags.join(', ')}');
      }
      buffer.writeln('  Mastery: ${(entry.mastery * 100).toInt()}%');
      buffer.writeln('');
    }

    Clipboard.setData(ClipboardData(text: buffer.toString()));
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: const Row(
          children: [
            Icon(Icons.check_circle, color: Colors.white, size: 18),
            SizedBox(width: 8),
            Text('Copied to clipboard!'),
          ],
        ),
        backgroundColor: AppTheme.sage,
        behavior: SnackBarBehavior.floating,
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _confirmClear(BuildContext context) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: const Text('Clear all entries?'),
        content: const Text('This will remove all words from your journal.'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(ctx),
            child: const Text('Cancel'),
          ),
          FilledButton(
            onPressed: () {
              context.read<JournalProvider>().clearAll();
              Navigator.pop(ctx);
            },
            style: FilledButton.styleFrom(
              backgroundColor: AppTheme.verbCoral,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  JOURNAL CARD
// ═══════════════════════════════════════════════════════════════
class _JournalCard extends StatelessWidget {
  final JournalEntry entry;
  final int index;
  final bool isDark;
  final VoidCallback onTap;

  const _JournalCard({
    required this.entry,
    required this.index,
    required this.isDark,
    required this.onTap,
  });

  Color get _typeColor => switch (entry.type) {
        'verb' => AppTheme.verbCoral,
        'noun' => AppTheme.nounOchre,
        'adjective' => AppTheme.aubergine,
        'adverb' => AppTheme.indigo,
        _ => AppTheme.terracotta,
      };

  String _dateLabel(DateTime d) {
    final diff = DateTime.now().difference(d);
    if (diff.inDays == 0) return 'Today';
    if (diff.inDays == 1) return 'Yesterday';
    if (diff.inDays < 7) return '${diff.inDays}d ago';
    return '${d.day.toString().padLeft(2, '0')}/${d.month.toString().padLeft(2, '0')}';
  }

  @override
  Widget build(BuildContext context) {
    final color = _typeColor;
    final mastery = entry.mastery;

    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 8),
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: isDark ? AppTheme.charcoal : Colors.white,
          borderRadius: BorderRadius.circular(AppTheme.radius),
          border: Border.all(
            color: isDark
                ? AppTheme.darkBorder.withValues(alpha: 0.5)
                : Colors.black.withValues(alpha: 0.04),
          ),
        ),
        child: Row(
          children: [
            // Type indicator
            Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: color.withValues(alpha: 0.12),
                borderRadius: BorderRadius.circular(10),
              ),
              child: Center(
                child: Text(
                  entry.type.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      color: color,
                      fontWeight: FontWeight.w800,
                      fontSize: 16),
                ),
              ),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(
                        entry.word,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 15,
                          fontWeight: FontWeight.w700,
                          color: isDark ? AppTheme.offWhite : AppTheme.ink,
                        ),
                      ),
                      const SizedBox(width: 6),
                      Text(entry.english,
                          style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? AppTheme.mutedGrey
                                  : AppTheme.warmGrey)),
                    ],
                  ),
                  if (entry.notes.isNotEmpty) ...[
                    const SizedBox(height: 4),
                    Text(entry.notes,
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11, fontStyle: FontStyle.italic,
                            color: isDark
                                ? AppTheme.mutedGrey
                                : AppTheme.warmGrey)),
                  ],
                ],
              ),
            ),
            const SizedBox(width: 8),
            // Mastery indicator
            Column(
              children: [
                SizedBox(
                  width: 28,
                  height: 28,
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      CircularProgressIndicator(
                        value: mastery,
                        strokeWidth: 3,
                        backgroundColor: isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : Colors.black.withValues(alpha: 0.05),
                        valueColor:
                            AlwaysStoppedAnimation(mastery > 0.7
                                ? AppTheme.sage
                                : mastery > 0.3
                                    ? AppTheme.nounOchre
                                    : AppTheme.verbCoral),
                      ),
                      Text(
                        '${(mastery * 100).toInt()}',
                        style: TextStyle(
                            fontSize: 9,
                            fontWeight: FontWeight.w800,
                            color: isDark
                                ? AppTheme.offWhite
                                : AppTheme.ink),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 2),
                Text(_dateLabel(entry.dateAdded),
                    style: TextStyle(
                        fontSize: 9,
                        color: isDark
                            ? AppTheme.mutedGrey
                            : AppTheme.warmGrey)),
              ],
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: (index * 20).clamp(0, 240)))
        .fadeIn(duration: 200.ms)
        .slideX(begin: 0.05, curve: Curves.easeOut);
  }
}

// ═══════════════════════════════════════════════════════════════
//  JOURNAL DETAIL SHEET
// ═══════════════════════════════════════════════════════════════
class _JournalDetail extends StatefulWidget {
  final JournalEntry entry;
  final bool isDark;

  const _JournalDetail({
    required this.entry,
    required this.isDark,
  });

  @override
  State<_JournalDetail> createState() => _JournalDetailState();
}

class _JournalDetailState extends State<_JournalDetail> {
  late TextEditingController _notesCtrl;
  late TextEditingController _tagCtrl;

  @override
  void initState() {
    super.initState();
    _notesCtrl = TextEditingController(text: widget.entry.notes);
    _tagCtrl = TextEditingController();
  }

  @override
  void dispose() {
    _notesCtrl.dispose();
    _tagCtrl.dispose();
    super.dispose();
  }

  void _addTag(String tag) {
    if (tag.trim().isEmpty) return;
    final provider = context.read<JournalProvider>();
    final tags = List<String>.from(widget.entry.tags)..add(tag.trim().toLowerCase());
    provider.updateTags(widget.entry.word, tags);
    _tagCtrl.clear();
  }

  void _removeTag(String tag) {
    final provider = context.read<JournalProvider>();
    final tags = List<String>.from(widget.entry.tags)..remove(tag);
    provider.updateTags(widget.entry.word, tags);
  }

  @override
  Widget build(BuildContext context) {
    final entry = widget.entry;
    final isDark = widget.isDark;

    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
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
              // Word header
              Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(entry.word,
                            style: GoogleFonts.playfairDisplay(
                                fontSize: 24,
                                fontWeight: FontWeight.w800,
                                color: isDark
                                    ? AppTheme.offWhite
                                    : AppTheme.ink)),
                        Text(entry.english,
                            style: TextStyle(
                                fontSize: 14,
                                color: isDark
                                    ? AppTheme.mutedGrey
                                    : AppTheme.warmGrey)),
                      ],
                    ),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 5),
                    decoration: BoxDecoration(
                      color: entry.level == 'A1'
                          ? AppTheme.indigo.withValues(alpha: 0.1)
                          : AppTheme.aubergine.withValues(alpha: 0.1),
                      borderRadius: BorderRadius.circular(6),
                    ),
                    child: Text('${entry.level} ${entry.type}',
                        style: TextStyle(
                            fontSize: 10,
                            fontWeight: FontWeight.w800,
                            color: entry.level == 'A1'
                                ? AppTheme.indigo
                                : AppTheme.aubergine)),
                  ),
                ],
              ),
              const SizedBox(height: 16),
              // SRS stats
              Row(
                children: [
                  _StatChip(
                      label: 'Level ${entry.reviewLevel}',
                      icon: Icons.school_rounded,
                      color: AppTheme.terracotta),
                  const SizedBox(width: 8),
                  _StatChip(
                      label: '${(entry.mastery * 100).toInt()}% mastery',
                      icon: Icons.trending_up_rounded,
                      color: entry.mastery > 0.7
                          ? AppTheme.sage
                          : AppTheme.nounOchre),
                  const SizedBox(width: 8),
                  _StatChip(
                      label: '${entry.correctCount}✓ ${entry.incorrectCount}✗',
                      icon: Icons.check_circle_outline_rounded,
                      color: AppTheme.indigo),
                ],
              ),
              const SizedBox(height: 16),
              // Notes
              Text('Notes',
                  style: TextStyle(
                      fontSize: 12,
                      fontWeight: FontWeight.w700,
                      color: isDark ? AppTheme.offWhite : AppTheme.ink)),
              const SizedBox(height: 6),
              TextField(
                controller: _notesCtrl,
                maxLines: 3,
                onChanged: (v) {
                  context
                      .read<JournalProvider>()
                      .updateNotes(entry.word, v);
                },
                style: TextStyle(
                  fontSize: 13,
                  color: isDark ? AppTheme.offWhite : AppTheme.ink,
                ),
                decoration: InputDecoration(
                  hintText: 'Add your own notes, mnemonics, or examples...',
                  hintStyle: TextStyle(
                    fontSize: 12,
                    color: isDark
                        ? AppTheme.mutedGrey.withValues(alpha: 0.4)
                        : AppTheme.warmGrey.withValues(alpha: 0.4),
                  ),
                  contentPadding:
                      const EdgeInsets.all(12),
                ),
              ),
              const SizedBox(height: 12),
              // Tags
              Row(
                children: [
                  Text('Tags',
                      style: TextStyle(
                          fontSize: 12,
                          fontWeight: FontWeight.w700,
                          color: isDark
                              ? AppTheme.offWhite
                              : AppTheme.ink)),
                  const Spacer(),
                  SizedBox(
                    width: 120,
                    child: TextField(
                      controller: _tagCtrl,
                      onSubmitted: _addTag,
                      style: TextStyle(
                        fontSize: 12,
                        color: isDark ? AppTheme.offWhite : AppTheme.ink,
                      ),
                      decoration: InputDecoration(
                        hintText: 'Add tag...',
                        hintStyle: TextStyle(
                          fontSize: 11,
                          color: isDark
                              ? AppTheme.mutedGrey.withValues(alpha: 0.4)
                              : AppTheme.warmGrey.withValues(alpha: 0.4),
                        ),
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 10, vertical: 6),
                        isDense: true,
                      ),
                    ),
                  ),
                ],
              ),
              if (entry.tags.isNotEmpty) ...[
                const SizedBox(height: 8),
                Wrap(
                  spacing: 6,
                  runSpacing: 4,
                  children: entry.tags
                      .map((t) => Chip(
                            label: Text(t,
                                style: const TextStyle(fontSize: 11)),
                            deleteIcon: const Icon(Icons.close_rounded,
                                size: 14),
                            onDeleted: () => _removeTag(t),
                            materialTapTargetSize:
                                MaterialTapTargetSize.shrinkWrap,
                            visualDensity: VisualDensity.compact,
                          ))
                      .toList(),
                ),
              ],
              const SizedBox(height: 16),
              // Listen button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: () {
                    TtsService.instance.setRate(0.85);
                    TtsService.instance.speak(entry.word);
                  },
                  icon: const Icon(Icons.volume_up_rounded, size: 18),
                  label: const Text('Listen'),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class _StatChip extends StatelessWidget {
  final String label;
  final IconData icon;
  final Color color;

  const _StatChip({
    required this.label,
    required this.icon,
    required this.color,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(6),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: 12, color: color),
          const SizedBox(width: 4),
          Text(label,
              style: TextStyle(
                  fontSize: 10,
                  fontWeight: FontWeight.w700,
                  color: color)),
        ],
      ),
    );
  }
}

// ═══════════════════════════════════════════════════════════════
//  SRS REVIEW SCREEN
// ═══════════════════════════════════════════════════════════════
class _SRSReviewScreen extends StatefulWidget {
  final bool isDark;

  const _SRSReviewScreen({required this.isDark});

  @override
  State<_SRSReviewScreen> createState() => _SRSReviewScreenState();
}

class _SRSReviewScreenState extends State<_SRSReviewScreen> {
  int _currentIndex = 0;
  bool _showAnswer = false;
  List<JournalEntry> _queue = [];

  @override
  void initState() {
    super.initState();
    final journal = context.read<JournalProvider>();
    _queue = journal.reviewQueue;
  }

  bool get _hasNext => _currentIndex < _queue.length - 1;

  JournalEntry? get _current =>
      _queue.isEmpty ? null : _queue[_currentIndex];

  void _recordAndNext(bool correct) {
    if (_current == null) return;
    context.read<JournalProvider>().recordReview(_current!.word, correct);
    if (correct) {
      HapticService.instance.correctPop();
    } else {
      HapticService.instance.wrongBuzz();
    }
    if (_hasNext) {
      setState(() {
        _currentIndex++;
        _showAnswer = false;
      });
    } else {
      Navigator.pop(context);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: const Row(
            children: [
              Icon(Icons.celebration_rounded, color: Colors.white, size: 18),
              SizedBox(width: 8),
              Text('Review complete! 🎉'),
            ],
          ),
          backgroundColor: AppTheme.sage,
          behavior: SnackBarBehavior.floating,
          duration: const Duration(seconds: 2),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;

    if (_queue.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Review')),
        body: Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.check_circle_outline_rounded,
                  size: 64, color: AppTheme.sage),
              const SizedBox(height: 16),
              const Text('All caught up!',
                  style: TextStyle(
                      fontSize: 20, fontWeight: FontWeight.w700)),
              const SizedBox(height: 8),
              const Text('No words need review right now.'),
              const SizedBox(height: 24),
              OutlinedButton(
                onPressed: () => Navigator.pop(context),
                child: const Text('Done'),
              ),
            ],
          ),
        ),
      );
    }

    final entry = _current!;
    final terracotta =
        isDark ? AppTheme.warmCoral : AppTheme.terracotta;

    return Scaffold(
      appBar: AppBar(
        title: Text('Review (${_currentIndex + 1}/${_queue.length})'),
      ),
      body: Padding(
        padding: const EdgeInsets.fromLTRB(20, 16, 20, 100),
        child: Column(
          children: [
            // Progress
            ClipRRect(
              borderRadius: BorderRadius.circular(2),
              child: LinearProgressIndicator(
                value: (_currentIndex + 1) / _queue.length,
                backgroundColor:
                    isDark ? Colors.white.withValues(alpha: 0.06) : Colors.black.withValues(alpha: 0.05),
                valueColor: AlwaysStoppedAnimation(terracotta),
                minHeight: 4,
              ),
            ),
            const SizedBox(height: 24),

            // Flashcard
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
                        color: Colors.black.withValues(alpha: isDark ? 0.2 : 0.06),
                        blurRadius: 20,
                        offset: const Offset(0, 6),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        entry.word,
                        style: GoogleFonts.playfairDisplay(
                          fontSize: 36,
                          fontWeight: FontWeight.w800,
                          color: isDark ? AppTheme.offWhite : AppTheme.ink,
                        ),
                        textAlign: TextAlign.center,
                      ),
                      if (!_showAnswer) ...[
                        const SizedBox(height: 16),
                        Text('Tap to reveal',
                            style: TextStyle(
                                fontSize: 13,
                                color: isDark
                                    ? AppTheme.mutedGrey
                                    : AppTheme.warmGrey)),
                      ],
                      if (_showAnswer) ...[
                        const SizedBox(height: 16),
                        const Divider(),
                        const SizedBox(height: 16),
                        Text(entry.english,
                            style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w600,
                                color: isDark
                                    ? AppTheme.offWhite
                                    : AppTheme.ink),
                            textAlign: TextAlign.center),
                        if (entry.notes.isNotEmpty) ...[
                          const SizedBox(height: 12),
                          Text(entry.notes,
                              style: TextStyle(
                                  fontSize: 14,
                                  fontStyle: FontStyle.italic,
                                  color: isDark
                                      ? AppTheme.mutedGrey
                                      : AppTheme.warmGrey),
                              textAlign: TextAlign.center),
                        ],
                      ],
                    ],
                  ),
                ),
              ),
            ),

            if (_showAnswer) ...[
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: OutlinedButton.icon(
                      onPressed: () => _recordAndNext(false),
                      icon: const Icon(Icons.refresh_rounded, size: 18),
                      label: const Text('Study Again'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.verbCoral,
                        side: BorderSide(
                            color: AppTheme.verbCoral.withValues(alpha: 0.4)),
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
                      onPressed: () => _recordAndNext(true),
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
          ],
        ),
      ),
    );
  }
}
