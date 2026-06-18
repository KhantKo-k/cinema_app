import 'package:cinema_app/features/seating/data/models/converter/seat_type_row_converter.dart';
import 'package:json_annotation/json_annotation.dart';
// Make sure this path points to your actual entity
import 'package:cinema_app/features/seating/domain/entities/theater_entity.dart';

part 'theater_model.g.dart';

@JsonSerializable()
@SeatTypeRowEntityConverter()
class TheaterModel extends TheaterEntity {
  TheaterModel({
    required super.id,
    required super.name,
    required super.hasPath,
    required super.seatsPerRow,
    required super.seatTypeRows, 
  });

  factory TheaterModel.fromJson(Map<String, dynamic> json) =>
      _$TheaterModelFromJson(json);

  Map<String, dynamic> toJson() => _$TheaterModelToJson(this);
}