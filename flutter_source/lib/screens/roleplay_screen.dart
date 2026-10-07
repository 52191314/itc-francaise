import 'dart:async';
import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/roleplay_data.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/course_portal_button.dart';
import '../services/tts_service.dart';

class RoleplayScreen extends StatefulWidget {
  const RoleplayScreen({super.key});

  @override
  State<RoleplayScreen> createState() => _RoleplayScreenState();
}

class _RoleplayScreenState extends State<RoleplayScreen>
    with SingleTickerProviderStateMixin {
  late TabController _tabs;
  String _search = '';

  // Étape 3 (Interaction) was cancelled by the teacher.
  // Only Étape 1 (Entretien) and Étape 2 (Monologue) remain.
  static const _entretienPrep = 30;   // 30 s prep
  static const _entretienOral = 90;   // 90 s oral
  static const _monologuePrep = 600;  // 10 min prep (cheatsheet time)
  static const _monologueOral = 240;  // 4 min oral passage

  @override
  void initState() {
    super.initState();
    _tabs = TabController(length: 2, vsync: this);
  }

  @override
  void dispose() {
    _tabs.dispose();
    super.dispose();
  }

  List<RoleplayTopic> _filtered(List<RoleplayTopic> all) {
    if (_search.isEmpty) return all;
    final q = _search.toLowerCase();
    return all
        .where((t) =>
            t.title.toLowerCase().contains(q) ||
            t.keywords.any((k) => k.toLowerCase().contains(q)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Roleplay'),
        actions: const [CoursePortalButton()],
        bottom: TabBar(
          controller: _tabs,
          tabs: const [
            Tab(text: 'Étape 1 · Entretien'),
            Tab(text: 'Étape 2 · Monologue'),
          ],
          labelColor: theme.colorScheme.primary,
          unselectedLabelColor: theme.colorScheme.onSurface.withOpacity(0.5),
          indicatorColor: theme.colorScheme.primary,
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(12, 8, 12, 4),
            child: TextField(
              onChanged: (v) => setState(() => _search = v),
              decoration: const InputDecoration(
                hintText: 'Search topics...',
                prefixIcon: Icon(Icons.search_rounded, size: 20),
                isDense: true,
                contentPadding:
                    EdgeInsets.symmetric(vertical: 10, horizontal: 12),
              ),
            ),
          ),
          Expanded(
            child: TabBarView(
              controller: _tabs,
              children: [
                _TopicList(
                  topics: _filtered(kEntretienTopics),
                  prepSecs: _entretienPrep,
                  oralSecs: _entretienOral,
                ),
                _TopicList(
                  topics: _filtered(kMonologueTopics),
                  prepSecs: _monologuePrep,
                  oralSecs: _monologueOral,
                  stageNote: '⚠️ Étape 3 annulée · Étape 2 étendue à 4 min',
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// ── Topic list ─────────────────────────────────────────────────
class _TopicList extends StatelessWidget {
  final List<RoleplayTopic> topics;
  final int prepSecs;
  final int oralSecs;
  final String? stageNote;
  const _TopicList({
    required this.topics,
    required this.prepSecs,
    required this.oralSecs,
    this.stageNote,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    if (topics.isEmpty) {
      return Center(
        child: Text('No topics found',
            style: theme.textTheme.bodyMedium?.copyWith(
                color: theme.colorScheme.onSurface.withOpacity(0.4))),
      );
    }
    return ListView.separated(
      padding: const EdgeInsets.all(12),
      itemCount: topics.length + (stageNote != null ? 1 : 0),
      separatorBuilder: (_, __) => const SizedBox(height: 8),
      itemBuilder: (ctx, i) {
        // First item: optional stage note banner
        if (stageNote != null && i == 0) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
            decoration: BoxDecoration(
              color: AppTheme.gold.withOpacity(0.12),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
              border: Border.all(color: AppTheme.gold.withOpacity(0.35)),
            ),
            child: Text(
              stageNote!,
              style: theme.textTheme.bodySmall?.copyWith(
                color: AppTheme.gold,
                fontWeight: FontWeight.w600,
              ),
            ),
          );
        }
        final topicIdx = stageNote != null ? i - 1 : i;
        return _TopicCard(
          topic: topics[topicIdx],
          index: topicIdx,
          prepSecs: prepSecs,
          oralSecs: oralSecs,
        );
      },
    );
  }
}

// ── Topic card ─────────────────────────────────────────────────
class _TopicCard extends StatelessWidget {
  final RoleplayTopic topic;
  final int index;
  final int prepSecs;
  final int oralSecs;
  const _TopicCard({
    required this.topic,
    required this.index,
    required this.prepSecs,
    required this.oralSecs,
  });

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: InkWell(
        borderRadius: BorderRadius.circular(AppTheme.radius),
        onTap: () => Navigator.of(context).push(
          MaterialPageRoute(
            builder: (_) => _TopicDetailScreen(
              topic: topic,
              prepSecs: prepSecs,
              oralSecs: oralSecs,
            ),
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Row(
            children: [
              Container(
                width: 44,
                height: 44,
                decoration: BoxDecoration(
                  color: AppTheme.coral.withOpacity(0.12),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                ),
                child: Center(
                  child: Text(
                    topic.number.toString().padLeft(2, '0'),
                    style: const TextStyle(
                      color: AppTheme.coral,
                      fontWeight: FontWeight.w800,
                      fontSize: 15,
                    ),
                  ),
                ),
              ),
              const SizedBox(width: 14),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(topic.title,
                        style: theme.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w700,
                            color: theme.colorScheme.onSurface)),
                    const SizedBox(height: 4),
                    Wrap(
                      spacing: 4,
                      children: topic.keywords
                          .take(3)
                          .map((k) => Container(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 6, vertical: 1),
                                decoration: BoxDecoration(
                                  color: theme.colorScheme.onSurface
                                      .withOpacity(0.06),
                                  borderRadius: BorderRadius.circular(4),
                                ),
                                child: Text(k,
                                    style: theme.textTheme.bodySmall
                                        ?.copyWith(fontSize: 10.5)),
                              ))
                          .toList(),
                    ),
                  ],
                ),
              ),
              Icon(Icons.chevron_right_rounded,
                  color: theme.colorScheme.onSurface.withOpacity(0.3)),
            ],
          ),
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: index * 30))
        .fadeIn(duration: 200.ms)
        .slideX(begin: 0.05);
  }
}

// ── Topic detail with timer ────────────────────────────────────
class _TopicDetailScreen extends StatefulWidget {
  final RoleplayTopic topic;
  final int prepSecs;
  final int oralSecs;
  const _TopicDetailScreen({
    required this.topic,
    required this.prepSecs,
    required this.oralSecs,
  });

  @override
  State<_TopicDetailScreen> createState() => _TopicDetailScreenState();
}

class _TopicDetailScreenState extends State<_TopicDetailScreen> {
  late int _seconds;
  bool _running = false;
  bool _isPrepPhase = true;
  double _speed = 0.85;
  bool _writingPadOpen = true;
  late TextEditingController _writingCtrl;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _seconds = widget.prepSecs;
    _writingCtrl = TextEditingController();
  }

  // Turn red only in the last 30 s (works for both short and long phases)
  Color get _timerColor {
    if (_seconds > 60) return Theme.of(context).colorScheme.primary;
    if (_seconds > 15) return AppTheme.gold;
    return AppTheme.coral;
  }

  void _startTimer() {
    _timer?.cancel();
    setState(() {
      _running = true;
    });
    _timer = Timer.periodic(const Duration(seconds: 1), (t) {
      if (_seconds <= 0) {
        if (_isPrepPhase) {
          setState(() {
            _isPrepPhase = false;
            _seconds = widget.oralSecs;
          });
        } else {
          t.cancel();
          setState(() {
            _running = false;
          });
        }
      } else {
        setState(() => _seconds--);
      }
    });
  }

  void _reset() {
    _timer?.cancel();
    setState(() {
      _running = false;
      _isPrepPhase = true;
      _seconds = widget.prepSecs;
    });
  }

  @override
  void dispose() {
    _timer?.cancel();
    TtsService.instance.stop();
    _writingCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final mins = (_seconds ~/ 60).toString().padLeft(2, '0');
    final secs = (_seconds % 60).toString().padLeft(2, '0');
    final cs = theme.colorScheme;

    return Scaffold(
      appBar: AppBar(
        title: Text('Topic ${widget.topic.number}'),
        actions: const [CoursePortalButton()],
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(16),
              children: [
                // Title
                Text(widget.topic.title,
                        style: theme.textTheme.headlineSmall
                            ?.copyWith(fontWeight: FontWeight.w800))
                    .animate()
                    .fadeIn(duration: 300.ms),
                const SizedBox(height: 16),

                // ── Timer card ─────────────────────────────────────────
                Card(
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            _PhaseChip('Prép', _isPrepPhase, widget.prepSecs),
                            const Icon(Icons.arrow_forward_rounded, size: 16),
                            _PhaseChip('Oral', !_isPrepPhase, widget.oralSecs),
                          ],
                        ),
                        const SizedBox(height: 20),
                        AnimatedDefaultTextStyle(
                          duration: 300.ms,
                          style: TextStyle(
                            fontSize: 64,
                            fontWeight: FontWeight.w900,
                            color: _timerColor,
                            fontFamily: 'Inter',
                          ),
                          child: Text('$mins:$secs'),
                        ),
                        const SizedBox(height: 20),
                        Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                          if (!_running)
                            FilledButton.icon(
                              onPressed: _startTimer,
                              icon: const Icon(Icons.play_arrow_rounded),
                              label: Text(_isPrepPhase ? 'Start Prep' : 'Start Oral'),
                            )
                          else
                            OutlinedButton.icon(
                              onPressed: _reset,
                              icon: const Icon(Icons.stop_rounded),
                              label: const Text('Reset'),
                            ),
                        ]),
                      ],
                    ),
                  ),
                ).animate().fadeIn(duration: 300.ms, delay: 100.ms),

                const SizedBox(height: 16),

                // ── Model answer ───────────────────────────────────────
                if (widget.topic.script.isNotEmpty) ...[
                  ExpansionTile(
                    title: Text('Model Answer',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    leading: const Icon(Icons.article_rounded),
                    children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(16, 0, 16, 16),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            SelectableText.rich(
                              TextSpan(
                                children: _highlightKeywords(
                                  widget.topic.script,
                                  [
                                    ...widget.topic.keywords,
                                    ...widget.topic.phrases
                                        .map((p) => p
                                            .replaceAll('…', '')
                                            .replaceAll('...', '')
                                            .trim())
                                        .where((p) => p.length > 3)
                                  ],
                                  theme.textTheme.bodyMedium!.copyWith(height: 1.6),
                                  theme.textTheme.bodyMedium!.copyWith(
                                    height: 1.6,
                                    fontWeight: FontWeight.bold,
                                    color: theme.colorScheme.primary,
                                    backgroundColor:
                                        theme.colorScheme.primary.withOpacity(0.12),
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 12),
                            const Divider(height: 1),
                            const SizedBox(height: 8),
                            Row(
                              children: [
                                IconButton.filledTonal(
                                  onPressed: () async {
                                    await TtsService.instance.setRate(_speed);
                                    await TtsService.instance.speak(widget.topic.script);
                                  },
                                  icon: const Icon(Icons.volume_up_rounded),
                                  tooltip: 'Listen to monologue',
                                ),
                                const SizedBox(width: 8),
                                IconButton.filledTonal(
                                  onPressed: () async {
                                    await TtsService.instance.stop();
                                  },
                                  icon: const Icon(Icons.stop_rounded),
                                  tooltip: 'Stop listening',
                                ),
                                const SizedBox(width: 12),
                                Expanded(
                                  child: Row(
                                    children: [
                                      Icon(Icons.speed_rounded,
                                          size: 16,
                                          color: theme.colorScheme.onSurface
                                              .withOpacity(0.6)),
                                      const SizedBox(width: 6),
                                      Text(
                                        'Speed: ${_speed.toStringAsFixed(2)}x',
                                        style: theme.textTheme.bodySmall?.copyWith(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 11,
                                        ),
                                      ),
                                      Expanded(
                                        child: SizedBox(
                                          height: 30,
                                          child: Slider(
                                            value: _speed,
                                            min: 0.4,
                                            max: 1.2,
                                            divisions: 16,
                                            onChanged: (val) {
                                              setState(() {
                                                _speed = val;
                                              });
                                            },
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],

                // ── Useful phrases ─────────────────────────────────────
                if (widget.topic.phrases.isNotEmpty) ...[
                  const SizedBox(height: 8),
                  Text('Useful Phrases',
                      style: theme.textTheme.titleMedium
                      ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),
                  ...widget.topic.phrases.map((p) => Card(
                        margin: const EdgeInsets.only(bottom: 6),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 14, vertical: 10),
                          child: SelectableText(p,
                              style: theme.textTheme.bodyMedium
                                  ?.copyWith(fontStyle: FontStyle.italic)),
                        ),
                      )),
                ],
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
                Icon(Icons.edit_note_rounded, color: cs.primary, size: 20),
                const SizedBox(width: 8),
                Text(
                  'Open Practice Writing Pad',
                  style: theme.textTheme.titleSmall?.copyWith(
                    color: cs.primary,
                    fontWeight: FontWeight.w700,
                    fontSize: 13.0,
                  ),
                ),
                const Spacer(),
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
                  Icon(Icons.edit_note_rounded, color: cs.primary, size: 18),
                  const SizedBox(width: 6),
                  Text(
                    'Practice Writing Pad',
                    style: theme.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700,
                      fontSize: 13.0,
                    ),
                  ),
                  const Spacer(),
                  IconButton(
                    icon: Icon(Icons.delete_sweep_rounded,
                        color: cs.onSurface.withOpacity(0.4), size: 18),
                    onPressed: () {
                      _writingCtrl.clear();
                    },
                    tooltip: 'Clear text',
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
                controller: _writingCtrl,
                maxLines: 4,
                style: theme.textTheme.bodyMedium?.copyWith(fontSize: 13.5),
                decoration: InputDecoration(
                  hintText: 'Type here to practice active recall while reading...',
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

class _PhaseChip extends StatelessWidget {
  final String label;
  final bool active;
  final int seconds;
  const _PhaseChip(this.label, this.active, this.seconds);

  String get _displayTime {
    final m = seconds ~/ 60;
    final s = seconds % 60;
    if (m == 0) return '${s}s';
    if (s == 0) return '${m} min';
    return '${m}m ${s}s';
  }

  @override
  Widget build(BuildContext context) {
    final color = active
        ? AppTheme.coral
        : Theme.of(context).colorScheme.onSurface.withOpacity(0.3);
    return Column(children: [
      Text(label,
          style: TextStyle(
              color: color, fontWeight: FontWeight.w700, fontSize: 12)),
      Text(_displayTime,
          style: TextStyle(color: color.withOpacity(0.7), fontSize: 10)),
    ]);
  }
}

List<TextSpan> _highlightKeywords(
    String text,
    List<String> highlights,
    TextStyle normalStyle,
    TextStyle highlightStyle) {
  if (highlights.isEmpty || text.isEmpty) {
    return [TextSpan(text: text, style: normalStyle)];
  }

  final escaped = highlights
      .map((h) => h.trim())
      .where((h) => h.isNotEmpty)
      .map((h) => RegExp.escape(h))
      .toList();

  if (escaped.isEmpty) {
    return [TextSpan(text: text, style: normalStyle)];
  }

  escaped.sort((a, b) => b.length.compareTo(a.length));

  final pattern = escaped.join('|');
  final regex = RegExp(pattern, caseSensitive: false);

  final List<TextSpan> spans = [];
  int start = 0;

  final matches = regex.allMatches(text);
  for (final match in matches) {
    if (match.start > start) {
      spans.add(TextSpan(
        text: text.substring(start, match.start),
        style: normalStyle,
      ));
    }
    spans.add(TextSpan(
      text: text.substring(match.start, match.end),
      style: highlightStyle,
    ));
    start = match.end;
  }

  if (start < text.length) {
    spans.add(TextSpan(
      text: text.substring(start),
      style: normalStyle,
    ));
  }

  return spans;
}
