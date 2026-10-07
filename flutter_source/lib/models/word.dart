/// A French vocabulary word with optional conjugation data.
class Word {
  final String type;    // 'verb' | 'noun' | 'adjective' | 'adverb'
  final String level;   // 'A1' | 'A2'
  final String fr;      // French word
  final String en;      // English translation
  final String example; // Example sentence
  final List<List<String>>? conj; // [tense][pronoun] — verbs only

  const Word({
    required this.type,
    required this.level,
    required this.fr,
    required this.en,
    required this.example,
    this.conj,
  });

  bool get isVerb => type == 'verb';

  /// Returns all 6 pronoun forms for a given tense index (0–5).
  List<String> conjugationForTense(int tenseIndex) {
    if (conj == null || tenseIndex >= conj!.length) return [];
    return conj![tenseIndex];
  }

  /// Flat list of all conjugated forms (for search matching).
  List<String> get allConjForms =>
      conj?.expand((t) => t).toList() ?? [];

  /// Match against a search query (checks fr, en, example).
  bool matches(String query) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    return fr.toLowerCase().contains(q) ||
        en.toLowerCase().contains(q) ||
        example.toLowerCase().contains(q);
  }

  @override
  String toString() => 'Word($fr / $en [$level $type])';
}

// ── Tense and pronoun labels ──────────────────────────────────
const List<String> kPronouns = [
  'je', 'tu', 'il / elle', 'nous', 'vous', 'ils / elles',
];

const List<String> kTenses = [
  'Présent',
  'Imparfait',
  'Passé composé',
  'Futur simple',
  'Futur proche',
  'Conditionnel',
];
