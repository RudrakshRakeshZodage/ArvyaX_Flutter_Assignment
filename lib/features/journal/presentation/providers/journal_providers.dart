import 'package:arvyax_flutter_assignment/data/repositories/journal_repository_impl.dart';
import 'package:arvyax_flutter_assignment/domain/entities/journal_entry.dart';
import 'package:arvyax_flutter_assignment/domain/repositories/journal_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:uuid/uuid.dart';

final journalRepositoryProvider = Provider<JournalRepository>((ref) {
  return JournalRepositoryImpl();
});

class JournalNotifier extends StateNotifier<AsyncValue<List<JournalEntry>>> {
  final JournalRepository _repository;

  JournalNotifier(this._repository) : super(const AsyncValue.loading()) {
    loadEntries();
  }

  Future<void> loadEntries() async {
    state = const AsyncValue.loading();
    try {
      final entries = await _repository.getEntries();
      state = AsyncValue.data(entries);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> addEntry({
    required String ambienceTitle,
    required String mood,
    required String text,
  }) async {
    final entry = JournalEntry(
      id: const Uuid().v4(),
      ambienceTitle: ambienceTitle,
      mood: mood,
      text: text,
      createdAt: DateTime.now(),
    );

    await _repository.saveEntry(entry);
    await loadEntries();
  }
}

final journalProvider =
    StateNotifierProvider<JournalNotifier, AsyncValue<List<JournalEntry>>>((ref) {
  return JournalNotifier(ref.watch(journalRepositoryProvider));
});
