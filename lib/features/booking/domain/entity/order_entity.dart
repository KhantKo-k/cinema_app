import 'package:json_annotation/json_annotation.dart';


@JsonEnum(alwaysCreate: true)
enum OrderAction {
  @JsonValue('book')
  book,

  @JsonValue('buy')
  buy,
}

@JsonEnum(alwaysCreate: true)
enum PaymentStatus {
  @JsonValue('unpaid')
  unpaid,

  @JsonValue('paid')
  paid,
}

class OrderEntity {
  final String orderId;
  final String userId;
  final String showtimeId;
  final List<String> seatIds;
  final OrderAction action;
  final PaymentStatus paymentStatus;
  final DateTime? createdAt;

  OrderEntity({
    required this.orderId,
    required this.userId,
    required this.showtimeId,
    required this.seatIds,
    required this.action,
    required this.paymentStatus,
    this.createdAt,
  });
}