// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_type_row_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatTypeRowModel _$SeatTypeRowModelFromJson(Map<String, dynamic> json) =>
    SeatTypeRowModel(
      type: json['type'] as String,
      count: (json['count'] as num).toInt(),
    );

Map<String, dynamic> _$SeatTypeRowModelToJson(SeatTypeRowModel instance) =>
    <String, dynamic>{'type': instance.type, 'count': instance.count};
