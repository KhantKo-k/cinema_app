import 'package:cinema_app/features/seating/data/models/seat_type_model.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_type_entity.dart';
import 'package:json_annotation/json_annotation.dart';

class SeatTypeConverter implements JsonConverter<SeatTypeEntity, Map<String, dynamic>> {
  const SeatTypeConverter();

  @override
  SeatTypeEntity fromJson(Map<String, dynamic> json) => SeatTypeModel.fromJson(json);

  @override
  Map<String, dynamic> toJson(SeatTypeEntity object) {
    // Cast to model to use the generated toJson
    return (object as SeatTypeModel).toJson();
  }
}