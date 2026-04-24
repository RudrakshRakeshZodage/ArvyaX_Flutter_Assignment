import 'package:arvyax_flutter_assignment/domain/entities/journal_entry.dart';

abstract class JournalRepository {
  Future<List<JournalEntry>> getEntries();
  Future<void> saveEntry(JournalEntry entry);
}
