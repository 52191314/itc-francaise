class WordEntry {
  final String id;
  final String french;
  final String normalizedFrench;
  final String english;
  final String normalizedEnglish;
  final String level;
  final String pos;
  final String ipa;
  final String example;
  final String exampleEnglish;
  final String category;

  WordEntry({
    required this.id,
    required this.french,
    String? normalizedFrench,
    required this.english,
    String? normalizedEnglish,
    required this.level,
    this.pos = 'noun',
    this.ipa = '',
    required this.example,
    this.exampleEnglish = '',
    required this.category,
  })  : normalizedFrench = normalizedFrench ?? french.toLowerCase(),
        normalizedEnglish = normalizedEnglish ?? english.toLowerCase();

  factory WordEntry.fromJson(Map<String, dynamic> json) {
    final String fr = json['french']?.toString() ?? '';
    final String en = json['english']?.toString() ?? '';
    return WordEntry(
      id: json['id']?.toString() ?? '',
      french: fr,
      normalizedFrench: json['normalizedFrench']?.toString() ?? fr.toLowerCase(),
      english: en,
      normalizedEnglish: json['normalizedEnglish']?.toString() ?? en.toLowerCase(),
      level: json['cefrLevel']?.toString() ?? json['level']?.toString() ?? 'A1',
      pos: json['pos']?.toString() ?? 'noun',
      ipa: json['ipa']?.toString() ?? '',
      example: json['exampleFrench']?.toString() ?? json['example']?.toString() ?? '',
      exampleEnglish: json['exampleEnglish']?.toString() ?? '',
      category: json['topic']?.toString() ?? json['category']?.toString() ?? 'Vocabulaire',
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'french': french,
      'normalizedFrench': normalizedFrench,
      'english': english,
      'normalizedEnglish': normalizedEnglish,
      'cefrLevel': level,
      'level': level,
      'pos': pos,
      'ipa': ipa,
      'exampleFrench': example,
      'example': example,
      'exampleEnglish': exampleEnglish,
      'topic': category,
      'category': category,
    };
  }
}
