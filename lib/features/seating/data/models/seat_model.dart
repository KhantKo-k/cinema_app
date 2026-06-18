import 'package:cinema_app/features/movies/data/converters/timestamp_converter.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'seat_model.g.dart';

@JsonSerializable() 
//@SeatTypeConverter()
class SeatModel extends SeatEntity{

SeatModel({
    required super.seatId,
    required super.row,
    required super.column,
    //required SeatTypeModel super.type,
    required super.status,
    super.lockedBy,
    @TimestampConverter() super.lockedAt,
    super.userId,
    super.orderId,
  });

  factory SeatModel.fromJson(Map<String, dynamic> json) =>
      _$SeatModelFromJson(json);

  Map<String, dynamic> toJson() => _$SeatModelToJson(this);

  factory SeatModel.fromEntity(SeatEntity entity) {
    return SeatModel(
      seatId: entity.seatId,
      row: entity.row,
      column: entity.column,
      //type: entity.type as SeatTypeModel,
      status: entity.status,
      lockedBy: entity.lockedBy,
      lockedAt: entity.lockedAt,
      userId: entity.userId,
      orderId: entity.orderId,
    );
  }

  SeatModel copyWith({
    String? seatId,
    String? row,
    String? column,
    //SeatTypeModel? type,
    SeatStatus? status,
    String? lockedBy,
    DateTime? lockedAt,
    String? userId,
    String? orderId,
  }) {
    return SeatModel(
      seatId: seatId ?? this.seatId,
      row: row ?? this.row,
      column: column ?? this.column,
      //type: type ?? this.type as SeatTypeModel,
      status: status ?? this.status,
      lockedBy: lockedBy ?? this.lockedBy,
      lockedAt: lockedAt ?? this.lockedAt,
      userId: userId ?? this.userId,
      orderId: orderId ?? this.orderId,
    );
  }
}