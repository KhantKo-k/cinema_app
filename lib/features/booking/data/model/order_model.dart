
import 'package:cinema_app/features/seating/data/models/converter/nullalbe_time_stamp_converter.dart';
import 'package:cinema_app/features/booking/domain/entity/order_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'order_model.g.dart';

@JsonSerializable()
class OrderModel extends OrderEntity {
  OrderModel({
    required super.orderId,
    required super.userId,
    required super.showtimeId,
    required super.seatIds,
    required super.action,
    required super.paymentStatus,
    @NullableTimestampConverter() super.createdAt,
  });

  factory OrderModel.fromJson(Map<String, dynamic> json) =>
      _$OrderModelFromJson(json);
  
  Map<String, dynamic> toJson() => _$OrderModelToJson(this);

  factory OrderModel.fromEntity(OrderEntity entity) {
    return OrderModel(
      orderId: entity.orderId,
      userId: entity.userId,
      showtimeId: entity.showtimeId,
      seatIds: entity.seatIds,
      action: entity.action,
      paymentStatus: entity.paymentStatus,
      createdAt: entity.createdAt,
    );
  }
}