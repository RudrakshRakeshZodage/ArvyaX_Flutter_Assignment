import 'package:arvyax_flutter_assignment/domain/entities/ambience.dart';
import 'package:json_annotation/json_annotation.dart';

part 'ambience_model.g.dart';

@JsonSerializable()
class AmbienceModel extends Ambience {
  AmbienceModel({
    required super.id,
    required super.title,
    required super.tag,
    required super.durationMinutes,
    required super.description,
    required super.thumbnailUrl,
    required super.audioFileName,
    required super.sensoryChips,
  });

  factory AmbienceModel.fromJson(Map<String, dynamic> json) =>
      _$AmbienceModelFromJson(json);

  Map<String, dynamic> toJson() => _$AmbienceModelToJson(this);

  factory AmbienceModel.fromEntity(Ambience entity) {
    return AmbienceModel(
      id: entity.id,
      title: entity.title,
      tag: entity.tag,
      durationMinutes: entity.durationMinutes,
      description: entity.description,
      thumbnailUrl: entity.thumbnailUrl,
      audioFileName: entity.audioFileName,
      sensoryChips: entity.sensoryChips,
    );
  }
}
