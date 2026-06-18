import 'package:cinema_app/features/seating/data/models/seat_type_row_model.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_type_row_entity.dart';
import 'package:json_annotation/json_annotation.dart';

class SeatTypeRowEntityConverter
    implements JsonConverter<SeatTypeRowEntity, Map<String, dynamic>> {
  const SeatTypeRowEntityConverter();

  @override
  SeatTypeRowEntity fromJson(Map<String, dynamic> json) {
    return SeatTypeRowModel.fromJson(json); // deserialize as model
  }

  @override
  Map<String, dynamic> toJson(SeatTypeRowEntity object) {
    return SeatTypeRowModel(type: object.type, count: object.count).toJson();
  }
}