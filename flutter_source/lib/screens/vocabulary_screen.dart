import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/vocab_data.dart';
import '../models/word.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/conj_bottom_sheet.dart';
import '../widgets/course_portal_button.dart';

class VocabularyScreen extends StatefulWidget {
  const VocabularyScreen({super.key});

  @override
  State<VocabularyScreen> createState() => _VocabularyScreenState();
}

class _VocabularyScreenState extends State<VocabularyScreen> {
  String _query = '';
  String _level = 'all';
  String _type = 'all';
  double _ttsSpeed = 0.85;
  final _searchCtrl = TextEditingController();

  List<Word> get _filtered {
    return kVocab.where((w) {
      if (_level != 'all' &&
          w.level.trim().toUpperCase() != _level.toUpperCase()) {
        return false;
      }
      if (_type != 'all' && w.type.trim().toLowerCase() != _type) return false;
      return w.matches(_query);
    }).toList();
  }

  int _levelCount(String level) => kVocab
      .where((word) => word.level.trim().toUpperCase() == level.toUpperCase())
      .length;

  int _typeCount(String type) => kVocab.where((word) {
        if (_level != 'all' &&
            word.level.trim().toUpperCase() != _level.toUpperCase()) {
          return false;
        }
        return word.type.trim().toLowerCase() == type;
      }).length;

  void _selectLevel(String level) {
    setState(() {
      _level = level;
      if (_type != 'all' && _typeCount(_type) == 0) {
        _type = 'all';
      }
    });
  }

  // ── Filter chips ─────────────────────────────────────────────
  static const _levels = ['all', 'A1', 'A2'];
  static const _types = ['all', 'verb', 'noun', 'adjective', 'adverb'];

  String _typeLabel(String t) => switch (t) {
        'all' => 'All',
        'verb' => 'Verbs',
        'noun' => 'Nouns',
        'adjective' => 'Adjectives',
        'adverb' => 'Adverbs',
        _ => t,
      };

  Color _typeColor(String t, ColorScheme cs) => switch (t) {
        'verb' => AppTheme.coral,
        'noun' => AppTheme.gold,
        'adjective' => AppTheme.purple,
        'adverb' => AppTheme.blue,
        _ => cs.primary,
      };

  @override
  void dispose() {
    _searchCtrl.dispose();
    TtsService.instance.stop();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final filtered = _filtered;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Vocabulary'),
        actions: [
          const CoursePortalButton(),
          Padding(
            padding: const EdgeInsets.only(right: 8),
            child: Center(
              child: Text(
                '${filtered.length} / ${kVocab.length}',
                style: theme.textTheme.bodySmall?.copyWith(
                  color: cs.primary,
                  fontWeight: FontWeight.w700,
                ),
              ),
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          // ── Search + filters ───────────────────────────────────
          Container(
            color: theme.appBarTheme.backgroundColor,
            padding: const EdgeInsets.fromLTRB(12, 0, 12, 12),
            child: Column(
              children: [
                // Search bar
                TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    hintText: 'Search French or English...',
                    prefixIcon: const Icon(Icons.search_rounded, size: 20),
                    suffixIcon: _query.isNotEmpty
                        ? IconButton(
                            icon: const Icon(Icons.clear_rounded, size: 18),
                            onPressed: () {
                              _searchCtrl.clear();
                              setState(() => _query = '');
                            },
                          )
                        : null,
                    isDense: true,
                    contentPadding: const EdgeInsets.symmetric(
                        vertical: 10, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 8),
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
                          children: _levels
                              .map((lv) => Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: ChoiceChip(
                                      key: Key('vocab-level-$lv'),
                                      label: Text(lv == 'all'
                                          ? 'All (${kVocab.length})'
                                          : '$lv (${_levelCount(lv)})'),
                                      selected: _level == lv,
                                      selectedColor:
                                          cs.primary.withOpacity(0.15),
                                      onSelected: (selected) {
                                        if (selected) _selectLevel(lv);
                                      },
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text('Type',
                        style: theme.textTheme.labelSmall
                            ?.copyWith(fontWeight: FontWeight.w800)),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 34,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: _types
                              .map((tp) => Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: ChoiceChip(
                                      key: Key('vocab-type-$tp'),
                                      label: Text(tp == 'all'
                                          ? 'All types'
                                          : '${_typeLabel(tp)} (${_typeCount(tp)})'),
                                      selected: _type == tp,
                                      selectedColor:
                                          _typeColor(tp, cs).withOpacity(0.15),
                                      onSelected:
                                          tp != 'all' && _typeCount(tp) == 0
                                              ? null
                                              : (selected) {
                                                  if (selected) {
                                                    setState(() => _type = tp);
                                                  }
                                                },
                                    ),
                                  ))
                              .toList(),
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Text(
                      'TTS Speed',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 8),
                    Text(
                      '${_ttsSpeed.toStringAsFixed(2)}x',
                      style: theme.textTheme.bodySmall?.copyWith(
                        fontWeight: FontWeight.w600,
                        fontSize: 11,
                      ),
                    ),
                    Expanded(
                      child: SizedBox(
                        height: 34,
                        child: Slider(
                          value: _ttsSpeed,
                          min: 0.4,
                          max: 1.2,
                          divisions: 16,
                          onChanged: (val) {
                            setState(() {
                              _ttsSpeed = val;
                            });
                          },
                        ),
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),
          const Divider(height: 1),

          // ── Word list ──────────────────────────────────────────
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.search_off_rounded,
                            size: 48, color: cs.onSurface.withOpacity(0.2)),
                        const SizedBox(height: 12),
                        Text('No words found',
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: cs.onSurface.withOpacity(0.4))),
                        const SizedBox(height: 8),
                        OutlinedButton(
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() {
                              _query = '';
                              _level = 'all';
                              _type = 'all';
                            });
                          },
                          child: const Text('Clear filters'),
                        ),
                      ],
                    ),
                  )
                : ListView.separated(
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    itemCount: filtered.length,
                    separatorBuilder: (_, __) => const Divider(height: 1),
                    itemBuilder: (ctx, i) => _WordTile(
                      word: filtered[i],
                      index: i,
                      query: _query,
                      ttsSpeed: _ttsSpeed,
                    ),
                  ),
          ),
        ],
      ),
    );
  }
}

// ── Individual word row ────────────────────────────────────────
class _WordTile extends StatelessWidget {
  final Word word;
  final int index;
  final String query;
  final double ttsSpeed;
  const _WordTile(
      {required this.word,
      required this.index,
      required this.query,
      required this.ttsSpeed});

  Color _typeColor(BuildContext ctx) {
    final cs = Theme.of(ctx).colorScheme;
    return switch (word.type) {
      'verb' => AppTheme.coral,
      'noun' => AppTheme.gold,
      'adjective' => AppTheme.purple,
      'adverb' => AppTheme.blue,
      _ => cs.primary,
    };
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = _typeColor(context);

    return ListTile(
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      leading: word.isVerb
          ? GestureDetector(
              onTap: () => showConjBottomSheet(context, word, ttsSpeed),
              child: Container(
                width: 36,
                height: 36,
                decoration: BoxDecoration(
                  color: color.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppTheme.radiusXs),
                  border: Border.all(color: color.withOpacity(0.3)),
                ),
                child: Icon(Icons.table_rows_rounded, color: color, size: 18),
              ),
            )
          : Container(
              width: 36,
              height: 36,
              decoration: BoxDecoration(
                color: color.withOpacity(0.08),
                borderRadius: BorderRadius.circular(AppTheme.radiusXs),
              ),
              child: Center(
                child: Text(
                  word.type.substring(0, 1).toUpperCase(),
                  style: TextStyle(
                      color: color, fontWeight: FontWeight.w800, fontSize: 14),
                ),
              ),
            ),
      title: Text(
        word.fr,
        style: theme.textTheme.titleSmall?.copyWith(
          color: theme.colorScheme.onSurface,
          fontWeight: FontWeight.w600,
          fontSize: 15,
        ),
      ),
      subtitle: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            word.en,
            style: theme.textTheme.bodySmall?.copyWith(fontSize: 13),
          ),
          if (word.example.isNotEmpty)
            Text(
              word.example,
              style: theme.textTheme.bodySmall?.copyWith(
                fontSize: 11.5,
                fontStyle: FontStyle.italic,
              ),
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
        ],
      ),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          // Level badge
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
            decoration: BoxDecoration(
              color: word.level == 'A1'
                  ? theme.colorScheme.primary.withOpacity(0.12)
                  : theme.colorScheme.secondary.withOpacity(0.12),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              word.level,
              style: TextStyle(
                fontSize: 10,
                fontWeight: FontWeight.w800,
                color: word.level == 'A1'
                    ? theme.colorScheme.primary
                    : theme.colorScheme.secondary,
              ),
            ),
          ),
          const SizedBox(width: 6),
          // TTS button
          IconButton(
            icon: Icon(Icons.volume_up_rounded,
                size: 20, color: theme.colorScheme.onSurface.withOpacity(0.45)),
            onPressed: () async {
              await TtsService.instance.setRate(ttsSpeed);
              await TtsService.instance.speak(word.fr);
            },
            padding: EdgeInsets.zero,
            constraints: const BoxConstraints(minWidth: 32, minHeight: 32),
          ),
        ],
      ),
      onTap: word.isVerb
          ? () => showConjBottomSheet(context, word, ttsSpeed)
          : null,
    )
        .animate(delay: Duration(milliseconds: (index * 20).clamp(0, 300)))
        .fadeIn(duration: 200.ms);
  }
}
