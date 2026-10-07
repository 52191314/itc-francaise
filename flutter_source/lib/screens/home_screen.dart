import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../theme/colors.dart';
import '../theme/typography.dart';
import '../widgets/word_card.dart';

class HomeScreen extends StatelessWidget {
  final DataService dataService;

  const HomeScreen({super.key, required this.dataService});

  @override
  Widget build(BuildContext context) {
    final words = dataService.dictionary.take(10).toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Le Lexique — Accueil'),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.all(16),
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.terracottaPrimary,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Bienvenue dans Le Lexique',
                    style: TextStyle(
                      fontFamily: AppTypography.fontFamilyHeader,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Explorez ${dataService.totalCount} mots de vocabulaire français A1, A2 et B1.',
                    style: const TextStyle(color: Colors.white70, fontSize: 14),
                  ),
                ],
              ),
            ),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Text(
                'Mots recommandés du jour',
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
            ),
            ...words.map((w) => WordCard(word: w)),
          ],
        ),
      ),
    );
  }
}
