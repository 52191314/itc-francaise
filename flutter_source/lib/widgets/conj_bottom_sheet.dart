import 'dart:math';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../models/word.dart';
import '../services/tts_service.dart';
import '../theme/app_theme.dart';

/// La Roue — immersive full-screen conjugation view with a
/// circular wheel, table view, and practice mini-quiz.
void showConjBottomSheet(BuildContext context, Word word, double ttsSpeed) {
  Navigator.of(context).push(
    MaterialPageRoute(
      fullscreenDialog: true,
      builder: (_) => _LaRoue(word: word, ttsSpeed: ttsSpeed),
    ),
  );
}

class _LaRoue extends StatefulWidget {
  final Word word;
  final double ttsSpeed;

  const _LaRoue({required this.word, required this.ttsSpeed});

  @override
  State<_LaRoue> createState() => _LaRoueState();
}

class _LaRoueState extends State<_LaRoue>
    with SingleTickerProviderStateMixin {
  late AnimationController _spinCtrl;
  late Animation<double> _spinAnim;
  int _selectedPronoun = 0;
  int _selectedTense = 0;
  bool _showTable = true;

  Word get _word => widget.word;

  @override
  void initState() {
    super.initState();
    _spinCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 600),
    );
    _spinAnim = CurvedAnimation(parent: _spinCtrl, curve: Curves.easeOutBack);
  }

  @override
  void dispose() {
    _spinCtrl.dispose();
    super.dispose();
  }

  void _spinTo(int index) {
    setState(() => _selectedPronoun = index);
    _spinCtrl.forward(from: 0);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final word = _word;
    final hasConj = word.isVerb && word.conj != null && word.conj!.isNotEmpty;

    return Scaffold(
      backgroundColor: isDark ? AppTheme.deepInk : AppTheme.parchment,
      appBar: AppBar(
        title: Text(
          word.fr,
          style: GoogleFonts.playfairDisplay(
            fontSize: 20,
            fontWeight: FontWeight.w800,
            color: isDark ? AppTheme.offWhite : AppTheme.ink,
          ),
        ),
        actions: [
          IconButton(
            icon: Icon(Icons.volume_up_rounded,
                color: isDark ? AppTheme.offWhite : AppTheme.ink),
            onPressed: () async {
              await TtsService.instance.setRate(widget.ttsSpeed);
              await TtsService.instance.speak(word.fr);
            },
          ),
          // Toggle view
          IconButton(
            icon: Icon(
                _showTable ? Icons.donut_large_rounded : Icons.table_chart_rounded,
                color: isDark ? AppTheme.offWhite : AppTheme.ink),
            onPressed: () => setState(() => _showTable = !_showTable),
            tooltip: _showTable ? 'Wheel view' : 'Table view',
          ),
          IconButton(
            icon: Icon(Icons.close_rounded,
                color: isDark ? AppTheme.offWhite : AppTheme.ink),
            onPressed: () => Navigator.pop(context),
          ),
        ],
      ),
      body: !hasConj
          ? Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Icon(Icons.info_outline_rounded,
                      size: 48,
                      color: isDark
                          ? Colors.white.withValues(alpha: 0.15)
                          : Colors.black.withValues(alpha: 0.1)),
                  const SizedBox(height: 16),
                  Text('No conjugation data available',
                      style: TextStyle(
                          fontSize: 16,
                          color: isDark
                              ? AppTheme.mutedGrey
                              : AppTheme.warmGrey)),
                ],
              ),
            )
          : Column(
              children: [
                // ── Word header ─────────────────────────────────
                Container(
                  padding: const EdgeInsets.fromLTRB(20, 4, 20, 12),
                  child: Row(
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 8, vertical: 3),
                        decoration: BoxDecoration(
                          color: word.level == 'A1'
                              ? AppTheme.indigo.withValues(alpha: 0.1)
                              : AppTheme.aubergine.withValues(alpha: 0.1),
                          borderRadius: BorderRadius.circular(6),
                        ),
                        child: Text(word.level,
                            style: TextStyle(
                                fontSize: 10,
                                fontWeight: FontWeight.w800,
                                color: word.level == 'A1'
                                    ? AppTheme.indigo
                                    : AppTheme.aubergine)),
                      ),
                      const SizedBox(width: 8),
                      Text(word.type,
                          style: TextStyle(
                              fontSize: 12,
                              color: isDark
                                  ? AppTheme.mutedGrey
                                  : AppTheme.warmGrey)),
                      const SizedBox(width: 8),
                      Text('·',
                          style: TextStyle(
                              color: isDark
                                  ? AppTheme.mutedGrey
                                  : AppTheme.warmGrey)),
                      const SizedBox(width: 8),
                      Expanded(
                        child: Text(word.en,
                            style: TextStyle(
                                fontSize: 12,
                                color: isDark
                                    ? AppTheme.mutedGrey
                                    : AppTheme.warmGrey),
                            overflow: TextOverflow.ellipsis),
                      ),
                    ],
                  ),
                ),

                // ── Content ─────────────────────────────────────
                Expanded(
                  child: _showTable
                      ? _buildTable(isDark)
                      : _buildWheel(isDark),
                ),

                // ── Tense selector ──────────────────────────────
                Container(
                  height: 44,
                  padding: const EdgeInsets.symmetric(horizontal: 12),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: kTenses.asMap().entries.map((entry) {
                      final idx = entry.key;
                      final tense = entry.value;
                      final isActive = _selectedTense == idx;
                      return Padding(
                        padding: const EdgeInsets.only(right: 6),
                        child: GestureDetector(
                          onTap: () =>
                              setState(() => _selectedTense = idx),
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 14, vertical: 8),
                            decoration: BoxDecoration(
                              color: isActive
                                  ? AppTheme.terracotta.withValues(alpha: 0.12)
                                  : (isDark
                                      ? Colors.white.withValues(alpha: 0.04)
                                      : Colors.black
                                          .withValues(alpha: 0.03)),
                              borderRadius: BorderRadius.circular(
                                  AppTheme.radiusPill),
                              border: Border.all(
                                color: isActive
                                    ? AppTheme.terracotta
                                        .withValues(alpha: 0.4)
                                    : (isDark
                                        ? Colors.white.withValues(alpha: 0.06)
                                        : Colors.black
                                            .withValues(alpha: 0.06)),
                              ),
                            ),
                            child: Text(
                              tense,
                              style: TextStyle(
                                fontSize: 12,
                                fontWeight: isActive
                                    ? FontWeight.w700
                                    : FontWeight.w500,
                                color: isActive
                                    ? AppTheme.terracotta
                                    : (isDark
                                        ? AppTheme.offWhite
                                        : AppTheme.ink),
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                ),

                // ── Practice button ─────────────────────────────
                Padding(
                  padding:
                      const EdgeInsets.fromLTRB(20, 8, 20, 20),
                  child: SizedBox(
                    width: double.infinity,
                    child: OutlinedButton.icon(
                      onPressed: () => _startPractice(context, isDark),
                      icon: const Icon(Icons.quiz_rounded, size: 18),
                      label: const Text('Practice this verb'),
                      style: OutlinedButton.styleFrom(
                        foregroundColor: AppTheme.terracotta,
                        side: BorderSide(
                            color: AppTheme.terracotta.withValues(alpha: 0.4)),
                        padding: const EdgeInsets.symmetric(vertical: 14),
                        shape: RoundedRectangleBorder(
                          borderRadius:
                              BorderRadius.circular(AppTheme.radiusPill),
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  //  TABLE VIEW
  // ═══════════════════════════════════════════════════════════════
  Widget _buildTable(bool isDark) {
    final forms = _word.conj![_selectedTense];
    final terracotta = isDark ? AppTheme.warmCoral : AppTheme.terracotta;

    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(
        children: [
          // Current tense label
          Padding(
            padding: const EdgeInsets.only(bottom: 12),
            child: Text(
              kTenses[_selectedTense],
              style: GoogleFonts.playfairDisplay(
                fontSize: 18,
                fontWeight: FontWeight.w700,
                color: isDark ? AppTheme.offWhite : AppTheme.ink,
              ),
            ),
          ),
          // Table
          Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: isDark
                    ? AppTheme.darkBorder
                    : Colors.black.withValues(alpha: 0.06),
              ),
              borderRadius: BorderRadius.circular(AppTheme.radiusSm),
            ),
            clipBehavior: Clip.antiAlias,
            child: Table(
              border: TableBorder.symmetric(
                inside: BorderSide(
                  color: isDark
                      ? Colors.white.withValues(alpha: 0.04)
                      : Colors.black.withValues(alpha: 0.04),
                ),
              ),
              columnWidths: const {
                0: FlexColumnWidth(1),
                1: FlexColumnWidth(1.8),
              },
              children: [
                // Header
                TableRow(
                  decoration: BoxDecoration(
                    color: terracotta.withValues(alpha: 0.08),
                  ),
                  children: ['Pronoun', 'Form'].map((h) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      child: Text(h,
                          style: TextStyle(
                              fontSize: 12,
                              fontWeight: FontWeight.w800,
                              color: terracotta)),
                    );
                  }).toList(),
                ),
                // Body rows
                ...kPronouns.asMap().entries.map((entry) {
                  final pi = entry.key;
                  final pronoun = entry.value;
                  final isActive = pi == _selectedPronoun;
                  final form = pi < forms.length ? forms[pi] : '—';

                  return TableRow(
                    decoration: BoxDecoration(
                      color: isActive
                          ? terracotta.withValues(alpha: 0.06)
                          : null,
                    ),
                    children: [
                      GestureDetector(
                        onTap: () => _spinTo(pi),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Text(pronoun,
                              style: TextStyle(
                                  fontSize: 13,
                                  fontWeight: FontWeight.w700,
                                  color: isActive
                                      ? terracotta
                                      : (isDark
                                          ? AppTheme.offWhite
                                          : AppTheme.ink))),
                        ),
                      ),
                      GestureDetector(
                        onTap: () => _speakForm(form),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(
                              horizontal: 12, vertical: 10),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(form,
                                    style: TextStyle(
                                        fontSize: 14,
                                        fontWeight: FontWeight.w600,
                                        color: isDark
                                            ? AppTheme.offWhite
                                            : AppTheme.ink)),
                              ),
                              Icon(Icons.volume_up_rounded,
                                  size: 16,
                                  color: isDark
                                      ? AppTheme.mutedGrey
                                      : AppTheme.warmGrey),
                            ],
                          ),
                        ),
                      ),
                    ],
                  );
                }),
              ],
            ),
          ),
          const SizedBox(height: 16),
          // All tenses mini table
          Text('All Tenses',
              style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppTheme.offWhite : AppTheme.ink)),
          const SizedBox(height: 8),
          ...kTenses.asMap().entries.map((entry) {
            final ti = entry.key;
            final tense = entry.value;
            final isActive = ti == _selectedTense;
            final tenseForms = _word.conj![ti];
            return GestureDetector(
              onTap: () => setState(() => _selectedTense = ti),
              child: Container(
                margin: const EdgeInsets.only(bottom: 4),
                padding: const EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: isActive
                      ? terracotta.withValues(alpha: 0.06)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.02)
                          : Colors.black.withValues(alpha: 0.02)),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  border: isActive
                      ? Border.all(
                          color: terracotta.withValues(alpha: 0.2))
                      : null,
                ),
                child: Row(
                  children: [
                    SizedBox(
                      width: 80,
                      child: Text(tense,
                          style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: isActive
                                  ? terracotta
                                  : (isDark
                                      ? AppTheme.mutedGrey
                                      : AppTheme.warmGrey))),
                    ),
                    Expanded(
                      child: Text(
                        tenseForms.join(' · '),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: TextStyle(
                            fontSize: 11,
                            color: isDark
                                ? AppTheme.offWhite
                                : AppTheme.ink),
                      ),
                    ),
                  ],
                ),
              ),
            );
          }),
          const SizedBox(height: 20),
        ],
      ),
    );
  }

  // ═══════════════════════════════════════════════════════════════
  //  WHEEL VIEW
  // ═══════════════════════════════════════════════════════════════
  Widget _buildWheel(bool isDark) {
    final forms = _word.conj![_selectedTense];
    final terracotta = isDark ? AppTheme.warmCoral : AppTheme.terracotta;

    return LayoutBuilder(
      builder: (ctx, constraints) {
        final size = min(constraints.maxWidth, constraints.maxHeight);
        final radius = size * 0.35;
        final centerX = constraints.maxWidth / 2;
        final centerY = constraints.maxHeight / 2;

        return Stack(
          children: [
            // Center circle — current form
            Positioned(
              left: centerX - radius * 0.55,
              top: centerY - radius * 0.55,
              child: AnimatedBuilder(
                animation: _spinAnim,
                builder: (ctx, _) {
                  return Transform(
                    transform: Matrix4.identity()
                      ..scale(1 + _spinAnim.value * 0.05),
                    alignment: Alignment.center,
                    child: Container(
                      width: radius * 1.1,
                      height: radius * 1.1,
                      decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        gradient: RadialGradient(
                          colors: [
                            terracotta.withValues(alpha: 0.12),
                            terracotta.withValues(alpha: 0.04),
                          ],
                        ),
                        border: Border.all(
                          color: terracotta.withValues(alpha: 0.3),
                          width: 2,
                        ),
                        boxShadow: [
                          BoxShadow(
                            color: terracotta.withValues(alpha: 0.1),
                            blurRadius: 20,
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            kPronouns[_selectedPronoun],
                            style: TextStyle(
                              fontSize: 11,
                              fontWeight: FontWeight.w700,
                              color: terracotta,
                            ),
                          ),
                          const SizedBox(height: 4),
                          Text(
                            _selectedPronoun < forms.length
                                ? forms[_selectedPronoun]
                                : '—',
                            style: GoogleFonts.playfairDisplay(
                              fontSize: 18,
                              fontWeight: FontWeight.w800,
                              color: isDark
                                  ? AppTheme.offWhite
                                  : AppTheme.ink,
                            ),
                            textAlign: TextAlign.center,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),

            // Pronoun markers around the wheel
            ...List.generate(kPronouns.length, (i) {
              final angle = (2 * pi / kPronouns.length) * i - pi / 2;
              final x = centerX + radius * cos(angle) - 18;
              final y = centerY + radius * sin(angle) - 18;
              final isActive = i == _selectedPronoun;

              return Positioned(
                left: x,
                top: y,
                child: GestureDetector(
                  onTap: () => _spinTo(i),
                  child: AnimatedContainer(
                    duration: const Duration(milliseconds: 200),
                    width: 36,
                    height: 36,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: isActive
                          ? terracotta
                          : (isDark
                              ? AppTheme.charcoal
                              : Colors.white),
                      border: Border.all(
                        color: isActive
                            ? terracotta
                            : (isDark
                                ? AppTheme.darkBorder
                                : Colors.black.withValues(alpha: 0.1)),
                        width: isActive ? 2 : 1,
                      ),
                      boxShadow: isActive
                          ? [
                              BoxShadow(
                                color: terracotta.withValues(alpha: 0.3),
                                blurRadius: 8,
                              ),
                            ]
                          : null,
                    ),
                    child: Center(
                      child: Text(
                        kPronouns[i].substring(0, 2),
                        style: TextStyle(
                          fontSize: 10,
                          fontWeight:
                              isActive ? FontWeight.w800 : FontWeight.w600,
                          color: isActive
                              ? Colors.white
                              : (isDark
                                  ? AppTheme.offWhite
                                  : AppTheme.ink),
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }),

            // Connecting lines
            ...List.generate(kPronouns.length, (i) {
              final angle = (2 * pi / kPronouns.length) * i - pi / 2;
              final x1 = centerX + radius * 0.55 * cos(angle);
              final y1 = centerY + radius * 0.55 * sin(angle);
              final x2 = centerX + radius * 0.88 * cos(angle);
              final y2 = centerY + radius * 0.88 * sin(angle);
              final isActive = i == _selectedPronoun;

              return Positioned.fill(
                child: CustomPaint(
                  painter: _LinePainter(
                    x1: x1,
                    y1: y1,
                    x2: x2,
                    y2: y2,
                    color: isActive
                        ? terracotta.withValues(alpha: 0.3)
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : Colors.black.withValues(alpha: 0.04)),
                  ),
                ),
              );
            }),

            // Tense label at bottom
            Positioned(
              bottom: 20,
              left: 0,
              right: 0,
              child: Text(
                kTenses[_selectedTense],
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w700,
                  color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

  // ═══════════════════════════════════════════════════════════════
  //  PRACTICE
  // ═══════════════════════════════════════════════════════════════
  void _startPractice(BuildContext context, bool isDark) {
    final forms = _word.conj![_selectedTense];
    final pronoun = kPronouns[_selectedPronoun];
    final correctForm =
        _selectedPronoun < forms.length ? forms[_selectedPronoun] : '—';

    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (ctx) => _PracticeQuiz(
        word: _word.fr,
        tense: kTenses[_selectedTense],
        pronoun: pronoun,
        correctForm: correctForm,
        isDark: isDark,
      ),
    );
  }

  void _speakForm(String form) async {
    await TtsService.instance.setRate(widget.ttsSpeed);
    await TtsService.instance.speak(form);
  }
}

// ═══════════════════════════════════════════════════════════════
//  PRACTICE QUIZ BOTTOM SHEET
// ═══════════════════════════════════════════════════════════════
class _PracticeQuiz extends StatefulWidget {
  final String word;
  final String tense;
  final String pronoun;
  final String correctForm;
  final bool isDark;

  const _PracticeQuiz({
    required this.word,
    required this.tense,
    required this.pronoun,
    required this.correctForm,
    required this.isDark,
  });

  @override
  State<_PracticeQuiz> createState() => _PracticeQuizState();
}

class _PracticeQuizState extends State<_PracticeQuiz> {
  final _ctrl = TextEditingController();
  bool? _isCorrect;

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SafeArea(
        child: Padding(
          padding: const EdgeInsets.fromLTRB(24, 16, 24, 24),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Center(
                child: Container(
                  width: 32,
                  height: 4,
                  decoration: BoxDecoration(
                    color: isDark
                        ? AppTheme.darkBorder
                        : Colors.black.withValues(alpha: 0.15),
                    borderRadius: BorderRadius.circular(2),
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Text('Fill in the blank',
                  style: GoogleFonts.playfairDisplay(
                      fontSize: 18, fontWeight: FontWeight.w700,
                      color: isDark ? AppTheme.offWhite : AppTheme.ink)),
              const SizedBox(height: 16),
              RichText(
                text: TextSpan(
                  style: TextStyle(
                    fontSize: 18,
                    height: 1.5,
                    color: isDark ? AppTheme.offWhite : AppTheme.ink,
                  ),
                  children: [
                    TextSpan(text: '${widget.pronoun} '),
                    TextSpan(
                      text: '(${widget.tense})',
                      style: TextStyle(
                        fontSize: 13,
                        color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _ctrl,
                autofocus: true,
                onSubmitted: (_) => _check(),
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w700,
                  fontFamily: GoogleFonts.inter().fontFamily,
                  color: isDark ? AppTheme.offWhite : AppTheme.ink,
                ),
                decoration: InputDecoration(
                  hintText: 'Type the conjugated form...',
                  hintStyle: TextStyle(
                    fontSize: 16,
                    color: isDark
                        ? AppTheme.mutedGrey.withValues(alpha: 0.4)
                        : AppTheme.warmGrey.withValues(alpha: 0.4),
                  ),
                ),
              ),
              const SizedBox(height: 12),
              if (_isCorrect != null)
                Row(
                  children: [
                    Icon(
                      _isCorrect!
                          ? Icons.check_circle_rounded
                          : Icons.cancel_rounded,
                      color: _isCorrect! ? AppTheme.sage : AppTheme.verbCoral,
                      size: 20,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      _isCorrect!
                          ? 'Correct! 🎉'
                          : 'Incorrect. The answer is: ${widget.correctForm}',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w700,
                        color: _isCorrect!
                            ? AppTheme.sage
                            : AppTheme.verbCoral,
                      ),
                    ),
                  ],
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  TextButton(
                    onPressed: () => Navigator.pop(context),
                    child: const Text('Close'),
                  ),
                  const SizedBox(width: 8),
                  FilledButton(
                    onPressed: _check,
                    child: Text(_isCorrect == null ? 'Check' : 'Try again'),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _check() {
    final answer = _ctrl.text.trim().toLowerCase();
    final correct = widget.correctForm.toLowerCase();
    setState(() {
      _isCorrect = answer == correct;
    });
  }
}

// ═══════════════════════════════════════════════════════════════
//  LINE PAINTER for wheel view
// ═══════════════════════════════════════════════════════════════
class _LinePainter extends CustomPainter {
  final double x1, y1, x2, y2;
  final Color color;

  _LinePainter({
    required this.x1,
    required this.y1,
    required this.x2,
    required this.y2,
    required this.color,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = color
      ..strokeWidth = 1
      ..style = PaintingStyle.stroke;
    canvas.drawLine(Offset(x1, y1), Offset(x2, y2), paint);
  }

  @override
  bool shouldRepaint(covariant _LinePainter old) =>
      x1 != old.x1 || y1 != old.y1 || x2 != old.x2 || y2 != old.y2;
}
