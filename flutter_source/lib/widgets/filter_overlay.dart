import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../data/vocab_data.dart';
import '../models/filter_state.dart';
import '../theme/app_theme.dart';

/// Full-screen filter overlay shown when the user taps the filter bar.
class FilterScreen extends StatefulWidget {
  final FilterState filter;
  final bool isDark;
  final int totalCount;
  final int filteredCount;

  const FilterScreen({
    super.key,
    required this.filter,
    required this.isDark,
    required this.totalCount,
    required this.filteredCount,
  });

  @override
  State<FilterScreen> createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  late FilterState _pending;

  @override
  void initState() {
    super.initState();
    _pending = widget.filter.copy();
  }

  void _apply() {
    widget.filter.level = _pending.level;
    widget.filter.pos = _pending.pos;
    widget.filter.gender = _pending.gender;
    widget.filter.verbRegular = _pending.verbRegular;
    widget.filter.verbIrregular = _pending.verbIrregular;
    widget.filter.verbReflexive = _pending.verbReflexive;
    widget.filter.verbAuxiliary = _pending.verbAuxiliary;
    widget.filter.hideKnown = _pending.hideKnown;
    widget.filter.inJournal = _pending.inJournal;
    widget.filter.searchScope = _pending.searchScope;
    Navigator.pop(context, true);
  }

  void _reset() {
    _pending.reset();
    widget.filter.reset();
    Navigator.pop(context, true);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = widget.isDark;
    final bg = isDark ? AppTheme.deepInk : AppTheme.parchment;

    return Material(
      color: bg,
      child: Stack(
        children: [
          Positioned.fill(
            child: BackdropFilter(
              filter: isDark
                  ? const ColorFilter.mode(Color(0xFF0F1115), BlendMode.overlay)
                  : const ColorFilter.mode(Color(0xFFF7F5F0), BlendMode.overlay),
              child: Container(color: bg.withValues(alpha: 0.9)),
            ),
          ),
          SafeArea(
            child: Column(
              children: [
                _buildHeader(isDark),
                Expanded(
                  child: ListView(
                    padding: const EdgeInsets.fromLTRB(20, 8, 20, 80),
                    children: [
                      _buildLevelSection(isDark),
                      const SizedBox(height: 20),
                      _buildPosSection(isDark),
                      if (_pending.pos == 'noun') ...[
                        const SizedBox(height: 16),
                        _buildGenderSection(isDark),
                      ],
                      if (_pending.pos == 'verb') ...[
                        const SizedBox(height: 16),
                        _buildVerbSection(isDark),
                      ],
                      const SizedBox(height: 16),
                      _buildQuickFilters(isDark),
                      const SizedBox(height: 16),
                      _buildSearchScope(isDark),
                    ],
                  ),
                ),
                _buildActions(isDark),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildHeader(bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(8, 4, 16, 8),
      child: Row(
        children: [
          IconButton(
            icon: Icon(Icons.close_rounded,
                color: isDark ? AppTheme.offWhite : AppTheme.ink),
            onPressed: () => Navigator.pop(context, false),
          ),
          Text('Filters',
              style: GoogleFonts.playfairDisplay(
                  fontSize: 18, fontWeight: FontWeight.w700,
                  color: isDark ? AppTheme.offWhite : AppTheme.ink)),
          const Spacer(),
          TextButton(
            onPressed: _reset,
            child: Text('Réinitialiser',
                style: TextStyle(
                    fontSize: 12, color: AppTheme.terracotta)),
          ),
        ],
      ),
    );
  }

  Widget _buildLevelSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Level', isDark),
        const SizedBox(height: 8),
        Container(
          height: 38,
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.black.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(AppTheme.radiusPill),
          ),
          child: Row(
            children: ['tous', 'A1', 'A2'].map((lv) {
              final selected = _pending.level == lv;
              final count = lv == 'tous'
                  ? kVocab.length
                  : kVocab.where((w) => w.level == lv).length;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _pending.level = lv),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 8),
                    decoration: BoxDecoration(
                      color: selected ? AppTheme.terracotta : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Text(
                          lv == 'tous' ? 'Tous' : lv,
                          style: TextStyle(
                            fontSize: 13,
                            fontWeight: FontWeight.w700,
                            color: selected ? Colors.white
                                : (isDark ? AppTheme.offWhite : AppTheme.ink),
                          ),
                        ),
                        const SizedBox(width: 4),
                        Text('($count)',
                            style: TextStyle(
                                fontSize: 10,
                                color: selected
                                    ? Colors.white.withValues(alpha: 0.7)
                                    : (isDark
                                        ? AppTheme.mutedGrey
                                        : AppTheme.warmGrey))),
                      ],
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildPosSection(bool isDark) {
    final types = [
      ('tous', 'Tous', Icons.all_inclusive_rounded, null),
      ('verb', 'Verbes', Icons.directions_run_rounded, AppTheme.verbCoral),
      ('noun', 'Noms', Icons.label_rounded, AppTheme.nounOchre),
      ('adjective', 'Adjectifs', Icons.palette_rounded, AppTheme.aubergine),
      ('adverb', 'Adverbes', Icons.speed_rounded, AppTheme.indigo),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            _sectionLabel('Genre', isDark),
            const Spacer(),
          ],
        ),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: types.map((t) {
            final isActive = _pending.pos == t.$1;
            final color = t.$4 ?? AppTheme.terracotta;
            return GestureDetector(
              onTap: () => setState(() {
                _pending.pos = t.$1;
                _pending.gender = null;
              }),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 14, vertical: 10),
                decoration: BoxDecoration(
                  color: isActive
                      ? color.withValues(alpha: 0.12)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.04)
                          : Colors.black.withValues(alpha: 0.03)),
                  borderRadius: BorderRadius.circular(AppTheme.radiusSm),
                  border: Border.all(
                    color: isActive
                        ? color.withValues(alpha: 0.4)
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : Colors.black.withValues(alpha: 0.06)),
                  ),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(t.$3, size: 16, color: color),
                    const SizedBox(width: 6),
                    Text(t.$2,
                        style: TextStyle(
                            fontSize: 12,
                            fontWeight:
                                isActive ? FontWeight.w700 : FontWeight.w500,
                            color: isActive
                                ? color
                                : (isDark
                                    ? AppTheme.offWhite
                                    : AppTheme.ink))),
                  ],
                ),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildGenderSection(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Gender', isDark),
        const SizedBox(height: 8),
        Row(
          children: [
            _genderPill('♂ Masculin', 'masculine', isDark),
            const SizedBox(width: 8),
            _genderPill('♀ Féminin', 'feminine', isDark),
          ],
        ),
      ],
    );
  }

  Widget _genderPill(String label, String value, bool isDark) {
    final isActive = _pending.gender == value;
    final color = value == 'masculine'
        ? const Color(0xFF5B8DEF)
        : const Color(0xFFE88A7D);
    return GestureDetector(
      onTap: () =>
          setState(() => _pending.gender = isActive ? null : value),
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 10),
        decoration: BoxDecoration(
          color: isActive
              ? color.withValues(alpha: 0.12)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.04)
                  : Colors.black.withValues(alpha: 0.03)),
          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
          border: Border.all(
            color: isActive
                ? color.withValues(alpha: 0.4)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.06)),
          ),
        ),
        child: Text(label,
            style: TextStyle(
                fontSize: 13,
                fontWeight: isActive ? FontWeight.w700 : FontWeight.w500,
                color: isActive
                    ? color
                    : (isDark ? AppTheme.offWhite : AppTheme.ink))),
      ),
    );
  }

  Widget _buildVerbSection(bool isDark) {
    final attributes = [
      ('Regular', 'verbRegular', AppTheme.sage),
      ('Irregular', 'verbIrregular', AppTheme.verbCoral),
      ('Reflexive', 'verbReflexive', AppTheme.indigo),
      ('Auxiliary', 'verbAuxiliary', AppTheme.aubergine),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Verb Type', isDark),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 8,
          children: attributes.map((a) {
            final field = a.$2;
            final isActive = _pending.getField(field);
            final color = a.$3;
            return GestureDetector(
              onTap: () => setState(() => _pending.toggleField(field)),
              child: Container(
                padding: const EdgeInsets.symmetric(
                    horizontal: 14, vertical: 8),
                decoration: BoxDecoration(
                  color: isActive
                      ? color.withValues(alpha: 0.12)
                      : (isDark
                          ? Colors.white.withValues(alpha: 0.04)
                          : Colors.black.withValues(alpha: 0.03)),
                  borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                  border: Border.all(
                    color: isActive
                        ? color.withValues(alpha: 0.4)
                        : (isDark
                            ? Colors.white.withValues(alpha: 0.06)
                            : Colors.black.withValues(alpha: 0.06)),
                  ),
                ),
                child: Text(a.$1,
                    style: TextStyle(
                        fontSize: 12,
                        fontWeight:
                            isActive ? FontWeight.w700 : FontWeight.w500,
                        color: isActive
                            ? color
                            : (isDark
                                ? AppTheme.offWhite
                                : AppTheme.ink))),
              ),
            );
          }).toList(),
        ),
      ],
    );
  }

  Widget _buildQuickFilters(bool isDark) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Quick Filters', isDark),
        const SizedBox(height: 8),
        Wrap(
          spacing: 8,
          runSpacing: 6,
          children: [
            _quickToggle('⭐ In my Journal', _pending.inJournal, () {
              setState(() => _pending.inJournal = !_pending.inJournal);
            }, isDark),
            _quickToggle('🔊 With audio', true, null, isDark, disabled: true),
            _quickToggle('🙈 Hide known', _pending.hideKnown, () {
              setState(() => _pending.hideKnown = !_pending.hideKnown);
            }, isDark),
          ],
        ),
      ],
    );
  }

  Widget _quickToggle(String label, bool value, VoidCallback? onTap,
      bool isDark, {bool disabled = false}) {
    return GestureDetector(
      onTap: disabled ? null : onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 8),
        decoration: BoxDecoration(
          color: value
              ? AppTheme.terracotta.withValues(alpha: 0.1)
              : (isDark
                  ? Colors.white.withValues(alpha: 0.04)
                  : Colors.black.withValues(alpha: 0.03)),
          borderRadius: BorderRadius.circular(AppTheme.radiusPill),
          border: Border.all(
            color: value
                ? AppTheme.terracotta.withValues(alpha: 0.3)
                : (isDark
                    ? Colors.white.withValues(alpha: 0.06)
                    : Colors.black.withValues(alpha: 0.06)),
          ),
        ),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            if (value)
              Icon(Icons.check_rounded,
                  size: 14, color: AppTheme.terracotta),
            if (value) const SizedBox(width: 4),
            Text(label,
                style: TextStyle(
                    fontSize: 12,
                    fontWeight: value ? FontWeight.w700 : FontWeight.w500,
                    color: value
                        ? AppTheme.terracotta
                        : (isDark
                            ? AppTheme.offWhite.withValues(alpha: disabled ? 0.3 : 1)
                            : AppTheme.ink.withValues(alpha: disabled ? 0.3 : 1)))),
          ],
        ),
      ),
    );
  }

  Widget _buildSearchScope(bool isDark) {
    final scopes = [
      ('all', 'All fields'),
      ('french', 'French word'),
      ('english', 'English meaning'),
      ('example', 'Example text'),
    ];

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _sectionLabel('Search Scope', isDark),
        const SizedBox(height: 8),
        Container(
          height: 38,
          decoration: BoxDecoration(
            color: isDark ? Colors.white.withValues(alpha: 0.04) : Colors.black.withValues(alpha: 0.03),
            borderRadius: BorderRadius.circular(AppTheme.radiusPill),
          ),
          child: Row(
            children: scopes.map((s) {
              final selected = _pending.searchScope == s.$1;
              return Expanded(
                child: GestureDetector(
                  onTap: () => setState(() => _pending.searchScope = s.$1),
                  child: Container(
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(vertical: 6),
                    decoration: BoxDecoration(
                      color: selected ? AppTheme.terracotta : Colors.transparent,
                      borderRadius: BorderRadius.circular(AppTheme.radiusPill),
                    ),
                    child: Text(
                      s.$2,
                      style: TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: selected ? Colors.white
                            : (isDark ? AppTheme.offWhite : AppTheme.ink),
                      ),
                    ),
                  ),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }

  Widget _buildActions(bool isDark) {
    return Container(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 16),
      decoration: BoxDecoration(
        color: isDark ? AppTheme.charcoal : Colors.white,
        border: Border(
          top: BorderSide(
            color: isDark ? AppTheme.darkBorder : Colors.black.withValues(alpha: 0.06),
          ),
        ),
      ),
      child: SafeArea(
        top: false,
        child: SizedBox(
          width: double.infinity,
          child: FilledButton(
            onPressed: _apply,
            style: FilledButton.styleFrom(
              padding: const EdgeInsets.symmetric(vertical: 16),
            ),
            child: Text(
              'Appliquer  ·  ${widget.filteredCount} / ${widget.totalCount}',
              style: const TextStyle(
                  fontSize: 15, fontWeight: FontWeight.w700),
            ),
          ),
        ),
      ),
    );
  }

  Widget _sectionLabel(String label, bool isDark) {
    return Text(label,
        style: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.w800,
            color: isDark ? AppTheme.mutedGrey : AppTheme.warmGrey,
            letterSpacing: 0.5));
  }
}

extension _FilterStateFields on FilterState {
  bool getField(String field) {
    switch (field) {
      case 'verbRegular': return verbRegular;
      case 'verbIrregular': return verbIrregular;
      case 'verbReflexive': return verbReflexive;
      case 'verbAuxiliary': return verbAuxiliary;
      default: return false;
    }
  }

  void toggleField(String field) {
    switch (field) {
      case 'verbRegular': verbRegular = !verbRegular; break;
      case 'verbIrregular': verbIrregular = !verbIrregular; break;
      case 'verbReflexive': verbReflexive = !verbReflexive; break;
      case 'verbAuxiliary': verbAuxiliary = !verbAuxiliary; break;
    }
  }
}
