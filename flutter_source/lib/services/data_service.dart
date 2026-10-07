import 'dart:convert';
import 'package:flutter/services.dart';
import '../models/word_entry.dart';
import '../models/paragraph.dart';

enum SortMode { alphabetical, level, topic }

class DataService {
  List<WordEntry> _dictionary = [];
  List<ParagraphItem> _paragraphs = [];
  bool _isLoaded = false;

  List<WordEntry> get dictionary => _dictionary;
  List<ParagraphItem> get paragraphs => _paragraphs;
  bool get isLoaded => _isLoaded;

  int get totalCount => _dictionary.length;
  int get a1Count => _dictionary.where((w) => w.level == 'A1').length;
  int get a2Count => _dictionary.where((w) => w.level == 'A2').length;
  int get b1Count => _dictionary.where((w) => w.level == 'B1').length;

  Future<void> loadData({String? dictJsonStr, String? paraJsonStr}) async {
    try {
      final String dictContent = dictJsonStr ?? await rootBundle.loadString('assets/data/normalized_dictionary.json');
      final String paraContent = paraJsonStr ?? await rootBundle.loadString('assets/data/topical_paragraphs.json');

      final List<dynamic> dictList = jsonDecode(dictContent);
      final List<dynamic> paraList = jsonDecode(paraContent);

      _dictionary = dictList.map((e) => WordEntry.fromJson(e)).toList();
      _paragraphs = paraList.map((e) => ParagraphItem.fromJson(e)).toList();
      _sortAlphabetically();
      _isLoaded = true;
    } catch (e) {
      // Fallback to legacy files if normalized names fail
      try {
        final String dictContent = dictJsonStr ?? await rootBundle.loadString('assets/data/dictionary.json');
        final String paraContent = paraJsonStr ?? await rootBundle.loadString('assets/data/paragraphs.json');

        final List<dynamic> dictList = jsonDecode(dictContent);
        final List<dynamic> paraList = jsonDecode(paraContent);

        _dictionary = dictList.map((e) => WordEntry.fromJson(e)).toList();
        _paragraphs = paraList.map((e) => ParagraphItem.fromJson(e)).toList();
        _sortAlphabetically();
        _isLoaded = true;
      } catch (err) {
        _isLoaded = true;
      }
    }
  }

  void _sortAlphabetically() {
    _dictionary.sort((a, b) {
      final aClean = removeAccents(a.french);
      final bClean = removeAccents(b.french);
      return aClean.compareTo(bClean);
    });
  }

  void loadFromList(List<WordEntry> dict, [List<ParagraphItem>? paras]) {
    _dictionary = dict;
    _sortAlphabetically();
    if (paras != null) _paragraphs = paras;
    _isLoaded = true;
  }

  static String removeAccents(String str) {
    return str
        .toLowerCase()
        .replaceAll(RegExp(r'[éèêë]'), 'e')
        .replaceAll(RegExp(r'[àâä]'), 'a')
        .replaceAll(RegExp(r'[îï]'), 'i')
        .replaceAll(RegExp(r'[ôö]'), 'o')
        .replaceAll(RegExp(r'[ùûü]'), 'u')
        .replaceAll(RegExp(r'ç'), 'c')
        .trim();
  }

  List<WordEntry> filterDictionary({
    String query = '',
    String selectedLevel = 'All',
    String selectedCategory = 'All',
    SortMode sortMode = SortMode.alphabetical,
  }) {
    final String cleanQuery = removeAccents(query);
    final String normLevel = selectedLevel.trim().toUpperCase();

    final filtered = _dictionary.where((entry) {
      final String entryLevel = entry.level.toUpperCase();
      final bool matchesLevel = (normLevel == 'ALL' || normLevel == '' || entryLevel == normLevel);
      final bool matchesCategory = (selectedCategory == 'All' ||
          selectedCategory.trim().isEmpty ||
          entry.pos.toLowerCase() == selectedCategory.toLowerCase());

      if (!matchesLevel || !matchesCategory) return false;
      if (cleanQuery.isEmpty) return true;

      final String frClean = removeAccents(entry.french);
      final String enClean = removeAccents(entry.english);

      return frClean.contains(cleanQuery) || enClean.contains(cleanQuery);
    }).toList();

    if (sortMode == SortMode.alphabetical) {
      filtered.sort((a, b) => removeAccents(a.french).compareTo(removeAccents(b.french)));
    } else if (sortMode == SortMode.level) {
      filtered.sort((a, b) => a.level.compareTo(b.level));
    } else if (sortMode == SortMode.topic) {
      filtered.sort((a, b) => a.category.compareTo(b.category));
    }

    return filtered;
  }

  WordEntry? findWordDefinition(String word) {
    final String cleanWord = removeAccents(word.replaceAll(RegExp(r'[^\wàâäéèêëîïôöùûüçÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ]'), ''));
    if (cleanWord.length < 2) return null;

    try {
      return _dictionary.firstWhere(
        (entry) => removeAccents(entry.french) == cleanWord || removeAccents(entry.french).contains(cleanWord),
      );
    } catch (_) {
      return WordEntry(
        id: 'dyn_$cleanWord',
        french: cleanWord,
        english: 'French A1-B1 vocabulary word ($cleanWord)',
        level: 'A1',
        category: 'Vocabulaire',
        example: 'Utilisation: Ce mot fait partie du vocabulaire courant.',
      );
    }
  }
}
