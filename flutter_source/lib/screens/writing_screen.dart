import 'package:flutter/material.dart';
import '../services/data_service.dart';
import '../theme/colors.dart';

class WritingScreen extends StatefulWidget {
  final DataService dataService;

  const WritingScreen({super.key, required this.dataService});

  @override
  State<WritingScreen> createState() => _WritingScreenState();
}

class _WritingScreenState extends State<WritingScreen> {
  final TextEditingController _inputController = TextEditingController();
  String _selectedPrompt = 'Présentez-vous en français (nom, âge, profession, ville).';
  bool _submitted = false;
  String _feedback = '';

  final List<String> _prompts = [
    'Présentez-vous en français (nom, âge, profession, ville).',
    'Décrivez votre journée typique ou vos activités du week-end.',
    'Racontez votre dernier voyage ou vos vacances préférées.',
  ];

  void _submitResponse() {
    final text = _inputController.text.trim();
    if (text.isEmpty) return;

    final wordCount = text.split(RegExp(r'\s+')).length;
    setState(() {
      _submitted = true;
      _feedback = 'Bravo! Votre texte contient $wordCount mots. Rédaction validée!';
    });
  }

  @override
  void dispose() {
    _inputController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Exercices d\'Écriture'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'Sujet de rédaction:',
              style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
            ),
            const SizedBox(height: 8),
            DropdownButtonFormField<String>(
              key: const Key('writing_prompt_dropdown'),
              value: _selectedPrompt,
              isExpanded: true,
              decoration: InputDecoration(
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(12)),
                filled: true,
              ),
              items: _prompts.map((p) {
                return DropdownMenuItem(
                  value: p,
                  child: Text(p, overflow: TextOverflow.ellipsis),
                );
              }).toList(),
              onChanged: (val) {
                if (val != null) {
                  setState(() {
                    _selectedPrompt = val;
                    _submitted = false;
                    _feedback = '';
                  });
                }
              },
            ),
            const SizedBox(height: 20),
            TextField(
              key: const Key('writing_input_field'),
              controller: _inputController,
              maxLines: 6,
              maxLength: 1000,
              decoration: InputDecoration(
                hintText: 'Rédigez votre réponse ici en français...',
                border: OutlineInputBorder(borderRadius: BorderRadius.circular(16)),
                filled: true,
                fillColor: Colors.white,
              ),
            ),
            const SizedBox(height: 16),
            SizedBox(
              width: double.infinity,
              child: FilledButton.icon(
                key: const Key('writing_submit_btn'),
                onPressed: _submitResponse,
                style: FilledButton.styleFrom(
                  backgroundColor: AppColors.terracottaPrimary,
                  padding: const EdgeInsets.symmetric(vertical: 14),
                ),
                icon: const Icon(Icons.send),
                label: const Text('Soumettre ma rédaction'),
              ),
            ),
            if (_submitted) ...[
              const SizedBox(height: 20),
              Container(
                key: const Key('writing_feedback_container'),
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.green.withValues(alpha: 0.15),
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.green),
                ),
                child: Row(
                  children: [
                    const Icon(Icons.check_circle, color: Colors.green),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Text(
                        _feedback,
                        style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.green),
                      ),
                    ),
                  ],
                ),
              ),
            ]
          ],
        ),
      ),
    );
  }
}
