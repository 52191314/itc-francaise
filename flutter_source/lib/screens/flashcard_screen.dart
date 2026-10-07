import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/vocab_data.dart';
import '../models/word.dart';
import '../models/session.dart';
import '../services/db_service.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/course_portal_button.dart';

class FlashcardScreen extends StatefulWidget {
  const FlashcardScreen({super.key});

  @override
  State<FlashcardScreen> createState() => _FlashcardScreenState();
}

class _FlashcardScreenState extends State<FlashcardScreen> {
  // ── Config state ─────────────────────────────────────────────
  bool _configured = false;
  String _level = 'all';
  String _type = 'all';
  int _count = 20;

  // ── Session state ─────────────────────────────────────────────
  List<Word> _deck = [];
  int _cardIndex = 0;
  int _correct = 0;
  bool _answered = false;
  int? _chosenIdx;
  List<String> _choices = [];
  bool _done = false;

  final _rng = Random();

  // ── Build deck ────────────────────────────────────────────────
  void _startSession() {
    var pool = kVocab.where((w) {
      if (_level != 'all' && w.level.toLowerCase() != _level.toLowerCase()) {
        return false;
      }
      if (_type != 'all' && w.type.toLowerCase() != _type) return false;
      return true;
    }).toList()
      ..shuffle(_rng);

    if (pool.length > _count) pool = pool.sublist(0, _count);
    setState(() {
      _deck = pool;
      _cardIndex = 0;
      _correct = 0;
      _answered = false;
      _chosenIdx = null;
      _done = false;
      _configured = true;
      _buildChoices();
    });
  }

  void _buildChoices() {
    if (_deck.isEmpty) return;
    final correct = _deck[_cardIndex];
    final distractors = (kVocab.where((w) => w != correct).toList()
          ..shuffle(_rng))
        .take(3)
        .map((w) => w.en)
        .toList();
    _choices = [...distractors, correct.en]..shuffle(_rng);
  }

  void _answer(int idx) {
    if (_answered) return;
    final isCorrect = _choices[idx] == _deck[_cardIndex].en;
    setState(() {
      _answered = true;
      _chosenIdx = idx;
      if (isCorrect) _correct++;
    });
    DbService.instance.recordWordResult(_deck[_cardIndex].fr, isCorrect);
  }

  void _next() {
    if (_cardIndex + 1 >= _deck.length) {
      // Save session
      DbService.instance.insertSession(StudySession(
        type: 'flashcard',
        level: _level,
        total: _deck.length,
        correct: _correct,
        createdAt: DateTime.now(),
      ));
      setState(() => _done = true);
    } else {
      setState(() {
        _cardIndex++;
        _answered = false;
        _chosenIdx = null;
        _buildChoices();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Flashcards'),
        actions: [
          if (_configured && !_done)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Text(
                  '${_cardIndex + 1} / ${_deck.length}',
                  style: TextStyle(
                    color: Theme.of(context).colorScheme.primary,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
            ),
          const CoursePortalButton(),
        ],
      ),
      body: _done
          ? _ResultScreen(
              correct: _correct,
              total: _deck.length,
              onRestart: () => setState(() {
                _configured = false;
                _done = false;
              }),
            )
          : !_configured
              ? _ConfigScreen(
                  level: _level,
                  type: _type,
                  count: _count,
                  onLevelChanged: (v) => setState(() => _level = v),
                  onTypeChanged: (v) => setState(() => _type = v),
                  onCountChanged: (v) => setState(() => _count = v),
                  onStart: _startSession,
                )
              : _SessionView(
                  deck: _deck,
                  cardIndex: _cardIndex,
                  choices: _choices,
                  answered: _answered,
                  chosenIdx: _chosenIdx,
                  onAnswer: _answer,
                  onNext: _next,
                ),
    );
  }
}

// ── Config screen ──────────────────────────────────────────────
class _ConfigScreen extends StatelessWidget {
  final String level, type;
  final int count;
  final ValueChanged<String> onLevelChanged, onTypeChanged;
  final ValueChanged<int> onCountChanged;
  final VoidCallback onStart;

  const _ConfigScreen({
    required this.level,
    required this.type,
    required this.count,
    required this.onLevelChanged,
    required this.onTypeChanged,
    required this.onCountChanged,
    required this.onStart,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    Widget section(String title, Widget child) => Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(title,
                style: theme.textTheme.labelSmall?.copyWith(
                    color: cs.onSurface.withOpacity(0.5),
                    fontWeight: FontWeight.w700)),
            const SizedBox(height: 8),
            child,
            const SizedBox(height: 20),
          ],
        );

    Widget chip(String val, String label, String current,
            ValueChanged<String> fn) =>
        Padding(
          padding: const EdgeInsets.only(right: 8),
          child: FilterChip(
            label: Text(label),
            selected: current == val,
            selectedColor: cs.primary.withOpacity(0.15),
            checkmarkColor: cs.primary,
            onSelected: (_) => fn(val),
          ),
        );

    return SingleChildScrollView(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Configure Session',
              style: theme.textTheme.headlineSmall
                  ?.copyWith(fontWeight: FontWeight.w800)),
          const SizedBox(height: 24),
          section(
              'Level',
              Row(children: [
                chip('all', 'All levels', level, onLevelChanged),
                chip('a1', 'A1', level, onLevelChanged),
                chip('a2', 'A2', level, onLevelChanged),
              ])),
          section(
              'Word type',
              Wrap(children: [
                chip('all', 'All', type, onTypeChanged),
                chip('verb', 'Verbs', type, onTypeChanged),
                chip('noun', 'Nouns', type, onTypeChanged),
                chip('adjective', 'Adjectives', type, onTypeChanged),
                chip('adverb', 'Adverbs', type, onTypeChanged),
              ])),
          section(
              'Cards per session',
              Wrap(
                  spacing: 8,
                  children: [10, 20, 50, 100]
                      .map(
                        (n) => ChoiceChip(
                          label: Text('$n'),
                          selected: count == n,
                          selectedColor: cs.primary.withOpacity(0.15),
                          onSelected: (_) => onCountChanged(n),
                        ),
                      )
                      .toList())),
          const SizedBox(height: 8),
          SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
              onPressed: onStart,
              icon: const Icon(Icons.play_arrow_rounded),
              label: const Text('Start Session'),
            ),
          ),
        ],
      ),
    );
  }
}

// ── Session view ───────────────────────────────────────────────
class _SessionView extends StatelessWidget {
  final List<Word> deck;
  final int cardIndex;
  final List<String> choices;
  final bool answered;
  final int? chosenIdx;
  final ValueChanged<int> onAnswer;
  final VoidCallback onNext;

  const _SessionView({
    required this.deck,
    required this.cardIndex,
    required this.choices,
    required this.answered,
    required this.chosenIdx,
    required this.onAnswer,
    required this.onNext,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final word = deck[cardIndex];
    final correct = choices.indexOf(word.en);

    return Column(
      children: [
        // Progress bar
        LinearProgressIndicator(
          value: (cardIndex + 1) / deck.length,
          backgroundColor: cs.onSurface.withOpacity(0.08),
          valueColor: AlwaysStoppedAnimation(cs.primary),
          minHeight: 3,
        ),

        Expanded(
          child: Padding(
            padding: const EdgeInsets.all(20),
            child: Column(
              children: [
                // ── Word card ──────────────────────────────────
                Expanded(
                  flex: 2,
                  child: Card(
                    child: Container(
                      width: double.infinity,
                      padding: const EdgeInsets.all(24),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 8, vertical: 3),
                            decoration: BoxDecoration(
                              color: cs.primary.withOpacity(0.1),
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Text(
                              word.level,
                              style: TextStyle(
                                  color: cs.primary,
                                  fontSize: 11,
                                  fontWeight: FontWeight.w800),
                            ),
                          ),
                          const SizedBox(height: 16),
                          Text(
                            word.fr,
                            style: theme.textTheme.displaySmall?.copyWith(
                              fontWeight: FontWeight.w800,
                            ),
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            word.type,
                            style: theme.textTheme.bodySmall,
                          ),
                          const SizedBox(height: 16),
                          IconButton.outlined(
                            icon: const Icon(Icons.volume_up_rounded),
                            onPressed: () => TtsService.instance.speak(word.fr),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),

                const SizedBox(height: 16),

                // ── Choices ────────────────────────────────────
                Expanded(
                  flex: 3,
                  child: Column(
                    children: List.generate(choices.length, (i) {
                      Color? bg;
                      Color? border;
                      if (answered) {
                        if (i == correct) {
                          bg = Colors.green.withOpacity(0.15);
                          border = Colors.green;
                        } else if (i == chosenIdx && i != correct) {
                          bg = AppTheme.coral.withOpacity(0.15);
                          border = AppTheme.coral;
                        }
                      }
                      return Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(bottom: 10),
                          child: GestureDetector(
                            onTap: () => onAnswer(i),
                            child: AnimatedContainer(
                              duration: const Duration(milliseconds: 200),
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                color: bg ?? theme.cardTheme.color,
                                borderRadius:
                                    BorderRadius.circular(AppTheme.radiusSm),
                                border: Border.all(
                                  color:
                                      border ?? cs.onSurface.withOpacity(0.1),
                                  width: border != null ? 1.5 : 1,
                                ),
                              ),
                              child: Text(
                                choices[i],
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontWeight: FontWeight.w600,
                                  color: border ?? cs.onSurface,
                                ),
                              ),
                            ),
                          ),
                        ),
                      );
                    }),
                  ),
                ),

                // ── Next button ────────────────────────────────
                if (answered)
                  SizedBox(
                    width: double.infinity,
                    child: FilledButton.icon(
                      onPressed: onNext,
                      icon: const Icon(Icons.arrow_forward_rounded),
                      label: Text(cardIndex + 1 >= deck.length
                          ? 'See Results'
                          : 'Next'),
                    ),
                  ).animate().fadeIn(duration: 200.ms).slideY(begin: 0.2),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

// ── Result screen ──────────────────────────────────────────────
class _ResultScreen extends StatelessWidget {
  final int correct, total;
  final VoidCallback onRestart;
  const _ResultScreen(
      {required this.correct, required this.total, required this.onRestart});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final pct = total > 0 ? (correct / total * 100).round() : 0;
    final emoji = pct >= 80
        ? '🎉'
        : pct >= 50
            ? '👍'
            : '💪';

    return Center(
      child: Padding(
        padding: const EdgeInsets.all(32),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(emoji, style: const TextStyle(fontSize: 56)),
            const SizedBox(height: 16),
            Text('Session Complete!',
                style: theme.textTheme.headlineMedium
                    ?.copyWith(fontWeight: FontWeight.w800)),
            const SizedBox(height: 8),
            Text('$correct / $total correct ($pct%)',
                style: theme.textTheme.bodyLarge
                    ?.copyWith(color: cs.onSurface.withOpacity(0.6))),
            const SizedBox(height: 32),
            FilledButton.icon(
              onPressed: onRestart,
              icon: const Icon(Icons.replay_rounded),
              label: const Text('New Session'),
            ),
          ],
        )
            .animate()
            .fadeIn(duration: 400.ms)
            .scale(begin: const Offset(0.9, 0.9)),
      ),
    );
  }
}
