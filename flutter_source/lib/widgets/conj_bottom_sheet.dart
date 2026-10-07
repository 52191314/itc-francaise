import 'package:flutter/material.dart';

import '../models/word.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';

/// Shows a draggable bottom sheet with the full conjugation table for a verb.
void showConjBottomSheet(BuildContext context, Word word, double ttsSpeed) {
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) => ConjBottomSheet(word: word, ttsSpeed: ttsSpeed),
  );
}

class ConjBottomSheet extends StatelessWidget {
  final Word word;
  final double ttsSpeed;
  const ConjBottomSheet({super.key, required this.word, required this.ttsSpeed});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;

    return DraggableScrollableSheet(
      initialChildSize: 0.75,
      minChildSize: 0.4,
      maxChildSize: 0.95,
      builder: (ctx, scrollCtrl) => Container(
        decoration: BoxDecoration(
          color: isDark ? AppTheme.surfaceDark : AppTheme.surfaceLight,
          borderRadius: const BorderRadius.vertical(top: Radius.circular(20)),
          border: Border(
            top: BorderSide(
              color: isDark
                  ? Colors.white.withOpacity(0.08)
                  : Colors.black.withOpacity(0.07),
            ),
          ),
        ),
        child: Column(
          children: [
            // ── Drag handle ──────────────────────────────────────
            Center(
              child: Container(
                margin: const EdgeInsets.only(top: 10, bottom: 8),
                width: 40, height: 4,
                decoration: BoxDecoration(
                  color: theme.colorScheme.onSurface.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),

            // ── Header ───────────────────────────────────────────
            Padding(
              padding: const EdgeInsets.fromLTRB(20, 4, 12, 12),
              child: Row(
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Text(
                              word.fr,
                              style: theme.textTheme.headlineMedium?.copyWith(
                                fontWeight: FontWeight.w800,
                                fontSize: 22,
                              ),
                            ),
                            const SizedBox(width: 10),
                            _Badge(word.level, isLevel: true),
                            const SizedBox(width: 6),
                            _Badge(word.type, isLevel: false),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Text(
                          word.en,
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: theme.colorScheme.onSurface.withOpacity(0.6),
                          ),
                        ),
                        if (word.example.isNotEmpty) ...[
                          const SizedBox(height: 6),
                          Text(
                            word.example,
                            style: theme.textTheme.bodySmall?.copyWith(
                              fontStyle: FontStyle.italic,
                              fontSize: 12.5,
                            ),
                          ),
                        ],
                      ],
                    ),
                  ),
                  // TTS button
                  IconButton(
                    icon: Icon(Icons.volume_up_rounded,
                        color: theme.colorScheme.primary, size: 28),
                    onPressed: () async {
                      await TtsService.instance.setRate(ttsSpeed);
                      await TtsService.instance.speak(word.fr);
                    },
                  ),
                  IconButton(
                    icon: const Icon(Icons.close_rounded),
                    onPressed: () => Navigator.of(ctx).pop(),
                  ),
                ],
              ),
            ),
            const Divider(height: 1),

            // ── Conjugation table ─────────────────────────────────
            if (word.isVerb && word.conj != null)
              Expanded(
                child: SingleChildScrollView(
                  controller: scrollCtrl,
                  padding: const EdgeInsets.all(16),
                  child: _ConjTable(word: word),
                ),
              )
            else
              Padding(
                padding: const EdgeInsets.all(24),
                child: Text(
                  'No conjugation table for ${word.type}s.',
                  style: theme.textTheme.bodyMedium?.copyWith(
                    color: theme.colorScheme.onSurface.withOpacity(0.5),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}

// ── Conjugation table ──────────────────────────────────────────
class _ConjTable extends StatelessWidget {
  final Word word;
  const _ConjTable({required this.word});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final headerBg = AppTheme.coral.withOpacity(isDark ? 0.15 : 0.08);

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder(
          horizontalInside: BorderSide(
              color: theme.colorScheme.onSurface.withOpacity(0.07)),
          verticalInside: BorderSide(
              color: theme.colorScheme.onSurface.withOpacity(0.07)),
        ),
        defaultColumnWidth: const IntrinsicColumnWidth(),
        children: [
          // Header row
          TableRow(
            decoration: BoxDecoration(color: headerBg),
            children: [
              _Cell('Pronoun', isHeader: true),
              ...kTenses.map((t) => _Cell(t, isHeader: true)),
            ],
          ),
          // Data rows
          ...List.generate(kPronouns.length, (pi) {
            return TableRow(
              decoration: BoxDecoration(
                color: pi.isEven
                    ? theme.colorScheme.onSurface.withOpacity(0.02)
                    : Colors.transparent,
              ),
              children: [
                _Cell(kPronouns[pi], isPronoun: true),
                ...List.generate(kTenses.length, (ti) {
                  final forms = word.conj![ti];
                  return _Cell(pi < forms.length ? forms[pi] : '—');
                }),
              ],
            );
          }),
        ],
      ),
    );
  }
}

class _Cell extends StatelessWidget {
  final String text;
  final bool isHeader;
  final bool isPronoun;
  const _Cell(this.text, {this.isHeader = false, this.isPronoun = false});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 7),
      child: Text(
        text,
        style: TextStyle(
          fontSize: isHeader ? 10 : 13,
          fontWeight: isHeader || isPronoun ? FontWeight.w700 : FontWeight.w400,
          color: isHeader
              ? AppTheme.coral
              : isPronoun
                  ? theme.colorScheme.onSurface.withOpacity(0.55)
                  : theme.colorScheme.onSurface,
          letterSpacing: isHeader ? 0.5 : 0,
        ),
      ),
    );
  }
}

// ── Small badge widget ─────────────────────────────────────────
class _Badge extends StatelessWidget {
  final String text;
  final bool isLevel;
  const _Badge(this.text, {required this.isLevel});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    final color = isLevel
        ? (text == 'A1' ? cs.primary : cs.secondary)
        : switch (text) {
            'verb'      => AppTheme.coral,
            'noun'      => AppTheme.gold,
            'adjective' => AppTheme.purple,
            'adverb'    => AppTheme.blue,
            _           => cs.primary,
          };

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 7, vertical: 2),
      decoration: BoxDecoration(
        color: color.withOpacity(0.12),
        borderRadius: BorderRadius.circular(4),
        border: Border.all(color: color.withOpacity(0.3)),
      ),
      child: Text(
        isLevel ? text : _cap(text),
        style: TextStyle(
          fontSize: 10,
          fontWeight: FontWeight.w800,
          color: color,
          letterSpacing: 0.3,
        ),
      ),
    );
  }

  String _cap(String s) => s.isEmpty ? s : s[0].toUpperCase() + s.substring(1);
}
