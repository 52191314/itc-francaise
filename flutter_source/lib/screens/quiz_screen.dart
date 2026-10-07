import 'dart:math';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/vocab_data.dart';
import '../models/word.dart';
import '../models/session.dart';
import '../services/db_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/course_portal_button.dart';

/// Simple quiz: given an English definition, type or pick the French word.
class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  bool _started = false;
  bool _done = false;
  String _level = 'all';
  int _count = 10;
  final _rng = Random();

  late List<Word> _questions;
  int _qi = 0;
  int _correct = 0;
  bool _answered = false;
  int? _chosenIdx;
  late List<String> _choices;

  void _start() {
    var pool = kVocab.where((w) {
      if (_level != 'all' && w.level.toLowerCase() != _level.toLowerCase()) {
        return false;
      }
      return true;
    }).toList()
      ..shuffle(_rng);
    if (pool.length > _count) pool = pool.sublist(0, _count);

    setState(() {
      _questions = pool;
      _qi = 0;
      _correct = 0;
      _answered = false;
      _chosenIdx = null;
      _done = false;
      _started = true;
      _buildChoices();
    });
  }

  void _buildChoices() {
    final correct = _questions[_qi];
    final others = (kVocab.where((w) => w != correct).toList()..shuffle(_rng))
        .take(3)
        .map((w) => w.fr)
        .toList();
    _choices = [...others, correct.fr]..shuffle(_rng);
  }

  void _pick(int idx) {
    if (_answered) return;
    final ok = _choices[idx] == _questions[_qi].fr;
    setState(() {
      _answered = true;
      _chosenIdx = idx;
      if (ok) _correct++;
    });
    DbService.instance.recordWordResult(_questions[_qi].fr, ok);
  }

  void _next() {
    if (_qi + 1 >= _questions.length) {
      DbService.instance.insertSession(StudySession(
        type: 'quiz',
        level: _level,
        total: _questions.length,
        correct: _correct,
        createdAt: DateTime.now(),
      ));
      setState(() => _done = true);
    } else {
      setState(() {
        _qi++;
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
        title: const Text('Quiz'),
        actions: [
          if (_started && !_done)
            Padding(
              padding: const EdgeInsets.only(right: 12),
              child: Center(
                child: Text(
                  '${_qi + 1}/$_count',
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
          ? _Result(
              correct: _correct,
              total: _questions.length,
              onRestart: () => setState(() {
                    _started = false;
                    _done = false;
                  }))
          : !_started
              ? _Config(
                  level: _level,
                  count: _count,
                  onLevel: (v) => setState(() => _level = v),
                  onCount: (v) => setState(() => _count = v),
                  onStart: _start)
              : _QuizView(
                  word: _questions[_qi],
                  choices: _choices,
                  answered: _answered,
                  chosenIdx: _chosenIdx,
                  onPick: _pick,
                  onNext: _next,
                  isLast: _qi + 1 >= _questions.length,
                  progress: (_qi + 1) / _questions.length),
    );
  }
}

class _Config extends StatelessWidget {
  final String level;
  final int count;
  final ValueChanged<String> onLevel;
  final ValueChanged<int> onCount;
  final VoidCallback onStart;
  const _Config(
      {required this.level,
      required this.count,
      required this.onLevel,
      required this.onCount,
      required this.onStart});

  @override
  Widget build(BuildContext context) {
    final cs = Theme.of(context).colorScheme;
    chip(String v, String l, String cur, ValueChanged<String> fn) => Padding(
        padding: const EdgeInsets.only(right: 8),
        child: FilterChip(
            label: Text(l),
            selected: cur == v,
            selectedColor: cs.primary.withOpacity(0.15),
            checkmarkColor: cs.primary,
            onSelected: (_) => fn(v)));

    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text('Quiz Settings',
            style: Theme.of(context)
                .textTheme
                .headlineSmall
                ?.copyWith(fontWeight: FontWeight.w800)),
        const SizedBox(height: 20),
        Text('LEVEL',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: cs.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Row(children: [
          chip('all', 'All', level, onLevel),
          chip('a1', 'A1', level, onLevel),
          chip('a2', 'A2', level, onLevel)
        ]),
        const SizedBox(height: 20),
        Text('QUESTIONS',
            style: Theme.of(context).textTheme.labelSmall?.copyWith(
                color: cs.onSurface.withOpacity(0.5),
                fontWeight: FontWeight.w700)),
        const SizedBox(height: 8),
        Wrap(
            spacing: 8,
            children: [5, 10, 20, 30]
                .map((n) => ChoiceChip(
                    label: Text('$n'),
                    selected: count == n,
                    selectedColor: cs.primary.withOpacity(0.15),
                    onSelected: (_) => onCount(n)))
                .toList()),
        const Spacer(),
        SizedBox(
            width: double.infinity,
            child: FilledButton.icon(
                onPressed: onStart,
                icon: const Icon(Icons.play_arrow_rounded),
                label: const Text('Start Quiz'))),
      ]),
    );
  }
}

class _QuizView extends StatelessWidget {
  final Word word;
  final List<String> choices;
  final bool answered;
  final int? chosenIdx;
  final ValueChanged<int> onPick;
  final VoidCallback onNext;
  final bool isLast;
  final double progress;
  const _QuizView(
      {required this.word,
      required this.choices,
      required this.answered,
      required this.chosenIdx,
      required this.onPick,
      required this.onNext,
      required this.isLast,
      required this.progress});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final correctIdx = choices.indexOf(word.fr);

    return Column(children: [
      LinearProgressIndicator(
          value: progress,
          minHeight: 3,
          backgroundColor: cs.onSurface.withOpacity(0.08),
          valueColor: AlwaysStoppedAnimation(cs.primary)),
      Expanded(
          child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(children: [
                Card(
                    child: Container(
                        width: double.infinity,
                        padding: const EdgeInsets.all(24),
                        child:
                            Column(mainAxisSize: MainAxisSize.min, children: [
                          Text('What is the French word for…',
                              style: theme.textTheme.bodySmall),
                          const SizedBox(height: 12),
                          Text(word.en,
                              style: theme.textTheme.headlineMedium
                                  ?.copyWith(fontWeight: FontWeight.w800)),
                          const SizedBox(height: 6),
                          Text('(${word.type} · ${word.level})',
                              style: theme.textTheme.bodySmall),
                        ]))),
                const SizedBox(height: 16),
                ...List.generate(choices.length, (i) {
                  Color? bg;
                  Color? border;
                  if (answered) {
                    if (i == correctIdx) {
                      bg = Colors.green.withOpacity(0.15);
                      border = Colors.green;
                    } else if (i == chosenIdx) {
                      bg = AppTheme.coral.withOpacity(0.15);
                      border = AppTheme.coral;
                    }
                  }
                  return Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: GestureDetector(
                          onTap: () => onPick(i),
                          child: AnimatedContainer(
                              duration: 200.ms,
                              width: double.infinity,
                              padding: const EdgeInsets.all(14),
                              decoration: BoxDecoration(
                                  color: bg ?? theme.cardTheme.color,
                                  borderRadius:
                                      BorderRadius.circular(AppTheme.radiusSm),
                                  border: Border.all(
                                      color: border ??
                                          cs.onSurface.withOpacity(0.1),
                                      width: border != null ? 1.5 : 1)),
                              child: Text(choices[i],
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                      fontWeight: FontWeight.w600,
                                      color: border ?? cs.onSurface)))));
                }),
                if (answered)
                  SizedBox(
                          width: double.infinity,
                          child: FilledButton.icon(
                              onPressed: onNext,
                              icon: const Icon(Icons.arrow_forward_rounded),
                              label: Text(isLast ? 'See Results' : 'Next')))
                      .animate()
                      .fadeIn(duration: 200.ms)
                      .slideY(begin: 0.2),
              ]))),
    ]);
  }
}

class _Result extends StatelessWidget {
  final int correct, total;
  final VoidCallback onRestart;
  const _Result(
      {required this.correct, required this.total, required this.onRestart});
  @override
  Widget build(BuildContext context) {
    final pct = total > 0 ? (correct / total * 100).round() : 0;
    return Center(
        child: Padding(
            padding: const EdgeInsets.all(32),
            child: Column(mainAxisSize: MainAxisSize.min, children: [
              Text(
                  pct >= 80
                      ? '🎉'
                      : pct >= 50
                          ? '👍'
                          : '💪',
                  style: const TextStyle(fontSize: 56)),
              const SizedBox(height: 12),
              Text('Quiz Complete!',
                  style: Theme.of(context)
                      .textTheme
                      .headlineMedium
                      ?.copyWith(fontWeight: FontWeight.w800)),
              const SizedBox(height: 8),
              Text('$correct / $total ($pct%)',
                  style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                      color: Theme.of(context)
                          .colorScheme
                          .onSurface
                          .withOpacity(0.6))),
              const SizedBox(height: 32),
              FilledButton.icon(
                  onPressed: onRestart,
                  icon: const Icon(Icons.replay_rounded),
                  label: const Text('Try Again')),
            ]).animate().fadeIn(duration: 400.ms)));
  }
}
