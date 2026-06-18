import 'package:equatable/equatable.dart';

class SeatTypeRowEntity extends Equatable {
  final String type; // seatTypeId
  final int count; // number of rows with this type

  const SeatTypeRowEntity({
    required this.type,
    required this.count,
  });

  @override
  List<Object?> get props => [type, count];
}