class StudySession {
  final int? id;
  final String type;        // 'flashcard' | 'quiz'
  final String level;       // 'A1' | 'A2' | 'mixed'
  final int total;
  final int correct;
  final DateTime createdAt;

  const StudySession({
    this.id,
    required this.type,
    required this.level,
    required this.total,
    required this.correct,
    required this.createdAt,
  });

  double get score => total > 0 ? correct / total : 0;
  int get scorePercent => (score * 100).round();

  Map<String, dynamic> toMap() => {
    if (id != null) 'id': id,
    'type':       type,
    'level':      level,
    'total':      total,
    'correct':    correct,
    'created_at': createdAt.toIso8601String(),
  };

  factory StudySession.fromMap(Map<String, dynamic> m) => StudySession(
    id:        m['id'] as int?,
    type:      m['type'] as String,
    level:     m['level'] as String,
    total:     m['total'] as int,
    correct:   m['correct'] as int,
    createdAt: DateTime.parse(m['created_at'] as String),
  );
}

class WordStat {
  final String wordFr;
  int seen;
  int correct;

  WordStat({required this.wordFr, this.seen = 0, this.correct = 0});

  int get mastery => seen == 0 ? 0 : ((correct / seen) * 5).round().clamp(0, 5);

  Map<String, dynamic> toMap() => {
    'word_fr': wordFr,
    'seen':    seen,
    'correct': correct,
  };

  factory WordStat.fromMap(Map<String, dynamic> m) => WordStat(
    wordFr:  m['word_fr'] as String,
    seen:    m['seen'] as int,
    correct: m['correct'] as int,
  );
}
