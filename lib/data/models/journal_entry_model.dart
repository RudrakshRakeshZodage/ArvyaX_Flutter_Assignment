import 'package:arvyax_flutter_assignment/domain/entities/journal_entry.dart';
import 'package:hive/hive.dart';

part 'journal_entry_model.g.dart';

@HiveType(typeId: 0)
class JournalEntryModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String ambienceTitle;

  @HiveField(2)
  final String mood;

  @HiveField(3)
  final String text;

  @HiveField(4)
  final DateTime createdAt;

  JournalEntryModel({
    required this.id,
    required this.ambienceTitle,
    required this.mood,
    required this.text,
    required this.createdAt,
  });

  factory JournalEntryModel.fromEntity(JournalEntry entity) {
    return JournalEntryModel(
      id: entity.id,
      ambienceTitle: entity.ambienceTitle,
      mood: entity.mood,
      text: entity.text,
      createdAt: entity.createdAt,
    );
  }

  JournalEntry toEntity() {
    return JournalEntry(
      id: id,
      ambienceTitle: ambienceTitle,
      mood: mood,
      text: text,
      createdAt: createdAt,
    );
  }
}
