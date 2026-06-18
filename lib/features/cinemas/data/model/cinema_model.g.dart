// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CinemaModel _$CinemaModelFromJson(Map<String, dynamic> json) => CinemaModel(
  id: json['id'] as String?,
  name: json['name'] as String,
  location: json['location'] as String,
  cinemaUrl: json['cinemaUrl'] as String,
);

Map<String, dynamic> _$CinemaModelToJson(CinemaModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'location': instance.location,
      'cinemaUrl': instance.cinemaUrl,
    };
