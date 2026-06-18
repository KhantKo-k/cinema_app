// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

MovieModel _$MovieModelFromJson(Map<String, dynamic> json) => MovieModel(
  id: json['id'] as String?,
  title: json['title'] as String,
  description: json['description'] as String,
  posterUrl: json['posterUrl'] as String,
  trailerUrl: json['trailerUrl'] as String,
  director: json['director'] as String,
  subtitles: json['subtitles'] as String,
  duration: (json['duration'] as num).toInt(),
  rating: json['rating'] as String,
  genre: (json['genre'] as List<dynamic>).map((e) => e as String).toList(),
  cast: (json['cast'] as List<dynamic>).map((e) => e as String).toList(),
  startDate: const TimestampConverter().fromJson(json['startDate']),
  endDate: const TimestampConverter().fromJson(json['endDate']),
  status: json['status'] as String,
  createdAt: const TimestampConverter().fromJson(json['createdAt']),
  updatedAt: const TimestampConverter().fromJson(json['updatedAt']),
);

Map<String, dynamic> _$MovieModelToJson(MovieModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'title': instance.title,
      'description': instance.description,
      'posterUrl': instance.posterUrl,
      'trailerUrl': instance.trailerUrl,
      'director': instance.director,
      'subtitles': instance.subtitles,
      'duration': instance.duration,
      'rating': instance.rating,
      'genre': instance.genre,
      'cast': instance.cast,
      'startDate': const TimestampConverter().toJson(instance.startDate),
      'endDate': const TimestampConverter().toJson(instance.endDate),
      'status': instance.status,
      'createdAt': const TimestampConverter().toJson(instance.createdAt),
      'updatedAt': const TimestampConverter().toJson(instance.updatedAt),
    };
