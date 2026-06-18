import 'package:cinema_app/features/seating/domain/entities/seat_type_row_entity.dart';

class TheaterEntity {
  final String id;
  final String name;
  final bool hasPath;
  final int seatsPerRow;
  final List<SeatTypeRowEntity> seatTypeRows;

  TheaterEntity({
    required this.id,
    required this.name,
    required this.hasPath,
    required this.seatsPerRow,
    required this.seatTypeRows,
  });
}