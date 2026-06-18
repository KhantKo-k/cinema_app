import 'package:cinema_app/features/seating/domain/entities/seat_type_row_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_type_row_model.g.dart';

@JsonSerializable()
class SeatTypeRowModel extends SeatTypeRowEntity {
  const SeatTypeRowModel({
    required super.type,
    required super.count,
  });

  factory SeatTypeRowModel.fromJson(Map<String, dynamic> json) =>
      _$SeatTypeRowModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatTypeRowModelToJson(this);
}