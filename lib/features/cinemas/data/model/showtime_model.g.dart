// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showtime_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ShowtimeModel _$ShowtimeModelFromJson(Map<String, dynamic> json) =>
    ShowtimeModel(
      id: json['id'] as String?,
      cinemaId: json['cinemaId'] as String,
      movieId: json['movieId'] as String,
      theaterId: json['theaterId'] as String,
      startTime: const TimestampConverter().fromJson(json['startTime']),
      endTime: const TimestampConverter().fromJson(json['endTime']),
      theaterName: json['theaterName'] as String,
    );

Map<String, dynamic> _$ShowtimeModelToJson(ShowtimeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'cinemaId': instance.cinemaId,
      'movieId': instance.movieId,
      'theaterId': instance.theaterId,
      'startTime': const TimestampConverter().toJson(instance.startTime),
      'endTime': const TimestampConverter().toJson(instance.endTime),
      'theaterName': instance.theaterName,
    };
