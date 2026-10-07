import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:french_pro/screens/vocabulary_screen.dart';
import 'package:french_pro/data/writing_data.dart';
import 'package:french_pro/models/writing_text.dart';
import 'package:french_pro/screens/writing_practice_screen.dart';
import 'package:french_pro/theme/app_theme.dart';

double contrastRatio(Color foreground, Color background) {
  final lighter = foreground.computeLuminance() > background.computeLuminance()
      ? foreground.computeLuminance()
      : background.computeLuminance();
  final darker = foreground.computeLuminance() > background.computeLuminance()
      ? background.computeLuminance()
      : foreground.computeLuminance();
  return (lighter + 0.05) / (darker + 0.05);
}

void main() {
  test('light theme body text keeps readable contrast', () {
    final theme = AppTheme.lightTheme;
    expect(
      contrastRatio(theme.textTheme.bodyMedium!.color!, AppTheme.bgLight),
      greaterThan(7),
    );
    expect(
      contrastRatio(theme.textTheme.bodySmall!.color!, AppTheme.cardLight),
      greaterThan(4.5),
    );
  });

  test('writing practice provides 240 balanced A1/A2 model texts', () {
    expect(kWritingTexts.length, 240);
    expect(kWritingTexts.where((text) => text.level == 'A1').length, 120);
    expect(kWritingTexts.where((text) => text.level == 'A2').length, 120);
    expect(kWritingTexts.every((text) => text.grammarExplanation.isNotEmpty),
        isTrue);
    final suspiciousTexts = kWritingTexts
        .where((text) =>
            text.text.contains('en à pied') ||
            text.text.contains('en le ') ||
            text.text.contains('en la ') ||
            text.text.contains('avons lire') ||
            text.text.contains('à le '))
        .map((text) => '${text.id}: ${text.text}')
        .toList();
    expect(suspiciousTexts, isEmpty);
  });

  testWidgets('vocabulary level chips filter A1 and A2 words', (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: VocabularyScreen()),
    );
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('300 / 300'), findsOneWidget);

    await tester.tap(find.byKey(const Key('vocab-level-A2')));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('180 / 300'), findsOneWidget);

    await tester.tap(find.byKey(const Key('vocab-level-A1')));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('120 / 300'), findsOneWidget);

    await tester.pumpWidget(const SizedBox.shrink());
    await tester.pump(const Duration(seconds: 1));
  });

  testWidgets('writing practice level filters show 120 texts each',
      (tester) async {
    await tester.pumpWidget(
      const MaterialApp(home: WritingPracticeScreen()),
    );
    await tester.pump(const Duration(seconds: 1));

    expect(find.text('240 / 240'), findsOneWidget);

    await tester.tap(find.byKey(const Key('writing-level-A2')));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('120 / 240'), findsOneWidget);

    await tester.tap(find.byKey(const Key('writing-level-A1')));
    await tester.pump(const Duration(seconds: 1));
    expect(find.text('120 / 240'), findsOneWidget);
  });

  testWidgets('WritingTextDetailScreen renders sticky writing pad and functions correctly',
      (tester) async {
    const text = WritingText(
      id: 'test-1',
      level: 'A1',
      category: 'Family',
      title: 'Ma Famille',
      task: 'Describe your family.',
      text: 'J\'ai une grande famille.',
      grammarFocus: 'Possessive adjectives',
      grammarExplanation: 'Use mon/ma/mes.',
    );

    await tester.pumpWidget(
      const MaterialApp(
        home: WritingTextDetailScreen(text: text),
      ),
    );

    // Verify detail screen content is loaded
    expect(find.text('Ma Famille'), findsOneWidget);
    expect(find.text('Describe your family.'), findsOneWidget);

    // Verify sticky writing pad is initially expanded
    expect(find.text('Practice Writing Pad'), findsOneWidget);
    expect(find.text('(0 words)'), findsOneWidget);

    // Enter some text into the practice writing pad
    await tester.enterText(
      find.byType(TextField),
      'Mon pere est grand. Ma mere est gentille.',
    );
    await tester.pump();

    // Verify word count (8 words)
    expect(find.text('(8 words)'), findsOneWidget);

    // Minimize the writing pad
    await tester.tap(find.byIcon(Icons.keyboard_arrow_down_rounded));
    await tester.pump();

    // Verify it is minimized (shows "Open Practice Writing Pad")
    expect(find.text('Open Practice Writing Pad'), findsOneWidget);
    expect(find.text('8 words'), findsOneWidget);

    // Expand the writing pad again
    await tester.tap(find.text('Open Practice Writing Pad'));
    await tester.pump();

    // Verify it is expanded again
    expect(find.text('Practice Writing Pad'), findsOneWidget);

    // Clear the draft
    await tester.tap(find.byIcon(Icons.delete_sweep_rounded));
    await tester.pump();

    // Verify word count is back to 0
    expect(find.text('(0 words)'), findsOneWidget);
  });
}
