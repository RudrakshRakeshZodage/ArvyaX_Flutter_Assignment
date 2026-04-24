import 'package:arvyax_flutter_assignment/domain/entities/ambience.dart';

abstract class AmbienceRepository {
  Future<List<Ambience>> getAmbiences();
}
