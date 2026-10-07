import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../models/session.dart';
import '../services/db_service.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/course_portal_button.dart';

class ProgressScreen extends StatefulWidget {
  const ProgressScreen({super.key});

  @override
  State<ProgressScreen> createState() => _ProgressScreenState();
}

class _ProgressScreenState extends State<ProgressScreen> {
  Map<String, dynamic> _stats = {};
  List<StudySession> _sessions = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    _load();
  }

  Future<void> _load() async {
    final stats = await DbService.instance.getSessionStats();
    final sessions = await DbService.instance.getSessions(limit: 20);
    if (mounted) {
      setState(() {
        _stats = stats;
        _sessions = sessions;
        _loading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;

    return Scaffold(
      drawer: const AppDrawer(),
      appBar: AppBar(
        title: const Text('Progress'),
        actions: [
          IconButton(
            icon: const Icon(Icons.refresh_rounded),
            onPressed: () {
              setState(() => _loading = true);
              _load();
            },
          ),
          const CoursePortalButton(),
        ],
      ),
      body: _loading
          ? const Center(child: CircularProgressIndicator())
          : RefreshIndicator(
              onRefresh: _load,
              child: ListView(
                padding: const EdgeInsets.all(16),
                children: [
                  // ── Summary stat cards ──────────────────────────
                  GridView.count(
                    crossAxisCount: 2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.6,
                    children: [
                      _StatCard(
                        icon: Icons.local_fire_department_rounded,
                        label: 'Day Streak',
                        value: '${_stats['streak_days'] ?? 0}',
                        color: AppTheme.coral,
                      ),
                      _StatCard(
                        icon: Icons.today_rounded,
                        label: 'Today',
                        value: '${_stats['today_sessions'] ?? 0} sessions',
                        color: cs.primary,
                      ),
                      _StatCard(
                        icon: Icons.check_circle_rounded,
                        label: 'Total Correct',
                        value: '${_stats['total_correct'] ?? 0}',
                        color: Colors.green,
                      ),
                      _StatCard(
                        icon: Icons.quiz_rounded,
                        label: 'Total Sessions',
                        value: '${_stats['total_sessions'] ?? 0}',
                        color: AppTheme.blue,
                      ),
                    ],
                  ).animate().fadeIn(duration: 400.ms),

                  const SizedBox(height: 24),

                  // ── Accuracy bar ────────────────────────────────
                  if ((_stats['total_answered'] ?? 0) > 0) ...[
                    Text('Overall Accuracy',
                        style: theme.textTheme.titleMedium
                            ?.copyWith(fontWeight: FontWeight.w700)),
                    const SizedBox(height: 8),
                    _AccuracyBar(
                      correct: (_stats['total_correct'] as num?)?.toInt() ?? 0,
                      answered:
                          (_stats['total_answered'] as num?)?.toInt() ?? 0,
                    ),
                    const SizedBox(height: 24),
                  ],

                  // ── Recent sessions ─────────────────────────────
                  Text('Recent Sessions',
                      style: theme.textTheme.titleMedium
                          ?.copyWith(fontWeight: FontWeight.w700)),
                  const SizedBox(height: 8),

                  if (_sessions.isEmpty)
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 24),
                      child: Center(
                        child: Text(
                            'No sessions yet.\nStart a Flashcard or Quiz session!',
                            textAlign: TextAlign.center,
                            style: theme.textTheme.bodyMedium?.copyWith(
                                color: cs.onSurface.withOpacity(0.4))),
                      ),
                    )
                  else
                    ...List.generate(
                      _sessions.length,
                      (i) => _SessionTile(session: _sessions[i])
                          .animate(delay: Duration(milliseconds: i * 40))
                          .fadeIn(duration: 200.ms)
                          .slideX(begin: 0.05),
                    ),
                ],
              ),
            ),
    );
  }
}

class _StatCard extends StatelessWidget {
  final IconData icon;
  final String label, value;
  final Color color;
  const _StatCard(
      {required this.icon,
      required this.label,
      required this.value,
      required this.color});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Icon(icon, color: color, size: 22),
            const Spacer(),
            Text(value,
                style: theme.textTheme.titleLarge?.copyWith(
                    fontWeight: FontWeight.w800, color: color, fontSize: 18)),
            Text(label,
                style: theme.textTheme.bodySmall?.copyWith(fontSize: 11)),
          ],
        ),
      ),
    );
  }
}

class _AccuracyBar extends StatelessWidget {
  final int correct, answered;
  const _AccuracyBar({required this.correct, required this.answered});

  @override
  Widget build(BuildContext context) {
    final pct = answered > 0 ? correct / answered : 0.0;
    final theme = Theme.of(context);
    final color = pct >= 0.8
        ? Colors.green
        : pct >= 0.5
            ? AppTheme.gold
            : AppTheme.coral;

    return Card(
      child: Padding(
        padding: const EdgeInsets.all(14),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text('$correct / $answered answers',
                    style: theme.textTheme.bodySmall),
                Text('${(pct * 100).round()}%',
                    style: TextStyle(
                        color: color,
                        fontWeight: FontWeight.w800,
                        fontSize: 16)),
              ],
            ),
            const SizedBox(height: 8),
            ClipRRect(
              borderRadius: BorderRadius.circular(4),
              child: LinearProgressIndicator(
                value: pct,
                backgroundColor: theme.colorScheme.onSurface.withOpacity(0.08),
                valueColor: AlwaysStoppedAnimation(color),
                minHeight: 8,
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _SessionTile extends StatelessWidget {
  final StudySession session;
  const _SessionTile({required this.session});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final color = session.score >= 0.8
        ? Colors.green
        : session.score >= 0.5
            ? AppTheme.gold
            : AppTheme.coral;
    final icon =
        session.type == 'flashcard' ? Icons.style_rounded : Icons.quiz_rounded;
    final date =
        '${session.createdAt.day}/${session.createdAt.month}/${session.createdAt.year}';

    return Card(
      margin: const EdgeInsets.only(bottom: 8),
      child: ListTile(
        leading: CircleAvatar(
          backgroundColor: color.withOpacity(0.15),
          child: Icon(icon, color: color, size: 20),
        ),
        title: Text(
          '${session.type == 'flashcard' ? 'Flashcards' : 'Quiz'} · ${session.level.toUpperCase()}',
          style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
        ),
        subtitle: Text(date, style: theme.textTheme.bodySmall),
        trailing: Text(
          '${session.correct}/${session.total} (${session.scorePercent}%)',
          style: TextStyle(
              color: color, fontWeight: FontWeight.w700, fontSize: 13),
        ),
      ),
    );
  }
}
