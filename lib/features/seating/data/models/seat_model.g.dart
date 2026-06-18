// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'seat_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SeatModel _$SeatModelFromJson(Map<String, dynamic> json) => SeatModel(
  seatId: json['seatId'] as String,
  row: json['row'] as String,
  column: json['column'] as String,
  status: $enumDecode(_$SeatStatusEnumMap, json['status']),
  lockedBy: json['lockedBy'] as String?,
  lockedAt: json['lockedAt'] == null
      ? null
      : DateTime.parse(json['lockedAt'] as String),
  userId: json['userId'] as String?,
  orderId: json['orderId'] as String?,
);

Map<String, dynamic> _$SeatModelToJson(SeatModel instance) => <String, dynamic>{
  'seatId': instance.seatId,
  'row': instance.row,
  'column': instance.column,
  'status': _$SeatStatusEnumMap[instance.status]!,
  'lockedBy': instance.lockedBy,
  'lockedAt': instance.lockedAt?.toIso8601String(),
  'userId': instance.userId,
  'orderId': instance.orderId,
};

const _$SeatStatusEnumMap = {
  SeatStatus.available: 'available',
  SeatStatus.booked: 'booked',
  SeatStatus.locked: 'locked',
  SeatStatus.unknown: 'unknown',
};
