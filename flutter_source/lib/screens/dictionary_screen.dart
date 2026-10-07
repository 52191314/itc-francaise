import 'package:flutter/material.dart';
import '../models/word_entry.dart';
import '../services/data_service.dart';
import '../services/tts_service.dart';
import '../theme/colors.dart';
import '../widgets/top_bar.dart';
import '../widgets/search_filter_bar.dart';
import '../widgets/word_card.dart';

class DictionaryScreen extends StatefulWidget {
  final DataService dataService;

  const DictionaryScreen({super.key, required this.dataService});

  @override
  State<DictionaryScreen> createState() => _DictionaryScreenState();
}

class _DictionaryScreenState extends State<DictionaryScreen> {
  final TextEditingController _searchController = TextEditingController();
  final TTSService _ttsService = TTSService();
  String _selectedLevel = 'All';
  String _selectedCategory = 'All';
  List<WordEntry> _filteredList = [];

  @override
  void initState() {
    super.initState();
    _filteredList = widget.dataService.dictionary;
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void dispose() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    super.dispose();
  }

  void _onSearchChanged() {
    _applyFilter();
  }

  void _applyFilter() {
    setState(() {
      _filteredList = widget.dataService.filterDictionary(
        query: _searchController.text,
        selectedLevel: _selectedLevel,
        selectedCategory: _selectedCategory,
      );
    });
  }

  void _playTts(String text) {
    _ttsService.speak(text);
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Lecture audio: "$text"'),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void _simulateSpeechInput() {
    _searchController.text = 'bonjour';
    _applyFilter();
  }

  String _getInitialLetter(String text) {
    final clean = DataService.removeAccents(text);
    if (clean.isEmpty) return '#';
    final char = clean[0].toUpperCase();
    if (RegExp(r'[A-Z]').hasMatch(char)) {
      return char;
    }
    return '#';
  }

  @override
  Widget build(BuildContext context) {
    final int count = _filteredList.length;
    final int total = widget.dataService.totalCount > 0 ? widget.dataService.totalCount : 300;

    return Scaffold(
      appBar: TopBar(
        count: count,
        total: total,
        onToggleFlashcards: () {},
      ),
      body: Column(
        children: [
          SearchFilterBar(
            searchController: _searchController,
            selectedLevel: _selectedLevel,
            selectedCategory: _selectedCategory,
            onLevelChanged: (lvl) {
              setState(() {
                _selectedLevel = lvl;
                _applyFilter();
              });
            },
            onCategoryChanged: (cat) {
              setState(() {
                _selectedCategory = cat;
                _applyFilter();
              });
            },
            onSpeechInputTap: _simulateSpeechInput,
          ),
          const Divider(height: 1),
          // Result Summary & Alphabetical Indicator
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    Text(
                      '$count mots trouvés',
                      style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 13),
                    ),
                    const SizedBox(width: 8),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                      decoration: BoxDecoration(
                        color: AppColors.badgeCatBg,
                        borderRadius: BorderRadius.circular(6),
                      ),
                      child: const Text(
                        'Tri A–Z',
                        style: TextStyle(
                          color: AppColors.terracottaSecondary,
                          fontSize: 11,
                          fontWeight: FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
                if (_selectedLevel != 'All' || _selectedCategory != 'All' || _searchController.text.isNotEmpty)
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _selectedLevel = 'All';
                        _selectedCategory = 'All';
                        _searchController.clear();
                        _applyFilter();
                      });
                    },
                    child: const Text(
                      'Réinitialiser filtres',
                      style: TextStyle(color: Colors.red, fontSize: 12, fontWeight: FontWeight.bold),
                    ),
                  ),
              ],
            ),
          ),
          // Word List View with Alphabetical Section Dividers
          Expanded(
            child: _filteredList.isEmpty
                ? const Center(
                    child: Text('Aucun mot correspondant trouvé.'),
                  )
                : ListView.builder(
                    padding: const EdgeInsets.only(bottom: 16),
                    itemCount: _filteredList.length,
                    itemBuilder: (context, index) {
                      final item = _filteredList[index];
                      final currentLetter = _getInitialLetter(item.french);
                      final bool showHeader = index == 0 || _getInitialLetter(_filteredList[index - 1].french) != currentLetter;

                      return Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          if (showHeader)
                            Padding(
                              padding: const EdgeInsets.only(left: 20, top: 12, bottom: 4),
                              child: Row(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 3),
                                    decoration: BoxDecoration(
                                      color: AppColors.terracottaPrimary,
                                      borderRadius: BorderRadius.circular(10),
                                    ),
                                    child: Text(
                                      currentLetter,
                                      style: const TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 13,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(width: 8),
                                  const Expanded(child: Divider(thickness: 1)),
                                ],
                              ),
                            ),
                          WordCard(
                            word: item,
                            onPlayTts: () => _playTts(item.french),
                          ),
                        ],
                      );
                    },
                  ),
          ),
        ],
      ),
    );
  }
}
