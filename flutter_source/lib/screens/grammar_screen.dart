import 'package:flutter/material.dart';
import '../services/data_service.dart';
import 'paragraph_screen.dart';

class GrammarScreen extends StatelessWidget {
  final DataService dataService;

  const GrammarScreen({super.key, required this.dataService});

  @override
  Widget build(BuildContext context) {
    return ParagraphScreen(dataService: dataService);
  }
}
