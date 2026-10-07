class GrammarRule {
  final int id;
  final String title;
  final String level;
  final String rule;
  final String pattern;
  final List<GrammarExample> examples;
  final String? note;

  // Detail fields (optional, from A2 grammar details)
  final String? summary;
  final String? explain;
  final List<String>? steps;
  final List<GrammarTable>? tables;
  final String? trap;

  const GrammarRule({
    required this.id,
    required this.title,
    required this.level,
    required this.rule,
    required this.pattern,
    required this.examples,
    this.note,
    this.summary,
    this.explain,
    this.steps,
    this.tables,
    this.trap,
  });
}

class GrammarExample {
  final String french;
  final String english;

  const GrammarExample({
    required this.french,
    required this.english,
  });
}

class GrammarTable {
  final String? title;
  final List<String> headers;
  final List<List<String>> rows;

  const GrammarTable({
    this.title,
    required this.headers,
    required this.rows,
  });
}
