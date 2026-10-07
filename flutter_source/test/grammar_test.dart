import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:french_pro/data/grammar_data.dart';
import 'package:french_pro/screens/grammar_screen.dart';

void main() {
  group('Grammar Handbook Data Validation', () {
    test('provides exactly 51 rules', () {
      expect(grammarRules.length, 51);
    });

    test('rules have correct levels (33 A1, 18 A2)', () {
      final a1Rules = grammarRules.where((r) => r.level == 'A1').toList();
      final a2Rules = grammarRules.where((r) => r.level == 'A2').toList();

      expect(a1Rules.length, 33);
      expect(a2Rules.length, 18);
      expect(grammarRules.every((r) => r.level == 'A1' || r.level == 'A2'), isTrue);
    });

    test('rules have non-empty required properties', () {
      expect(grammarRules.every((r) => r.title.isNotEmpty), isTrue);
      expect(grammarRules.every((r) => r.rule.isNotEmpty), isTrue);
      expect(grammarRules.every((r) => r.pattern.isNotEmpty), isTrue);
      expect(grammarRules.every((r) => r.examples.isNotEmpty), isTrue);
    });

    test('A2 rules are populated with detailed steps/trap/tables', () {
      // Rules 34 to 51 are A2 rules
      final a2Rules = grammarRules.where((r) => r.level == 'A2');
      
      expect(a2Rules.every((r) => r.summary != null || r.explain != null), isTrue);
      expect(a2Rules.any((r) => r.trap != null), isTrue);
      expect(a2Rules.any((r) => r.steps != null && r.steps!.isNotEmpty), isTrue);
      expect(a2Rules.any((r) => r.tables != null && r.tables!.isNotEmpty), isTrue);
    });
  });

  group('Grammar Handbook Widget Tests', () {
    testWidgets('level chips filter A1 and A2 rules', (WidgetTester tester) async {
      await tester.pumpWidget(
        const MaterialApp(home: GrammarScreen()),
      );
      await tester.pump(const Duration(seconds: 1));

      // Initial state: All 51 rules visible
      expect(find.text('51 / 51'), findsOneWidget);

      // Tap A2 chip
      await tester.tap(find.byKey(const Key('grammar-level-A2')));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('18 / 51'), findsOneWidget);

      // Tap A1 chip
      await tester.tap(find.byKey(const Key('grammar-level-A1')));
      await tester.pump(const Duration(seconds: 1));
      expect(find.text('33 / 51'), findsOneWidget);

      // Clean up
      await tester.pumpWidget(const SizedBox.shrink());
      await tester.pump(const Duration(seconds: 1));
    });
  });
}
