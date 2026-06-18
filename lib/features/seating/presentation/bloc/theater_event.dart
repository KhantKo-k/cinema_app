import 'package:cinema_app/features/seating/domain/entities/seat_entity.dart';
import 'package:equatable/equatable.dart';

abstract class TheaterEvent extends Equatable {
  const TheaterEvent();

  @override
  List<Object?> get props => [];
}

class TheaterLoadedRequested extends TheaterEvent{
  final String theaterId;
  final String showtimeId;

  const TheaterLoadedRequested({required this.theaterId, required this.showtimeId});

  @override
  List<Object?> get props => [theaterId];
}

class TheaterSeatsUpdated extends TheaterEvent{
  final List<SeatEntity> seats;
  const TheaterSeatsUpdated({required this.seats});
}

class TheaterTimerTicked extends TheaterEvent {
  const TheaterTimerTicked();
  @override
  List<Object> get props => [];
}

class TheaterSeatsFailed extends TheaterEvent{
  final String message;
  const TheaterSeatsFailed({required this.message});
}

class TheaterSeatToggled extends TheaterEvent{
  final String seatId;
  const TheaterSeatToggled({required this.seatId});

  @override
  List<Object?> get props => [seatId];
}

class TheaterReset extends TheaterEvent{}
