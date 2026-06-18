// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'theater_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

TheaterModel _$TheaterModelFromJson(Map<String, dynamic> json) => TheaterModel(
  id: json['id'] as String,
  name: json['name'] as String,
  hasPath: json['hasPath'] as bool,
  seatsPerRow: (json['seatsPerRow'] as num).toInt(),
  seatTypeRows: (json['seatTypeRows'] as List<dynamic>)
      .map(
        (e) => const SeatTypeRowEntityConverter().fromJson(
          e as Map<String, dynamic>,
        ),
      )
      .toList(),
);

Map<String, dynamic> _$TheaterModelToJson(TheaterModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'hasPath': instance.hasPath,
      'seatsPerRow': instance.seatsPerRow,
      'seatTypeRows': instance.seatTypeRows
          .map(const SeatTypeRowEntityConverter().toJson)
          .toList(),
    };
