class QuizQuestion {
  final String id;
  final String level;   // 'A1' | 'A2'
  final String mode;    // 'qcm' | 'fill'
  final String question;
  final List<String> choices;   // 4 choices for QCM; empty for fill
  final String answer;
  final String? explanation;

  const QuizQuestion({
    required this.id,
    required this.level,
    required this.mode,
    required this.question,
    required this.choices,
    required this.answer,
    this.explanation,
  });

  bool get isQcm => mode == 'qcm';

  bool checkAnswer(String userAnswer) {
    return userAnswer.trim().toLowerCase() == answer.trim().toLowerCase();
  }
}
