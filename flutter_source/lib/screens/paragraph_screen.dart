import 'package:flutter/material.dart';
import '../models/paragraph.dart';
import '../models/word_entry.dart';
import '../services/data_service.dart';

class ParagraphScreen extends StatefulWidget {
  final DataService dataService;

  const ParagraphScreen({super.key, required this.dataService});

  @override
  State<ParagraphScreen> createState() => _ParagraphScreenState();
}

class _ParagraphScreenState extends State<ParagraphScreen> {
  int _selectedIndex = 0;
  bool _showTranslation = false;
  String? _selectedQuizAnswer;
  bool _quizSubmitted = false;

  void _showWordModal(String word) {
    final WordEntry? entry = widget.dataService.findWordDefinition(word);
    if (entry == null) return;

    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(24)),
      ),
      builder: (context) {
        return Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    entry.french,
                    style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).colorScheme.primary,
                        ),
                  ),
                  Chip(
                    label: Text(entry.level),
                    backgroundColor: Colors.purple.withValues(alpha: 0.15),
                  ),
                ],
              ),
              const SizedBox(height: 8),
              const Text(
                'Définition / Traduction:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                entry.english,
                style: const TextStyle(fontSize: 16),
              ),
              const SizedBox(height: 16),
              const Text(
                'Exemple:',
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 4),
              Text(
                entry.example,
                style: TextStyle(color: Colors.grey[700]),
              ),
              const SizedBox(height: 20),
              SizedBox(
                width: double.infinity,
                child: ElevatedButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fermer'),
                ),
              ),
            ],
          ),
        );
      },
    );
  }

  void _openQuizDialog(ParagraphItem paragraph) {
    if (paragraph.questions.isEmpty) return;

    final question = paragraph.questions.first;
    _selectedQuizAnswer = null;
    _quizSubmitted = false;

    showDialog(
      context: context,
      builder: (context) {
        return StatefulBuilder(
          builder: (context, setStateDialog) {
            return AlertDialog(
              title: Text('Quiz: ${paragraph.title}'),
              content: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    question.question,
                    style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
                  ),
                  const SizedBox(height: 12),
                  for (final opt in question.options) ...[
                    Builder(
                      builder: (context) {
                        final bool isCorrect = opt == question.answer;
                        final bool isSelected = _selectedQuizAnswer == opt;

                        Color tileColor = Colors.transparent;
                        if (_quizSubmitted) {
                          if (isCorrect) {
                            tileColor = Colors.green.withValues(alpha: 0.2);
                          } else if (isSelected) {
                            tileColor = Colors.red.withValues(alpha: 0.2);
                          }
                        }

                        return Container(
                          margin: const EdgeInsets.only(bottom: 6),
                          decoration: BoxDecoration(
                            color: tileColor,
                            borderRadius: BorderRadius.circular(8),
                            border: Border.all(color: Colors.grey[300]!),
                          ),
                          child: ListTile(
                            title: Text(opt),
                            leading: Icon(
                              isSelected ? Icons.radio_button_checked : Icons.radio_button_unchecked,
                              color: isSelected ? Theme.of(context).colorScheme.primary : Colors.grey,
                            ),
                            onTap: _quizSubmitted
                                ? null
                                : () {
                                    setStateDialog(() {
                                      _selectedQuizAnswer = opt;
                                    });
                                  },
                          ),
                        );
                      },
                    ),
                  ],
                  if (_quizSubmitted) ...[
                    const SizedBox(height: 8),
                    Text(
                      _selectedQuizAnswer == question.answer ? 'Bravo! Réponse correcte! 🎉' : 'Dommage! Réponse correcte: ${question.answer}',
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        color: _selectedQuizAnswer == question.answer ? Colors.green : Colors.red,
                      ),
                    ),
                  ]
                ],
              ),
              actions: [
                if (!_quizSubmitted)
                  TextButton(
                    onPressed: _selectedQuizAnswer == null
                        ? null
                        : () {
                            setStateDialog(() {
                              _quizSubmitted = true;
                            });
                          },
                    child: const Text('Valider'),
                  ),
                TextButton(
                  onPressed: () => Navigator.pop(context),
                  child: const Text('Fermer'),
                ),
              ],
            );
          },
        );
      },
    );
  }

  Widget _buildInteractiveText(String content) {
    final words = content.split(' ');

    return Wrap(
      spacing: 4.0,
      runSpacing: 6.0,
      children: words.map((w) {
        final clean = w.replaceAll(RegExp(r'[^\wàâäéèêëîïôöùûüçÀÂÄÉÈÊËÎÏÔÖÙÛÜÇ]'), '');
        return GestureDetector(
          onTap: () => _showWordModal(clean),
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 2),
            decoration: BoxDecoration(
              color: Theme.of(context).colorScheme.primaryContainer.withValues(alpha: 0.3),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Text(
              w,
              style: TextStyle(
                fontSize: 17,
                height: 1.5,
                color: Theme.of(context).colorScheme.onSurface,
              ),
            ),
          ),
        );
      }).toList(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final paragraphs = widget.dataService.paragraphs;

    if (paragraphs.isEmpty) {
      return const Center(child: Text('Aucun paragraphe disponible.'));
    }

    final currentPara = paragraphs[_selectedIndex];

    return Scaffold(
      appBar: AppBar(
        title: const Text('Lectures Interactives A1-B1'),
      ),
      body: Column(
        children: [
          // Topic Tabs selector
          SizedBox(
            height: 50,
            child: ListView.builder(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.symmetric(horizontal: 12),
              itemCount: paragraphs.length,
              itemBuilder: (context, idx) {
                final isSel = idx == _selectedIndex;
                final item = paragraphs[idx];
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 4),
                  child: ChoiceChip(
                    label: Text('${item.level} · ${item.topic}'),
                    selected: isSel,
                    onSelected: (selected) {
                      if (selected) {
                        setState(() {
                          _selectedIndex = idx;
                          _showTranslation = false;
                        });
                      }
                    },
                  ),
                );
              },
            ),
          ),
          const Divider(height: 1),
          // Reading Card View
          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.all(20),
              child: Card(
                elevation: 2,
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Chip(
                            label: Text('Niveau ${currentPara.level}'),
                            backgroundColor: Colors.purple.withValues(alpha: 0.15),
                          ),
                          Chip(
                            label: Text(currentPara.topic),
                            backgroundColor: Colors.blue.withValues(alpha: 0.15),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      Text(
                        currentPara.title,
                        style: Theme.of(context).textTheme.headlineSmall?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const SizedBox(height: 12),
                      Row(
                        children: [
                          const Icon(Icons.touch_app, size: 16, color: Colors.purple),
                          const SizedBox(width: 6),
                          Text(
                            'Appuyez sur un mot pour voir sa définition',
                            style: TextStyle(fontSize: 13, color: Colors.purple[700], fontStyle: FontStyle.italic),
                          ),
                        ],
                      ),
                      const SizedBox(height: 16),
                      // Interactive text block
                      _buildInteractiveText(currentPara.content),
                      const SizedBox(height: 24),
                      const Divider(),
                      // Actions row: Translation & Quiz
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          OutlinedButton.icon(
                            onPressed: () {
                              setState(() {
                                _showTranslation = !_showTranslation;
                              });
                            },
                            icon: Icon(_showTranslation ? Icons.visibility_off : Icons.translate),
                            label: Text(_showTranslation ? 'Masquer la traduction' : 'Voir traduction'),
                          ),
                          FilledButton.icon(
                            onPressed: () => _openQuizDialog(currentPara),
                            icon: const Icon(Icons.quiz),
                            label: const Text('Quiz'),
                          ),
                        ],
                      ),
                      if (_showTranslation) ...[
                        const SizedBox(height: 16),
                        Container(
                          padding: const EdgeInsets.all(16),
                          decoration: BoxDecoration(
                            color: Colors.amber.withValues(alpha: 0.15),
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.amber[700]!),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const Text(
                                'Traduction en Anglais:',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                currentPara.translation,
                                style: const TextStyle(fontSize: 15, height: 1.4),
                              ),
                            ],
                          ),
                        ),
                      ]
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
