import 'dart:convert';
import 'package:arvyax_flutter_assignment/data/models/ambience_model.dart';
import 'package:arvyax_flutter_assignment/domain/entities/ambience.dart';
import 'package:arvyax_flutter_assignment/domain/repositories/ambience_repository.dart';
import 'package:flutter/services.dart';

class AmbienceRepositoryImpl implements AmbienceRepository {
  @override
  Future<List<Ambience>> getAmbiences() async {
    final String response = await rootBundle.loadString('assets/data/ambiences.json');
    final data = await json.decode(response);
    return (data as List).map((e) => AmbienceModel.fromJson(e)).toList();
  }
}
