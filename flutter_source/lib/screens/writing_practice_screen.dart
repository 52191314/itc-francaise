import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/writing_data.dart';
import '../models/writing_text.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/course_portal_button.dart';

class WritingPracticeScreen extends StatefulWidget {
  const WritingPracticeScreen({super.key});

  @override
  State<WritingPracticeScreen> createState() => _WritingPracticeScreenState();
}

class _WritingPracticeScreenState extends State<WritingPracticeScreen> {
  String _query = '';
  String _level = 'all';
  final _searchController = TextEditingController();

  List<WritingText> get _filtered => kWritingTexts.where((text) {
        if (_level != 'all' && text.level != _level) return false;
        return text.matches(_query);
      }).toList();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final filtered = _filtered;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Writing Practice'),
        actions: [
          const CoursePortalButton(),
          Padding(
            padding: const EdgeInsets.only(right: 12),
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
          Container(
            color: theme.appBarTheme.backgroundColor,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                TextField(
                  controller: _searchController,
                  onChanged: (value) => setState(() => _query = value),
                  decoration: InputDecoration(
                    hintText: 'Search topics, text, or grammar...',
                    prefixIcon: const Icon(Icons.search_rounded, size: 20),
                    suffixIcon: _query.isEmpty
                        ? null
                        : IconButton(
                            onPressed: () {
                              _searchController.clear();
                              setState(() => _query = '');
                            },
                            icon: const Icon(Icons.clear_rounded, size: 18),
                          ),
                    isDense: true,
                  ),
                ),
                const SizedBox(height: 10),
                Row(
                  children: [
                    Text('Level',
                        style: theme.textTheme.labelSmall
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(width: 8),
                    Expanded(
                      child: SizedBox(
                        height: 34,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: ['all', 'A1', 'A2']
                              .map(
                                (level) => Padding(
                                  padding: const EdgeInsets.only(right: 6),
                                  child: ChoiceChip(
                                    key: Key('writing-level-$level'),
                                    label: Text(level == 'all'
                                        ? 'All (240)'
                                        : '$level (120)'),
                                    selected: _level == level,
                                    onSelected: (selected) {
                                      if (selected) {
                                        setState(() => _level = level);
                                      }
                                    },
                                  ),
                                ),
                              )
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),
          Expanded(
            child: filtered.isEmpty
                ? _WritingEmptyState(
                    onClear: () {
                      _searchController.clear();
                      setState(() {
                        _query = '';
                        _level = 'all';
                      });
                    },
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (context, index) => _WritingCard(
                      text: filtered[index],
                      index: index,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

class _WritingCard extends StatelessWidget {
  final WritingText text;
  final int index;

  const _WritingCard({required this.text, required this.index});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = text.level == 'A1' ? AppTheme.blue : AppTheme.purple;

    return Card(
      margin: const EdgeInsets.only(bottom: 9),
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radius),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
              builder: (_) => WritingTextDetailScreen(text: text)),
        ),
        child: Padding(
          padding: const EdgeInsets.all(14),
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 5),
                decoration: BoxDecoration(
                  color: color.withValues(alpha: 0.13),
                  borderRadius: BorderRadius.circular(AppTheme.radiusXs),
                ),
                child: Text(
                  text.level,
                  style: TextStyle(
                    color: color,
                    fontSize: 11,
                    fontWeight: FontWeight.w900,
                  ),
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      text.title,
                      style: theme.textTheme.titleSmall?.copyWith(
                        color: theme.colorScheme.onSurface,
                        fontWeight: FontWeight.w700,
                        fontSize: 14.5,
                      ),
                    ),
                    const SizedBox(height: 3),
                    Text(
                      text.text,
                      maxLines: 2,
                      overflow: TextOverflow.ellipsis,
                      style: theme.textTheme.bodySmall?.copyWith(height: 1.35),
                    ),
                    const SizedBox(height: 7),
                    Text(
                      text.grammarFocus,
                      style: theme.textTheme.labelSmall?.copyWith(
                        color: theme.colorScheme.primary,
                        fontWeight: FontWeight.w700,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 6),
              Icon(Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurface.withValues(alpha: 0.28)),
            ],
          ),
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: (index * 20).clamp(0, 240)))
        .fadeIn(duration: 180.ms);
  }
}

class WritingTextDetailScreen extends StatefulWidget {
  final WritingText text;

  const WritingTextDetailScreen({super.key, required this.text});

  @override
  State<WritingTextDetailScreen> createState() =>
      _WritingTextDetailScreenState();
}

class _WritingTextDetailScreenState extends State<WritingTextDetailScreen> {
  final _draftController = TextEditingController();
  bool _writingPadOpen = true;

  int get _wordCount {
    final value = _draftController.text.trim();
    if (value.isEmpty) return 0;
    return value.split(RegExp(r'\s+')).length;
  }

  @override
  void dispose() {
    _draftController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final text = widget.text;
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text(text.title),
        actions: const [CoursePortalButton()],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                Wrap(
                  spacing: 8,
                  runSpacing: 8,
                  children: [
                    _InfoChip(label: text.level, color: AppTheme.blue),
                    _InfoChip(label: text.category, color: AppTheme.gold),
                    _InfoChip(label: text.grammarFocus, color: AppTheme.purple),
                  ],
                ),
                const SizedBox(height: 16),
                Text('Writing task',
                    style: theme.textTheme.titleMedium
                        ?.copyWith(fontWeight: FontWeight.w800)),
                const SizedBox(height: 6),
                Text(text.task, style: theme.textTheme.bodyMedium),
                const SizedBox(height: 18),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Icon(Icons.auto_stories_rounded,
                                color: theme.colorScheme.primary, size: 20),
                            const SizedBox(width: 8),
                            Text('Model text',
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w800)),
                          ],
                        ),
                        const SizedBox(height: 12),
                        GlossaryText(text: text.text),
                        const SizedBox(height: 12),
                        Text(
                          'Tap highlighted words for English. You can also select and copy the French text.',
                          style: theme.textTheme.bodySmall?.copyWith(fontSize: 11.5),
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 12),
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(Icons.school_rounded,
                                color: AppTheme.purple, size: 20),
                            const SizedBox(width: 8),
                            Text('Grammar: ${text.grammarFocus}',
                                style: theme.textTheme.titleMedium
                                    ?.copyWith(fontWeight: FontWeight.w800)),
                          ],
                        ),
                        const SizedBox(height: 10),
                        Text(text.grammarExplanation,
                            style: theme.textTheme.bodyMedium?.copyWith(height: 1.5)),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
          _buildWritingPad(theme, cs),
        ],
      ),
    );
  }

  Widget _buildWritingPad(ThemeData theme, ColorScheme cs) {
    final isDark = theme.brightness == Brightness.dark;

    if (!_writingPadOpen) {
      return Container(
        decoration: BoxDecoration(
          color: theme.cardTheme.color,
          border: Border(
            top: BorderSide(
              color: cs.onSurface.withOpacity(0.08),
              width: 1.0,
            ),
          ),
        ),
        child: InkWell(
          onTap: () => setState(() => _writingPadOpen = true),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: Row(
              children: [
                const Icon(Icons.edit_note_rounded, color: AppTheme.purple, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Open Practice Writing Pad',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: AppTheme.purple,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                  ),
                ),
                const Spacer(),
                if (_draftController.text.trim().isNotEmpty) ...[
                  Text(
                    '$_wordCount words',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: theme.colorScheme.primary,
                      fontSize: 11,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(width: 12),
                ],
                Icon(
                  Icons.keyboard_arrow_up_rounded,
                  color: cs.onSurface.withOpacity(0.5),
                  size: 20,
                ),
              ],
            ),
          ),
        ),
      );
    }

    return Container(
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        border: Border(
          top: BorderSide(
            color: cs.onSurface.withOpacity(0.08),
            width: 1.0,
          ),
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 5,
            offset: const Offset(0, -2),
          ),
        ],
      ),
      child: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 12, 16, 12),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                children: [
                  const Icon(Icons.edit_note_rounded, color: AppTheme.purple, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    'Practice Writing Pad',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                    ),
                  ),
                  const SizedBox(width: 12),
                  Text(
                    '($_wordCount words)',
                    style: theme.textTheme.bodySmall?.copyWith(
                      color: cs.primary,
                      fontWeight: FontWeight.w600,
                      fontSize: 11.5,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.delete_sweep_rounded,
                        color: cs.onSurface.withOpacity(0.4), size: 18),
                    onPressed: _draftController.text.isEmpty
                        ? null
                        : () {
                            _draftController.clear();
                            setState(() {});
                          },
                    tooltip: 'Clear draft',
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                  const SizedBox(width: 14),
                  IconButton(
                    icon: Icon(Icons.keyboard_arrow_down_rounded,
                        color: cs.onSurface.withOpacity(0.5), size: 20),
                    onPressed: () => setState(() => _writingPadOpen = false),
                    tooltip: 'Hide writing pad',
                    constraints: const BoxConstraints(),
                    padding: EdgeInsets.zero,
                  ),
                ],
              ),
              const SizedBox(height: 10),
              TextField(
                controller: _draftController,
                onChanged: (_) => setState(() {}),
                maxLines: 4,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13.5),
                decoration: InputDecoration(
                  hintText: 'Use the model and grammar note, then write your own short text...',
                  contentPadding: const EdgeInsets.all(12),
                  fillColor: isDark
                      ? Colors.black.withOpacity(0.2)
                      : Colors.black.withOpacity(0.015),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}


class GlossaryText extends StatefulWidget {
  final String text;

  const GlossaryText({super.key, required this.text});

  @override
  State<GlossaryText> createState() => _GlossaryTextState();
}

class _GlossaryTextState extends State<GlossaryText> {
  late RegExp _pattern;
  final _recognizers = <TapGestureRecognizer>[];

  @override
  void initState() {
    super.initState();
    _pattern = _buildPattern();
  }

  @override
  void didUpdateWidget(covariant GlossaryText oldWidget) {
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
    for (final recognizer in _recognizers) {
      recognizer.dispose();
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
    showModalBottomSheet<void>(
      context: context,
      showDragHandle: true,
      builder: (context) => SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(20, 4, 20, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(key,
                  style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: Theme.of(context).colorScheme.primary)),
              const SizedBox(height: 8),
              Text(kWritingGlossary[key]!,
                  style: Theme.of(context).textTheme.titleMedium),
            ],
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    _disposeRecognizers();
    final theme = Theme.of(context);
    final spans = <TextSpan>[];
    var cursor = 0;

    for (final match in _pattern.allMatches(widget.text)) {
      if (match.start > cursor) {
        spans.add(TextSpan(text: widget.text.substring(cursor, match.start)));
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
            color: theme.colorScheme.primary,
            fontWeight: FontWeight.w700,
            backgroundColor: theme.colorScheme.primary.withValues(alpha: 0.12),
            decoration: TextDecoration.underline,
            decorationColor: theme.colorScheme.primary.withValues(alpha: 0.5),
          ),
        ),
      );
      cursor = match.end;
    }

    if (cursor < widget.text.length) {
      spans.add(TextSpan(text: widget.text.substring(cursor)));
    }

    return SelectionArea(
      child: Text.rich(
        TextSpan(children: spans),
        style: theme.textTheme.bodyLarge?.copyWith(fontSize: 16, height: 1.65),
      ),
    );
  }
}

class _InfoChip extends StatelessWidget {
  final String label;
  final Color color;

  const _InfoChip({required this.label, required this.color});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 9, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(999),
        border: Border.all(color: color.withValues(alpha: 0.25)),
      ),
      child: Text(
        label,
        style:
            TextStyle(color: color, fontSize: 11, fontWeight: FontWeight.w800),
      ),
    );
  }
}

class _WritingEmptyState extends StatelessWidget {
  final VoidCallback onClear;

  const _WritingEmptyState({required this.onClear});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(Icons.edit_note_rounded,
              size: 50,
              color: theme.colorScheme.onSurface.withValues(alpha: 0.2)),
          const SizedBox(height: 10),
          const Text('No writing texts match these filters.'),
          const SizedBox(height: 8),
          OutlinedButton(
              onPressed: onClear, child: const Text('Clear filters')),
        ],
      ),
    );
  }
}
