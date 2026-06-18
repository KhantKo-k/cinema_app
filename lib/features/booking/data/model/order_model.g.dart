// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'order_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

OrderModel _$OrderModelFromJson(Map<String, dynamic> json) => OrderModel(
  orderId: json['orderId'] as String,
  userId: json['userId'] as String,
  showtimeId: json['showtimeId'] as String,
  seatIds: (json['seatIds'] as List<dynamic>).map((e) => e as String).toList(),
  action: $enumDecode(_$OrderActionEnumMap, json['action']),
  paymentStatus: $enumDecode(_$PaymentStatusEnumMap, json['paymentStatus']),
  createdAt: json['createdAt'] == null
      ? null
      : DateTime.parse(json['createdAt'] as String),
);

Map<String, dynamic> _$OrderModelToJson(OrderModel instance) =>
    <String, dynamic>{
      'orderId': instance.orderId,
      'userId': instance.userId,
      'showtimeId': instance.showtimeId,
      'seatIds': instance.seatIds,
      'action': _$OrderActionEnumMap[instance.action]!,
      'paymentStatus': _$PaymentStatusEnumMap[instance.paymentStatus]!,
      'createdAt': instance.createdAt?.toIso8601String(),
    };

const _$OrderActionEnumMap = {OrderAction.book: 'book', OrderAction.buy: 'buy'};

const _$PaymentStatusEnumMap = {
  PaymentStatus.unpaid: 'unpaid',
  PaymentStatus.paid: 'paid',
};
