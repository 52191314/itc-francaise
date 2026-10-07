import 'package:flutter/material.dart';
import 'package:flutter_animate/flutter_animate.dart';

import '../data/grammar_data.dart';
import '../models/grammar_rule.dart';
import '../theme/app_theme.dart';
import '../widgets/app_drawer.dart';
import '../widgets/course_portal_button.dart';

class GrammarScreen extends StatefulWidget {
  const GrammarScreen({super.key});

  @override
  State<GrammarScreen> createState() => _GrammarScreenState();
}

class _GrammarScreenState extends State<GrammarScreen> {
  String _query = '';
  String _level = 'all';
  final _searchCtrl = TextEditingController();

  List<GrammarRule> get _filtered {
    return grammarRules.where((r) {
      if (_level != 'all' && r.level.toUpperCase() != _level.toUpperCase()) {
        return false;
      }
      if (_query.isEmpty) return true;
      final q = _query.toLowerCase();

      // Title & basic fields
      if (r.title.toLowerCase().contains(q)) return true;
      if (r.rule.toLowerCase().contains(q)) return true;
      if (r.pattern.toLowerCase().contains(q)) return true;
      if (r.note != null && r.note!.toLowerCase().contains(q)) return true;

      // Expanded details
      if (r.summary != null && r.summary!.toLowerCase().contains(q)) return true;
      if (r.explain != null && r.explain!.toLowerCase().contains(q)) return true;
      if (r.trap != null && r.trap!.toLowerCase().contains(q)) return true;

      // Steps
      if (r.steps != null &&
          r.steps!.any((step) => step.toLowerCase().contains(q))) return true;

      // Examples
      if (r.examples.any((ex) =>
          ex.french.toLowerCase().contains(q) ||
          ex.english.toLowerCase().contains(q))) return true;

      // Tables
      if (r.tables != null) {
        for (var t in r.tables!) {
          if (t.title != null && t.title!.toLowerCase().contains(q)) return true;
          if (t.headers.any((h) => h.toLowerCase().contains(q))) return true;
          for (var row in t.rows) {
            if (row.any((cell) => cell.toLowerCase().contains(q))) return true;
          }
        }
      }

      return false;
    }).toList();
  }

  int _levelCount(String level) {
    if (level == 'all') return grammarRules.length;
    return grammarRules
        .where((r) => r.level.toUpperCase() == level.toUpperCase())
        .length;
  }

  @override
  void dispose() {
    _searchCtrl.dispose();
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
        title: const Text('Grammar Handbook'),
        actions: [
          const CoursePortalButton(),
          Padding(
            padding: const EdgeInsets.only(right: 12),
            child: Center(
              child: Text(
                '${filtered.length} / ${grammarRules.length}',
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
          // ── Search & Filter Panel ─────────────────────────────────
          Container(
            color: theme.appBarTheme.backgroundColor,
            padding: const EdgeInsets.fromLTRB(16, 0, 16, 12),
            child: Column(
              children: [
                // Search field
                TextField(
                  controller: _searchCtrl,
                  onChanged: (v) => setState(() => _query = v),
                  decoration: InputDecoration(
                    hintText: 'Search rules, verbs, examples, or tables...',
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
                    contentPadding:
                        const EdgeInsets.symmetric(vertical: 10, horizontal: 12),
                  ),
                ),
                const SizedBox(height: 10),
                // Level selector row
                Row(
                  children: [
                    Text(
                      'Level',
                      style: theme.textTheme.labelSmall?.copyWith(
                        fontWeight: FontWeight.w800,
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: SizedBox(
                        height: 34,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: ['all', 'A1', 'A2'].map((lv) {
                            final label = lv == 'all'
                                ? 'All (${_levelCount('all')})'
                                : '$lv (${_levelCount(lv)})';
                            return Padding(
                              padding: const EdgeInsets.only(right: 6),
                              child: ChoiceChip(
                                key: Key('grammar-level-$lv'),
                                label: Text(label),
                                selected: _level == lv,
                                selectedColor: cs.primary.withOpacity(0.15),
                                onSelected: (selected) {
                                  if (selected) {
                                    setState(() => _level = lv);
                                  }
                                },
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
          const Divider(height: 1),

          // ── Scrollable Rules List ────────────────────────────────
          Expanded(
            child: filtered.isEmpty
                ? Center(
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          size: 48,
                          color: cs.onSurface.withOpacity(0.2),
                        ),
                        const SizedBox(height: 12),
                        Text(
                          'No grammar rules matched your search',
                          style: theme.textTheme.bodyMedium?.copyWith(
                            color: cs.onSurface.withOpacity(0.4),
                          ),
                        ),
                        const SizedBox(height: 10),
                        OutlinedButton(
                          onPressed: () {
                            _searchCtrl.clear();
                            setState(() {
                              _query = '';
                              _level = 'all';
                            });
                          },
                          child: const Text('Clear search filters'),
                        ),
                      ],
                    ),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.all(12),
                    itemCount: filtered.length,
                    itemBuilder: (ctx, i) {
                      final rule = filtered[i];
                      return _GrammarCard(
                        key: ValueKey('grammar-rule-${rule.id}'),
                        rule: rule,
                        index: i,
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}

class _GrammarCard extends StatefulWidget {
  final GrammarRule rule;
  final int index;

  const _GrammarCard({
    super.key,
    required this.rule,
    required this.index,
  });

  @override
  State<_GrammarCard> createState() => _GrammarCardState();
}

class _GrammarCardState extends State<_GrammarCard> {
  bool _isExpanded = false;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final cs = theme.colorScheme;
    final rule = widget.rule;
    final isDark = theme.brightness == Brightness.dark;

    final levelColor = rule.level.toUpperCase() == 'A1'
        ? cs.primary
        : theme.colorScheme.secondary;

    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: theme.cardTheme.color,
        borderRadius: BorderRadius.circular(AppTheme.radius),
        border: Border.all(
          color: _isExpanded
              ? levelColor.withOpacity(0.35)
              : cs.onSurface.withOpacity(0.06),
          width: _isExpanded ? 1.5 : 1.0,
        ),
        boxShadow: _isExpanded
            ? [
                BoxShadow(
                  color: levelColor.withOpacity(0.04),
                  blurRadius: 8,
                  offset: const Offset(0, 3),
                )
              ]
            : null,
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(AppTheme.radius),
        child: Column(
          children: [
            // ── Tap Target Header ──────────────────────────────────────
            InkWell(
              onTap: () => setState(() => _isExpanded = !_isExpanded),
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
                child: Row(
                  children: [
                    // Rule number indicator
                    Container(
                      width: 28,
                      alignment: Alignment.centerLeft,
                      child: Text(
                        '#${rule.id}',
                        style: theme.textTheme.labelMedium?.copyWith(
                          fontWeight: FontWeight.w800,
                          color: cs.onSurface.withOpacity(0.4),
                          fontSize: 12.5,
                        ),
                      ),
                    ),
                    // Title
                    Expanded(
                      child: Text(
                        rule.title,
                        style: theme.textTheme.titleMedium?.copyWith(
                          fontWeight: FontWeight.w700,
                          fontSize: 14.5,
                          color: _isExpanded ? levelColor : cs.onSurface,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Level Tag
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: levelColor.withOpacity(0.1),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Text(
                        rule.level,
                        style: TextStyle(
                          fontSize: 10.5,
                          fontWeight: FontWeight.w900,
                          color: levelColor,
                        ),
                      ),
                    ),
                    const SizedBox(width: 8),
                    // Expand arrow
                    Icon(
                      _isExpanded
                          ? Icons.keyboard_arrow_up_rounded
                          : Icons.keyboard_arrow_down_rounded,
                      color: cs.onSurface.withOpacity(0.4),
                      size: 20,
                    ),
                  ],
                ),
              ),
            ),

            // ── Collapsible Body ───────────────────────────────────────
            AnimatedSize(
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut,
              child: _isExpanded
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        const Divider(height: 1),
                        Padding(
                          padding: const EdgeInsets.all(16),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.stretch,
                            children: [
                              // 1. Syntactic Pattern block
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: BoxDecoration(
                                  color: isDark
                                      ? Colors.white.withOpacity(0.03)
                                      : Colors.black.withOpacity(0.025),
                                  borderRadius:
                                      BorderRadius.circular(AppTheme.radiusSm),
                                  border: Border(
                                    left: BorderSide(
                                      color: levelColor,
                                      width: 4,
                                    ),
                                  ),
                                ),
                                child: Text(
                                  rule.pattern,
                                  style: TextStyle(
                                    fontFamily: 'Courier',
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12.5,
                                    color: isDark
                                        ? const Color(0xFF38BDF8)
                                        : const Color(0xFF0284C7),
                                  ),
                                ),
                              ),
                              const SizedBox(height: 12),

                              // 2. Rule explanation
                              Text(
                                rule.rule,
                                style: theme.textTheme.bodyMedium?.copyWith(
                                  fontSize: 13.5,
                                  height: 1.45,
                                ),
                              ),

                              // 3. Optional detailed explain/summary
                              if (rule.explain != null || rule.summary != null) ...[
                                const SizedBox(height: 10),
                                Text(
                                  rule.explain ?? rule.summary!,
                                  style: theme.textTheme.bodyMedium?.copyWith(
                                    color: cs.onSurface.withOpacity(0.7),
                                    fontSize: 13.0,
                                    height: 1.45,
                                  ),
                                ),
                              ],

                              // 4. Instructions steps list
                              if (rule.steps != null && rule.steps!.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                Text(
                                  'Steps to Follow',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                ...rule.steps!.asMap().entries.map((entry) {
                                  final stepIdx = entry.key + 1;
                                  final stepText = entry.value;
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Container(
                                          margin: const EdgeInsets.only(top: 2, right: 10),
                                          width: 18,
                                          height: 18,
                                          decoration: BoxDecoration(
                                            color: levelColor.withOpacity(0.12),
                                            shape: BoxShape.circle,
                                          ),
                                          alignment: Alignment.center,
                                          child: Text(
                                            '$stepIdx',
                                            style: TextStyle(
                                              fontSize: 10.5,
                                              fontWeight: FontWeight.w900,
                                              color: levelColor,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Text(
                                            stepText,
                                            style: theme.textTheme.bodyMedium?.copyWith(
                                              fontSize: 13.0,
                                              height: 1.4,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],

                              // 5. Conjugation tables
                              if (rule.tables != null && rule.tables!.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                ...rule.tables!.map((tbl) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 12),
                                    child: Column(
                                      crossAxisAlignment: CrossAxisAlignment.stretch,
                                      children: [
                                        if (tbl.title != null) ...[
                                          Text(
                                            tbl.title!,
                                            style: theme.textTheme.titleSmall?.copyWith(
                                              fontSize: 12.5,
                                              fontWeight: FontWeight.w700,
                                              color: cs.onSurface.withOpacity(0.8),
                                            ),
                                          ),
                                          const SizedBox(height: 6),
                                        ],
                                        Container(
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                              color: cs.onSurface.withOpacity(0.1),
                                            ),
                                            borderRadius: BorderRadius.circular(
                                                AppTheme.radiusSm),
                                          ),
                                          clipBehavior: Clip.antiAlias,
                                          child: Table(
                                            border: TableBorder.symmetric(
                                              inside: BorderSide(
                                                color: cs.onSurface.withOpacity(0.08),
                                              ),
                                            ),
                                            columnWidths: const {
                                              0: FlexColumnWidth(1.0),
                                              1: FlexColumnWidth(1.6),
                                            },
                                            children: [
                                              // Header row
                                              TableRow(
                                                decoration: BoxDecoration(
                                                  color: levelColor.withOpacity(0.07),
                                                ),
                                                children: tbl.headers.map((header) {
                                                  return Padding(
                                                    padding: const EdgeInsets.symmetric(
                                                      horizontal: 10,
                                                      vertical: 8,
                                                    ),
                                                    child: Text(
                                                      header,
                                                      style: theme.textTheme.bodySmall
                                                          ?.copyWith(
                                                        fontWeight: FontWeight.w800,
                                                        color: levelColor,
                                                        fontSize: 12.0,
                                                      ),
                                                    ),
                                                  );
                                                }).toList(),
                                              ),
                                              // Data rows
                                              ...tbl.rows.map((row) {
                                                return TableRow(
                                                  children: row.map((cell) {
                                                    return Padding(
                                                      padding:
                                                          const EdgeInsets.symmetric(
                                                        horizontal: 10,
                                                        vertical: 8,
                                                      ),
                                                      child: Text(
                                                        cell,
                                                        style: theme.textTheme.bodyMedium
                                                            ?.copyWith(
                                                          fontSize: 12.5,
                                                        ),
                                                      ),
                                                    );
                                                  }).toList(),
                                                );
                                              }),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],

                              // 6. Examples list
                              if (rule.examples.isNotEmpty) ...[
                                const SizedBox(height: 16),
                                Text(
                                  'Examples',
                                  style: theme.textTheme.titleSmall?.copyWith(
                                    fontSize: 13.5,
                                    fontWeight: FontWeight.w700,
                                  ),
                                ),
                                const SizedBox(height: 6),
                                ...rule.examples.map((ex) {
                                  return Padding(
                                    padding: const EdgeInsets.only(bottom: 6),
                                    child: Row(
                                      crossAxisAlignment: CrossAxisAlignment.start,
                                      children: [
                                        Padding(
                                          padding: const EdgeInsets.only(
                                              top: 6, right: 8, left: 2),
                                          child: Container(
                                            width: 4,
                                            height: 4,
                                            decoration: BoxDecoration(
                                              color: levelColor,
                                              shape: BoxShape.circle,
                                            ),
                                          ),
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                ex.french,
                                                style: theme.textTheme.bodyMedium
                                                    ?.copyWith(
                                                  fontWeight: FontWeight.w700,
                                                  fontSize: 13.0,
                                                ),
                                              ),
                                              Text(
                                                ex.english,
                                                style: theme.textTheme.bodySmall
                                                    ?.copyWith(
                                                  fontSize: 12.0,
                                                  fontStyle: FontStyle.italic,
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                                }),
                              ],

                              // 7. Trap/Mistake warning block
                              if (rule.trap != null) ...[
                                const SizedBox(height: 16),
                                Container(
                                  padding: const EdgeInsets.all(12),
                                  decoration: BoxDecoration(
                                    color: AppTheme.coral.withOpacity(0.08),
                                    borderRadius:
                                        BorderRadius.circular(AppTheme.radiusSm),
                                    border: Border.all(
                                      color: AppTheme.coral.withOpacity(0.25),
                                    ),
                                  ),
                                  child: Row(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      const Icon(
                                        Icons.warning_amber_rounded,
                                        color: AppTheme.coral,
                                        size: 18,
                                      ),
                                      const SizedBox(width: 8),
                                      Expanded(
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              'Watch Out!',
                                              style: theme.textTheme.bodyMedium
                                                  ?.copyWith(
                                                color: AppTheme.coral,
                                                fontWeight: FontWeight.w800,
                                                fontSize: 12.0,
                                              ),
                                            ),
                                            const SizedBox(height: 2),
                                            Text(
                                              rule.trap!,
                                              style: theme.textTheme.bodySmall
                                                  ?.copyWith(
                                                color: isDark
                                                    ? const Color(0xFFFCA5A5)
                                                    : const Color(0xFFB91C1C),
                                                fontSize: 12.0,
                                                height: 1.4,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ],

                              // 8. Stressed Note block
                              if (rule.note != null && rule.note!.isNotEmpty) ...[
                                const SizedBox(height: 12),
                                Padding(
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 4),
                                  child: Text(
                                    '💡 Note: ${rule.note!}',
                                    style: theme.textTheme.bodySmall?.copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 12.0,
                                      color: cs.onSurface.withOpacity(0.6),
                                      height: 1.4,
                                    ),
                                  ),
                                ),
                              ],
                            ],
                          ),
                        ),
                      ],
                    )
                  : const SizedBox.shrink(),
            ),
          ],
        ),
      ),
    )
        .animate(delay: Duration(milliseconds: (widget.index * 30).clamp(0, 300)))
        .fadeIn(duration: 250.ms)
        .slideY(begin: 0.08, curve: Curves.easeOut);
  }
}
