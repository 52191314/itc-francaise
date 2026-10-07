class WritingText {
  final String id;
  final String level;
  final String category;
  final String title;
  final String task;
  final String text;
  final String grammarFocus;
  final String grammarExplanation;

  const WritingText({
    required this.id,
    required this.level,
    required this.category,
    required this.title,
    required this.task,
    required this.text,
    required this.grammarFocus,
    required this.grammarExplanation,
  });

  bool matches(String query) {
    if (query.trim().isEmpty) return true;
    final q = query.trim().toLowerCase();
    return title.toLowerCase().contains(q) ||
        category.toLowerCase().contains(q) ||
        task.toLowerCase().contains(q) ||
        text.toLowerCase().contains(q) ||
        grammarFocus.toLowerCase().contains(q);
  }
}
