import 'package:flutter/material.dart';
import '../services/data_service.dart';
import 'flashcards_screen.dart';

class FlashcardScreen extends StatelessWidget {
  final DataService dataService;

  const FlashcardScreen({super.key, required this.dataService});

  @override
  Widget build(BuildContext context) {
    return FlashcardsScreen(dataService: dataService);
  }
}
