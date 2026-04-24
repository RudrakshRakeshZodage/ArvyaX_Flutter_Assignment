// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'ambience_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AmbienceModel _$AmbienceModelFromJson(Map<String, dynamic> json) =>
    AmbienceModel(
      id: json['id'] as String,
      title: json['title'] as String,
      tag: json['tag'] as String,
      durationMinutes: (json['durationMinutes'] as num).toInt(),
      description: json['description'] as String,
      thumbnailUrl: json['thumbnailUrl'] as String,
      audioFileName: json['audioFileName'] as String,
      sensoryChips: (json['sensoryChips'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$AmbienceModelToJson(AmbienceModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'tag': instance.tag,
      'durationMinutes': instance.durationMinutes,
      'description': instance.description,
      'thumbnailUrl': instance.thumbnailUrl,
      'audioFileName': instance.audioFileName,
      'sensoryChips': instance.sensoryChips,
    };
