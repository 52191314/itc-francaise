import 'package:flutter/material.dart';
import '../data/vocab_data.dart';
import '../models/word.dart';

class VocabProvider extends ChangeNotifier {
  List<Word> get all => kVocab;

  List<Word> filter({String level = 'all', String type = 'all', String query = ''}) {
    return kVocab.where((w) {
      if (level != 'all' && w.level.toLowerCase() != level.toLowerCase()) return false;
      if (type  != 'all' && w.type.toLowerCase()  != type.toLowerCase())  return false;
      return w.matches(query);
    }).toList();
  }
}
