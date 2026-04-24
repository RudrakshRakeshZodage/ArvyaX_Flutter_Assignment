import 'package:arvyax_flutter_assignment/data/models/journal_entry_model.dart';
import 'package:arvyax_flutter_assignment/domain/entities/journal_entry.dart';
import 'package:arvyax_flutter_assignment/domain/repositories/journal_repository.dart';
import 'package:hive/hive.dart';

class JournalRepositoryImpl implements JournalRepository {
  static const String boxName = 'journal_entries';

  @override
  Future<List<JournalEntry>> getEntries() async {
    final box = await Hive.openBox<JournalEntryModel>(boxName);
    return box.values.map((e) => e.toEntity()).toList().reversed.toList();
  }

  @override
  Future<void> saveEntry(JournalEntry entry) async {
    final box = await Hive.openBox<JournalEntryModel>(boxName);
    final model = JournalEntryModel.fromEntity(entry);
    await box.add(model);
  }
}
