// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_type_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatTypeModel _$SeatTypeModelFromJson(Map<String, dynamic> json) =>
    SeatTypeModel(
      id: json['id'] as String,
      price: (json['price'] as num).toDouble(),
      color: json['color'] as String,
    );

Map<String, dynamic> _$SeatTypeModelToJson(SeatTypeModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'price': instance.price,
      'color': instance.color,
    };
