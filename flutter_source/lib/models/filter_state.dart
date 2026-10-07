import 'word.dart';

/// Complete filter state for the Dictionary filter system.
class FilterState {
  // 1. Level
  String level; // 'tous' | 'A1' | 'A2'

  // 2. Part of Speech
  String pos; // 'tous' | 'verb' | 'noun' | 'adjective' | 'adverb' | 'pronoun' | 'preposition' | 'conjunction'

  // 3. Gender (nouns only)
  String? gender; // null (both) | 'masculine' | 'feminine'

  // 4. Verb attributes
  bool verbRegular;
  bool verbIrregular;
  bool verbReflexive;
  bool verbAuxiliary;

  // 5. Frequency / difficulty
  bool hideKnown; // hide words with 3+ review sessions

  // 6. Search scope
  String searchScope; // 'all' | 'french' | 'english' | 'example'

  // Quick filters
  bool inJournal;
  // (audio is implied since all words have TTS)

  // Text search query
  String query;

  // Alphabetical letter jump target
  String? jumpLetter;

  FilterState({
    this.level = 'tous',
    this.pos = 'tous',
    this.gender,
    this.verbRegular = false,
    this.verbIrregular = false,
    this.verbReflexive = false,
    this.verbAuxiliary = false,
    this.hideKnown = false,
    this.searchScope = 'all',
    this.inJournal = false,
    this.query = '',
    this.jumpLetter,
  });

  /// Whether any filter is active (excluding search).
  bool get hasActiveFilters =>
      level != 'tous' ||
      pos != 'tous' ||
      gender != null ||
      verbRegular ||
      verbIrregular ||
      verbReflexive ||
      verbAuxiliary ||
      hideKnown ||
      inJournal;

  /// Human-readable description of active filters.
  List<String> get activeFilterLabels {
    final labels = <String>[];
    if (level != 'tous') labels.add(level);
    if (pos != 'tous') {
      switch (pos) {
        case 'verb': labels.add('Verbs'); break;
        case 'noun': labels.add('Nouns'); break;
        case 'adjective': labels.add('Adjectives'); break;
        case 'adverb': labels.add('Adverbs'); break;
        case 'pronoun': labels.add('Pronouns'); break;
        case 'preposition': labels.add('Prepositions'); break;
        case 'conjunction': labels.add('Conjunctions'); break;
      }
    }
    if (gender != null) labels.add(gender == 'masculine' ? '♂ Masc' : '♀ Fem');
    if (verbRegular && !verbIrregular && !verbReflexive) labels.add('Regular');
    if (verbIrregular && !verbRegular) labels.add('Irregular');
    if (verbReflexive) labels.add('Reflexive');
    if (verbAuxiliary) labels.add('Auxiliary');
    if (inJournal) labels.add('Journal');
    return labels;
  }

  /// Apply all filters to a word list.
  List<Word> apply(List<Word> words, {bool Function(String)? isInJournal}) {
    return words.where((w) {
      // 1. Level filter
      if (level != 'tous' && w.level != level) return false;

      // 2. POS filter
      if (pos != 'tous' && w.type != pos) return false;

      // 3. Gender filter (nouns only)
      if (gender != null) {
        if (!w.isNoun) return false;
        if (gender == 'masculine' && !w.isMasculine) return false;
        if (gender == 'feminine' && !w.isFeminine) return false;
      }

      // 4. Verb attribute filters
      if (verbRegular && !w.isRegular) return false;
      if (verbIrregular && !w.isIrregular) return false;
      if (verbReflexive && !w.isReflexive) return false;
      if (verbAuxiliary && !w.isAuxiliary) return false;

      // 5. Known words filter
      if (hideKnown && isInJournal != null) {
        // We delegate journal review count check to the caller
      }

      // 6. Quick filter: in journal
      if (inJournal && isInJournal != null) {
        if (!isInJournal(w.fr)) return false;
      }

      // 7. Search query
      if (query.isNotEmpty && !w.matches(query, scope: searchScope)) return false;

      return true;
    }).toList();
  }

  /// Count how many words match in each level.
  int levelCount(String lv, List<Word> words) =>
      words.where((w) => w.level == lv).length;

  FilterState copy() => FilterState(
        level: level,
        pos: pos,
        gender: gender,
        verbRegular: verbRegular,
        verbIrregular: verbIrregular,
        verbReflexive: verbReflexive,
        verbAuxiliary: verbAuxiliary,
        hideKnown: hideKnown,
        searchScope: searchScope,
        inJournal: inJournal,
        query: query,
        jumpLetter: jumpLetter,
      );

  void reset() {
    level = 'tous';
    pos = 'tous';
    gender = null;
    verbRegular = false;
    verbIrregular = false;
    verbReflexive = false;
    verbAuxiliary = false;
    hideKnown = false;
    searchScope = 'all';
    inJournal = false;
    query = '';
    jumpLetter = null;
  }
}
