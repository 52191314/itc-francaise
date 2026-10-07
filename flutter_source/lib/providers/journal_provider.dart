import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/journal_entry.dart';

class JournalProvider extends ChangeNotifier {
  static const _key = 'journal_entries_v2';
  List<JournalEntry> _entries = [];
  SharedPreferences? _prefs;

  List<JournalEntry> get entries => List.unmodifiable(_entries);
  int get count => _entries.length;

  List<JournalEntry> get reviewQueue =>
      _entries.where((e) => e.needsReview).toList();

  int get reviewQueueCount => reviewQueue.length;

  bool contains(String word) =>
      _entries.any((e) => e.word.toLowerCase() == word.toLowerCase());

  void init(SharedPreferences prefs) {
    _prefs = prefs;
    _load();
  }

  void _load() {
    if (_prefs == null) return;
    final data = _prefs!.getString(_key);
    if (data == null) return;
    try {
      final list = json.decode(data) as List;
      _entries = list
          .map((e) => JournalEntry.fromJson(e as Map<String, dynamic>))
          .toList();
    } catch (_) {
      _entries = [];
    }
    notifyListeners();
  }

  void _save() {
    if (_prefs == null) return;
    final data = json.encode(_entries.map((e) => e.toJson()).toList());
    _prefs!.setString(_key, data);
  }

  void add(JournalEntry entry) {
    if (contains(entry.word)) return;
    _entries.insert(0, entry);
    _save();
    notifyListeners();
  }

  void remove(String word) {
    _entries.removeWhere((e) => e.word.toLowerCase() == word.toLowerCase());
    _save();
    notifyListeners();
  }

  void toggle(String word, String english, String type, String level) {
    if (contains(word)) {
      remove(word);
    } else {
      add(JournalEntry(word: word, english: english, type: type, level: level));
    }
  }

  void updateNotes(String word, String notes) {
    final entry = _entries.firstWhere(
      (e) => e.word.toLowerCase() == word.toLowerCase(),
    );
    entry.notes = notes;
    _save();
    notifyListeners();
  }

  void updateTags(String word, List<String> tags) {
    final entry = _entries.firstWhere(
      (e) => e.word.toLowerCase() == word.toLowerCase(),
    );
    entry.tags = tags;
    _save();
    notifyListeners();
  }

  void recordReview(String word, bool correct) {
    final entry = _entries.firstWhere(
      (e) => e.word.toLowerCase() == word.toLowerCase(),
    );
    entry.recordReview(correct);
    _save();
    notifyListeners();
  }

  void clearAll() {
    _entries.clear();
    _save();
    notifyListeners();
  }
}
