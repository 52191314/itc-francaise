class QuizQuestion {
  final String question;
  final List<String> options;
  final String answer;

  QuizQuestion({
    required this.question,
    required this.options,
    required this.answer,
  });

  factory QuizQuestion.fromJson(Map<String, dynamic> json) {
    return QuizQuestion(
      question: json['question']?.toString() ?? '',
      options: (json['options'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      answer: json['answer']?.toString() ?? '',
    );
  }
}

class ParagraphItem {
  final String id;
  final String title;
  final String level;
  final String topic;
  final String content;
  final String translation;
  final List<String> vocabHighlights;
  final List<QuizQuestion> questions;

  ParagraphItem({
    required this.id,
    required this.title,
    required this.level,
    required this.topic,
    required this.content,
    required this.translation,
    required this.vocabHighlights,
    required this.questions,
  });

  factory ParagraphItem.fromJson(Map<String, dynamic> json) {
    return ParagraphItem(
      id: json['id']?.toString() ?? '',
      title: json['title']?.toString() ?? '',
      level: json['level']?.toString() ?? 'A1',
      topic: json['topic']?.toString() ?? 'Général',
      content: json['content']?.toString() ?? '',
      translation: json['translation']?.toString() ?? '',
      vocabHighlights: (json['vocab_highlights'] as List<dynamic>?)?.map((e) => e.toString()).toList() ?? [],
      questions: (json['questions'] as List<dynamic>?)?.map((q) => QuizQuestion.fromJson(q)).toList() ?? [],
    );
  }
}
