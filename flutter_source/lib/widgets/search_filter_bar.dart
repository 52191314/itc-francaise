import 'package:flutter/material.dart';
import '../theme/colors.dart';

class SearchFilterBar extends StatelessWidget {
  final TextEditingController searchController;
  final String selectedLevel;
  final String selectedCategory;
  final ValueChanged<String> onLevelChanged;
  final ValueChanged<String> onCategoryChanged;
  final VoidCallback? onSpeechInputTap;

  static const List<String> levels = ['All', 'A1', 'A2', 'B1'];

  // Labels → actual data pos values (must match what's in JSON exactly)
  static const Map<String, String> posFilters = {
    'Tous': 'All',
    'Nom': 'noun',
    'Verbe': 'verb',
    'Adjectif': 'adjective',
    'Adverbe': 'adverb',
    'Expression': 'expression',
    'Nombre': 'number',
    'Pronom': 'pronoun',
  };

  static List<String> get categories => posFilters.keys.toList();

  const SearchFilterBar({
    super.key,
    required this.searchController,
    required this.selectedLevel,
    required this.selectedCategory,
    required this.onLevelChanged,
    required this.onCategoryChanged,
    this.onSpeechInputTap,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        // Capsule Search Input Bar
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: TextField(
            key: const Key('search_input'),
            controller: searchController,
            decoration: InputDecoration(
              hintText: 'Rechercher un mot...',
              prefixIcon: const Icon(Icons.search, color: AppColors.textMuted),
              suffixIcon: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  if (searchController.text.isNotEmpty)
                    IconButton(
                      icon: const Icon(Icons.clear, size: 20),
                      onPressed: () => searchController.clear(),
                    ),
                  IconButton(
                    key: const Key('speech_mic_btn'),
                    icon: const Icon(Icons.mic, color: AppColors.terracottaSecondary),
                    onPressed: onSpeechInputTap,
                  ),
                ],
              ),
              contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              filled: true,
              fillColor: Colors.white,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(28),
                borderSide: BorderSide.none,
              ),
            ),
          ),
        ),
        // Level Filter Pills
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: levels.map((lvl) {
              final bool isSelected = selectedLevel == lvl;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: FilterChip(
                  key: Key('level_pill_$lvl'),
                  label: Text(lvl == 'All' ? 'Tous' : lvl),
                  selected: isSelected,
                  selectedColor: AppColors.terracottaPrimary,
                  labelStyle: TextStyle(
                    color: isSelected ? Colors.white : AppColors.textPrimary,
                    fontWeight: FontWeight.bold,
                  ),
                  backgroundColor: Colors.white,
                  onSelected: (_) => onLevelChanged(lvl),
                ),
              );
            }).toList(),
          ),
        ),
        // POS Filter Pills
        SingleChildScrollView(
          scrollDirection: Axis.horizontal,
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
          child: Row(
            children: posFilters.entries.map((entry) {
              final String label = entry.key;
              final String posValue = entry.value;
              final bool isSelected = selectedCategory == posValue;
              return Padding(
                padding: const EdgeInsets.only(right: 8.0),
                child: ChoiceChip(
                  key: Key('cat_pill_$posValue'),
                  label: Text(label),
                  selected: isSelected,
                  selectedColor: AppColors.badgeCatBg,
                  labelStyle: TextStyle(
                    color: isSelected ? AppColors.terracottaPrimary : AppColors.textSecondary,
                    fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                  ),
                  onSelected: (_) => onCategoryChanged(posValue),
                ),
              );
            }).toList(),
          ),
        ),
      ],
    );
  }
}
