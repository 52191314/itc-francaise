import 'package:flutter/material.dart';
import '../models/word_entry.dart';
import '../services/data_service.dart';
import '../theme/colors.dart';

class FlashcardsScreen extends StatefulWidget {
  final DataService dataService;

  const FlashcardsScreen({super.key, required this.dataService});

  @override
  State<FlashcardsScreen> createState() => _FlashcardsScreenState();
}

class _FlashcardsScreenState extends State<FlashcardsScreen> {
  int _currentIndex = 0;
  bool _showBack = false;
  String _selectedLevel = 'All';

  List<WordEntry> get _cards {
    if (_selectedLevel == 'All') return widget.dataService.dictionary;
    return widget.dataService.dictionary.where((w) => w.level == _selectedLevel).toList();
  }

  void _nextCard() {
    setState(() {
      _showBack = false;
      if (_currentIndex < _cards.length - 1) {
        _currentIndex++;
      } else {
        _currentIndex = 0;
      }
    });
  }

  void _prevCard() {
    setState(() {
      _showBack = false;
      if (_currentIndex > 0) {
        _currentIndex--;
      } else {
        _currentIndex = _cards.length - 1;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final cards = _cards;

    if (cards.isEmpty) {
      return Scaffold(
        appBar: AppBar(title: const Text('Flashcards')),
        body: const Center(child: Text('Aucune carte de vocabulaire.')),
      );
    }

    if (_currentIndex >= cards.length) {
      _currentIndex = 0;
    }

    final card = cards[_currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Révision Flashcards'),
        actions: [
          DropdownButton<String>(
            key: const Key('flashcard_level_dropdown'),
            value: _selectedLevel,
            underline: const SizedBox(),
            icon: const Icon(Icons.filter_list),
            items: ['All', 'A1', 'A2', 'B1'].map((lvl) {
              return DropdownMenuItem(
                value: lvl,
                child: Text(lvl == 'All' ? 'Tous Niveaux' : 'Niveau $lvl'),
              );
            }).toList(),
            onChanged: (val) {
              if (val != null) {
                setState(() {
                  _selectedLevel = val;
                  _currentIndex = 0;
                  _showBack = false;
                });
              }
            },
          ),
          const SizedBox(width: 16),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(24.0),
        child: Column(
          children: [
            LinearProgressIndicator(
              value: (_currentIndex + 1) / cards.length,
              borderRadius: BorderRadius.circular(8),
              color: AppColors.terracottaPrimary,
            ),
            const SizedBox(height: 12),
            Text(
              'Carte ${_currentIndex + 1} / ${cards.length}',
              style: const TextStyle(color: AppColors.textMuted, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            Expanded(
              child: GestureDetector(
                key: const Key('flashcard_flip_area'),
                onTap: () {
                  setState(() {
                    _showBack = !_showBack;
                  });
                },
                child: Card(
                  elevation: 4,
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
                  color: _showBack ? AppColors.badgeLevelBg : AppColors.badgeCatBg,
                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(32),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Chip(
                          label: Text(card.level),
                          backgroundColor: Colors.white,
                        ),
                        const SizedBox(height: 20),
                        Text(
                          _showBack ? card.english : card.french,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: _showBack ? 22 : 30,
                            fontWeight: FontWeight.bold,
                            color: AppColors.textPrimary,
                          ),
                        ),
                        const SizedBox(height: 16),
                        if (_showBack && card.example.isNotEmpty)
                          Padding(
                            padding: const EdgeInsets.only(top: 16.0),
                            child: Text(
                              card.example,
                              textAlign: TextAlign.center,
                              style: const TextStyle(fontStyle: FontStyle.italic, color: AppColors.textSecondary),
                            ),
                          ),
                        const SizedBox(height: 24),
                        const Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(Icons.flip, size: 18, color: AppColors.textMuted),
                            SizedBox(width: 6),
                            Text(
                              'Appuyez pour retourner',
                              style: TextStyle(color: AppColors.textMuted, fontSize: 13),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 24),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                IconButton.filledTonal(
                  key: const Key('flashcard_prev_btn'),
                  iconSize: 32,
                  onPressed: _prevCard,
                  icon: const Icon(Icons.arrow_back),
                ),
                ElevatedButton.icon(
                  key: const Key('flashcard_flip_btn'),
                  onPressed: () {
                    setState(() {
                      _showBack = !_showBack;
                    });
                  },
                  icon: const Icon(Icons.rotate_right),
                  label: Text(_showBack ? 'Voir Français' : 'Voir Anglais'),
                ),
                IconButton.filled(
                  key: const Key('flashcard_next_btn'),
                  iconSize: 32,
                  onPressed: _nextCard,
                  icon: const Icon(Icons.arrow_forward),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
