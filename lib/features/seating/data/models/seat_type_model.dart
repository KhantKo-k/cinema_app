

import 'package:cinema_app/features/seating/domain/entities/seat_type_entity.dart';
import 'package:json_annotation/json_annotation.dart';
part 'seat_type_model.g.dart';
@JsonSerializable()
class SeatTypeModel extends SeatTypeEntity{
  SeatTypeModel({
    required super.id,
    required super.price,
    required super.color
  });

   factory SeatTypeModel.fromJson(Map<String, dynamic> json) =>
      _$SeatTypeModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatTypeModelToJson(this);
}