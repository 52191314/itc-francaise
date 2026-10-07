/// A French vocabulary word with optional conjugation data.
class Word {
  final String type;    // 'verb' | 'noun' | 'adjective' | 'adverb' | 'pronoun' | 'preposition' | 'conjunction'
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

  // ── Computed properties ─────────────────────────────────────

  bool get isVerb => type == 'verb';
  bool get isNoun => type == 'noun';
  bool get isAdjective => type == 'adjective';

  /// Gender inferred from article prefix in the French word.
  String? get gender {
    if (!isNoun) return null;
    if (fr.startsWith('le ') || fr.startsWith("l'")) return 'masculine';
    if (fr.startsWith('la ')) return 'feminine';
    // Check for compound forms like "l'ami / l'amie"
    if (fr.contains('/')) {
      if (fr.contains('l\'')) return null; // ambiguous
    }
    return null;
  }

  /// Whether this noun has an explicitly masculine form visible.
  bool get isMasculine => gender == 'masculine';

  /// Whether this noun has an explicitly feminine form visible.
  bool get isFeminine => gender == 'feminine';

  /// Verb auxiliary type inferred from passé composé conjugation.
  String? get verbAuxiliary {
    if (!isVerb || conj == null || conj!.length < 3) return null;
    // Index 2 = passé composé. Check first form (je) for être auxiliary.
    final pc = conj![2];
    if (pc.isNotEmpty && pc[0].contains('suis')) return 'être';
    return 'avoir';
  }

  /// Whether this verb is reflexive (starts with "se " or "s'").
  bool get isReflexive {
    if (!isVerb) return false;
    return fr.startsWith('se ') || fr.startsWith("s'");
  }

  /// Whether this verb is an auxiliary verb (être or avoir).
  bool get isAuxiliary => isVerb && (fr == 'être' || fr == 'avoir');

  /// Rough verb regularity based on common irregular patterns.
  bool get isIrregular {
    if (!isVerb) return false;
    if (isAuxiliary) return true;
    if (isReflexive) return false; // base verb handles regularity
    // Common irregulars
    const irregulars = {
      'aller', 'avoir', 'être', 'faire', 'pouvoir', 'vouloir',
      'devoir', 'savoir', 'venir', 'tenir', 'voir', 'dire',
      'mettre', 'prendre', 'comprendre', 'apprendre', 'boire',
      'croire', 'écrire', 'lire', 'vivre', 'suivre', 'connaître',
      'paraître', 'plaire', 'taire', 'courir', 'mourir', 'vêtir',
      'offrir', 'ouvrir', 'couvrir', 'cueillir', 'assaillir',
    };
    final base = fr.replaceAll(RegExp(r'^se\s+'), '').replaceAll(RegExp(r"^s'"), '');
    return irregulars.contains(base);
  }

  bool get isRegular => isVerb && !isIrregular;

  /// Part-of-speech category for extended type filtering.
  String get posCategory {
    if (isVerb) return 'verb';
    if (isNoun) return 'noun';
    if (type == 'adjective') return 'adjective';
    if (type == 'adverb') return 'adverb';
    return type;
  }

  /// Plain word without article prefix (for display/sorting).
  String get frWithoutArticle {
    final articlePattern = RegExp(
      r'''^(le |la |l'|les |un |une |des |de la |du |de l')''',
      caseSensitive: false,
    );
    final stripped = fr.replaceFirst(articlePattern, '');
    // Handle "l'ami / l'amie" → "ami"
    if (stripped.contains(' / ')) {
      return stripped.split(' / ')[0].replaceFirst(RegExp(r"^(l')", caseSensitive: false), '');
    }
    return stripped;
  }

  /// Match against a search query.
  bool matches(String query, {String scope = 'all'}) {
    if (query.isEmpty) return true;
    final q = query.toLowerCase();
    switch (scope) {
      case 'french':
        return fr.toLowerCase().contains(q);
      case 'english':
        return en.toLowerCase().contains(q);
      case 'example':
        return example.toLowerCase().contains(q);
      default:
        return fr.toLowerCase().contains(q) ||
            en.toLowerCase().contains(q) ||
            example.toLowerCase().contains(q) ||
            allConjForms.any((f) => f.toLowerCase().contains(q));
    }
  }

  List<String> get allConjForms =>
      conj?.expand((t) => t).toList() ?? [];

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
