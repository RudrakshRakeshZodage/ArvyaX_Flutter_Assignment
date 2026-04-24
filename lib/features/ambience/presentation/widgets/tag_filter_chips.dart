import 'package:arvyax_flutter_assignment/features/ambience/presentation/providers/ambience_providers.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class TagFilterChips extends ConsumerWidget {
  const TagFilterChips({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final selectedTag = ref.watch(selectedTagProvider);
    final tags = ['Focus', 'Calm', 'Sleep', 'Reset'];

    return SizedBox(
      height: 40,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: tags.length,
        itemBuilder: (context, index) {
          final tag = tags[index];
          final isSelected = selectedTag == tag;

          return Padding(
            padding: const EdgeInsets.only(right: 8),
            child: FilterChip(
              label: Text(tag),
              selected: isSelected,
              onSelected: (selected) {
                ref.read(selectedTagProvider.notifier).state =
                    selected ? tag : null;
              },
              backgroundColor: Colors.transparent,
              selectedColor: Theme.of(context).colorScheme.primary.withOpacity(0.1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(20),
                side: BorderSide(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Theme.of(context).colorScheme.outline.withOpacity(0.3),
                ),
              ),
              showCheckmark: false,
            ),
          );
        },
      ),
    );
  }
}
