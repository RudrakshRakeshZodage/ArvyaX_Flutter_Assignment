import 'package:arvyax_flutter_assignment/features/journal/presentation/providers/journal_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class JournalScreen extends ConsumerStatefulWidget {
  final String ambienceTitle;
  const JournalScreen({super.key, required this.ambienceTitle});

  @override
  ConsumerState<JournalScreen> createState() => _JournalScreenState();
}

class _JournalScreenState extends ConsumerState<JournalScreen> {
  final _textController = TextEditingController();
  String? _selectedMood;

  final List<Map<String, dynamic>> _moods = [
    {'label': 'Calm', 'icon': Icons.spa},
    {'label': 'Grounded', 'icon': Icons.terrain},
    {'label': 'Energized', 'icon': Icons.bolt},
    {'label': 'Sleepy', 'icon': Icons.nights_stay},
  ];

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reflection'),
        automaticallyImplyLeading: false,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text(
              'What is gently present with you right now?',
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 24),
            TextField(
              controller: _textController,
              maxLines: 6,
              decoration: InputDecoration(
                hintText: 'Share your thoughts...',
                filled: true,
                fillColor: Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: BorderSide.none,
                ),
              ),
            ),
            const SizedBox(height: 32),
            const Text(
              'Your Current Mood',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: _moods.map((mood) {
                final isSelected = _selectedMood == mood['label'];
                return GestureDetector(
                  onTap: () {
                    HapticFeedback.lightImpact();
                    setState(() => _selectedMood = mood['label']);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                    decoration: BoxDecoration(
                      color: isSelected
                          ? Theme.of(context).colorScheme.primary
                          : Theme.of(context).colorScheme.surfaceVariant.withOpacity(0.3),
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(
                          mood['icon'],
                          size: 20,
                          color: isSelected ? Colors.white : Colors.grey,
                        ),
                        const SizedBox(width: 8),
                        Text(
                          mood['label'],
                          style: TextStyle(
                            color: isSelected ? Colors.white : Colors.black87,
                            fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              }).toList(),
            ),
            const SizedBox(height: 48),
            ElevatedButton(
              onPressed: (_selectedMood == null || _textController.text.isEmpty)
                  ? null
                  : () async {
                      HapticFeedback.mediumImpact();
                      await ref.read(journalProvider.notifier).addEntry(
                            ambienceTitle: widget.ambienceTitle,
                            mood: _selectedMood!,
                            text: _textController.text,
                          );
                      if (mounted) Navigator.pop(context);
                    },
              style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 60),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
              ),
              child: const Text('Save Reflection', style: TextStyle(fontSize: 18)),
            ),
          ],
        ),
      ),
    );
  }
}
