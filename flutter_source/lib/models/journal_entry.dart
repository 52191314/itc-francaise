/// A word saved to Le Journal with personal notes, tags, and SRS state.
class JournalEntry {
  final String word; // French word
  final String english; // English translation
  final String type; // 'verb' | 'noun' | 'adjective' | 'adverb'
  final String level; // 'A1' | 'A2'
  final DateTime dateAdded;
  String notes;
  List<String> tags;

  // SRS fields
  int reviewLevel; // 0 = new, 1-5 = mastered
  DateTime? lastReviewed;
  int correctCount;
  int incorrectCount;

  JournalEntry({
    required this.word,
    required this.english,
    required this.type,
    required this.level,
    DateTime? dateAdded,
    this.notes = '',
    List<String>? tags,
    this.reviewLevel = 0,
    this.lastReviewed,
    this.correctCount = 0,
    this.incorrectCount = 0,
  }) : dateAdded = dateAdded ?? DateTime.now(),
       tags = tags ?? [];

  double get mastery =>
      (correctCount + incorrectCount) == 0
          ? 0
          : correctCount / (correctCount + incorrectCount);

  bool get needsReview {
    if (reviewLevel == 0) return true;
    if (lastReviewed == null) return true;
    final daysSinceReview = DateTime.now().difference(lastReviewed!).inDays;
    // Interval increases with level: 1d, 2d, 4d, 8d, 16d, 32d
    final interval = (1 << reviewLevel).clamp(1, 32);
    return daysSinceReview >= interval;
  }

  void recordReview(bool correct) {
    if (correct) {
      correctCount++;
      reviewLevel = (reviewLevel + 1).clamp(0, 5);
    } else {
      incorrectCount++;
      reviewLevel = (reviewLevel - 1).clamp(0, 5);
    }
    lastReviewed = DateTime.now();
  }

  Map<String, dynamic> toJson() => {
        'word': word,
        'english': english,
        'type': type,
        'level': level,
        'dateAdded': dateAdded.toIso8601String(),
        'notes': notes,
        'tags': tags,
        'reviewLevel': reviewLevel,
        'lastReviewed': lastReviewed?.toIso8601String(),
        'correctCount': correctCount,
        'incorrectCount': incorrectCount,
      };

  factory JournalEntry.fromJson(Map<String, dynamic> json) => JournalEntry(
        word: json['word'] as String,
        english: json['english'] as String,
        type: json['type'] as String,
        level: json['level'] as String,
        dateAdded: DateTime.parse(json['dateAdded'] as String),
        notes: json['notes'] as String? ?? '',
        tags: (json['tags'] as List?)?.cast<String>() ?? [],
        reviewLevel: json['reviewLevel'] as int? ?? 0,
        lastReviewed: json['lastReviewed'] != null
            ? DateTime.parse(json['lastReviewed'] as String)
            : null,
        correctCount: json['correctCount'] as int? ?? 0,
        incorrectCount: json['incorrectCount'] as int? ?? 0,
      );
}
