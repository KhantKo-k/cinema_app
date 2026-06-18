import 'package:cinema_app/features/movies/data/converters/timestamp_converter.dart';
import 'package:cinema_app/features/movies/domain/entities/movie_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'movie_model.g.dart';

@JsonSerializable(explicitToJson: true)
@TimestampConverter()
class MovieModel extends MovieEntity {
  const MovieModel({
    super.id,
    required super.title,
    required super.description,
    required super.posterUrl,
    required super.trailerUrl,
    required super.director,
    required super.subtitles,
    required super.duration,
    required super.rating,
    required super.genre,
    required super.cast,
    @TimestampConverter() required super.startDate, // Explicitly marked
    @TimestampConverter() required super.endDate,
    required super.status,
    @TimestampConverter() required super.createdAt,
    @TimestampConverter() required super.updatedAt,
  });

  factory MovieModel.fromJson(Map<String, dynamic> json) =>
      _$MovieModelFromJson(json);

  Map<String, dynamic> toJson() => _$MovieModelToJson(this);

  factory MovieModel.fromFirebase(Map<String, dynamic> json, String id) {
    return MovieModel.fromJson({...json, "id": id});
  }
}
