import 'package:arvyax_flutter_assignment/data/repositories/ambience_repository_impl.dart';
import 'package:arvyax_flutter_assignment/domain/entities/ambience.dart';
import 'package:arvyax_flutter_assignment/domain/repositories/ambience_repository.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final ambienceRepositoryProvider = Provider<AmbienceRepository>((ref) {
  return AmbienceRepositoryImpl();
});

final ambiencesProvider = FutureProvider<List<Ambience>>((ref) async {
  final repository = ref.watch(ambienceRepositoryProvider);
  return repository.getAmbiences();
});

final searchQueryProvider = StateProvider<String>((ref) => '');
final selectedTagProvider = StateProvider<String?>((ref) => null);

final filteredAmbiencesProvider = Provider<AsyncValue<List<Ambience>>>((ref) {
  final ambiencesAsync = ref.watch(ambiencesProvider);
  final search = ref.watch(searchQueryProvider).toLowerCase();
  final tag = ref.watch(selectedTagProvider);

  return ambiencesAsync.whenData((list) {
    return list.where((a) {
      final matchesSearch = a.title.toLowerCase().contains(search) ||
          a.description.toLowerCase().contains(search);
      final matchesTag = tag == null || a.tag == tag;
      return matchesSearch && matchesTag;
    }).toList();
  });
});
