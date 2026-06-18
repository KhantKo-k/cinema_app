import 'package:cinema_app/features/cinemas/domain/entities/showtime_entity.dart';
import 'package:cinema_app/features/movies/data/converters/timestamp_converter.dart';
import 'package:json_annotation/json_annotation.dart';

part 'showtime_model.g.dart';

@JsonSerializable(explicitToJson: true)
@TimestampConverter()
class ShowtimeModel extends ShowtimeEntity {
  const ShowtimeModel({
    super.id,
    required super.cinemaId,
    required super.movieId,
    required super.theaterId,
    @TimestampConverter() required super.startTime,
    @TimestampConverter() required super.endTime,
    required super.theaterName,
  });

  factory ShowtimeModel.fromJson(Map<String, dynamic> json) =>
    _$ShowtimeModelFromJson(json);

  Map<String, dynamic> toJson() => _$ShowtimeModelToJson(this);

  factory ShowtimeModel.fromFirebase(Map<String, dynamic> json, String id){
    return ShowtimeModel.fromJson({...json, "id": id});
  }
}