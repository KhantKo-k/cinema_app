import 'package:json_annotation/json_annotation.dart';

@JsonEnum(alwaysCreate: true)
enum SeatStatus { 
  @JsonValue('available')
  available, 
  @JsonValue('booked')
  booked, 
  @JsonValue('locked')
  locked,
  @JsonValue('unknown')
  unknown,
}

class SeatEntity {
  final String seatId;
  final String row;
  final String column;
  //final SeatTypeEntity type;
  final SeatStatus status;
  final String? lockedBy;
  final DateTime? lockedAt;
  final String? userId;
  final String? orderId;

  SeatEntity({
    required this.seatId,
    required this.row,
    required this.column,
   // required this.type,
    required this.status,
    this.lockedBy,
    this.lockedAt,
    this.userId,
    this.orderId,
  });

}