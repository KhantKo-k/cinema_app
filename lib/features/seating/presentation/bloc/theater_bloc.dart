import 'dart:async';

import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_entity.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_type_entity.dart';
import 'package:cinema_app/features/seating/domain/entities/theater_entity.dart';
import 'package:cinema_app/features/seating/domain/usecases/get_seat_type_use_case.dart';
import 'package:cinema_app/features/seating/domain/usecases/get_theater_use_case.dart';
import 'package:cinema_app/features/seating/domain/usecases/watch_seat_use_case.dart';
import 'package:cinema_app/features/seating/presentation/bloc/theater_event.dart';
import 'package:cinema_app/features/seating/presentation/bloc/theater_state.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class TheaterBloc extends Bloc<TheaterEvent, TheaterState> {
  final GetTheaterUseCase getTheaterUseCase;
  final GetSeatTypeUseCase getSeatTypeUseCase;
  final WatchSeatUseCase watchSeatUseCase;

  StreamSubscription<Either<Failure, List<SeatEntity>>>? _seatSub;

  TheaterBloc({
    required this.getTheaterUseCase,
    required this.getSeatTypeUseCase,
    required this.watchSeatUseCase,
  }) : super(const TheaterState()) {
    on<TheaterLoadedRequested>(_onTheaterRequested);
    on<TheaterSeatToggled>(_onSeatToggled);
    on<TheaterReset>(_onTheaterReset);
    on<TheaterSeatsUpdated>(_onTheaterSeatsUpdated);
    on<TheaterTimerTicked>(_onTimerTicked);
  }

  Future<void> _onTheaterRequested(
    TheaterLoadedRequested event,
    Emitter<TheaterState> emit,
  ) async {
    emit(state.copyWith(status: TheaterStatus.loading, failure: null));

    final results = await Future.wait([
      getTheaterUseCase(event.theaterId),
      getSeatTypeUseCase(),
    ]);

    final theaterResult = results[0] as Either<Failure, TheaterEntity>;
    final seatTypesResult = results[1] as Either<Failure, List<SeatTypeEntity>>;

    theaterResult.fold(
      (failure) =>
          emit(state.copyWith(status: TheaterStatus.error, failure: failure)),
      (theater) {
        seatTypesResult.fold(
          (failure) => emit(
            state.copyWith(status: TheaterStatus.error, failure: failure),
          ),
          (seatTypes) async {
            emit(
              state.copyWith(
                status: TheaterStatus.loaded,
                theater: () => theater,
                seatTypes: seatTypes,
                selectedSeats: <String>{},
                showtimeId: event.showtimeId,
              ),
            );

            await _seatSub?.cancel();

            _seatSub = watchSeatUseCase(event.showtimeId).listen((
              Either<Failure, List<SeatEntity>> result,
            ) {
              result.fold(
                (failure) => add(
                  TheaterSeatsFailed(message: failure.interpretation.message),
                ),
                (seats) => add(TheaterSeatsUpdated(seats: seats)),
              );
            });
          },
        );
      },
    );
  }

  Timer? _ticker;

  void _onSeatToggled(TheaterSeatToggled event, Emitter<TheaterState> emit) {
    final copy = Set<String>.from(state.selectedSeats);
    final timers = Map<String, int>.from(state.seatTimers);

    if (copy.contains(event.seatId)) {
      copy.remove(event.seatId);
      timers.remove(event.seatId);
    } else {
      if (copy.length >= 10)  return; 

      copy.add(event.seatId);
      timers[event.seatId] = 120;
     
    }

    emit(state.copyWith(selectedSeats: copy, seatTimers: timers));
    if (timers.isNotEmpty && _ticker == null) {
    _startTicker();
  } else if (timers.isEmpty) {
    _ticker?.cancel();
    _ticker = null;
  }
  }

  void _startTicker() {
  _ticker = Timer.periodic(const Duration(seconds: 1), (timer) {
    add(const TheaterTimerTicked());
  });
}

void _onTimerTicked(TheaterTimerTicked event, Emitter<TheaterState> emit) {
  final timers = Map<String, int>.from(state.seatTimers);
  final seats = Set<String>.from(state.selectedSeats);
  List<String> expiredSeats = [];

  timers.updateAll((key, value) {
    if (value > 0) return value - 1;
    expiredSeats.add(key);
    return 0;
  });


  for (var id in expiredSeats) {
    timers.remove(id);
    seats.remove(id);
  }

  emit(state.copyWith(seatTimers: timers, selectedSeats: seats));

  if (timers.isEmpty) {
    _ticker?.cancel();
    _ticker = null;
  }
}



  void _onTheaterReset(TheaterReset event, Emitter<TheaterState> emit) {
    emit(
      state.copyWith(
        status: TheaterStatus.initial,
        theater: () => null,
        selectedSeats: <String>{},
        failure: null,
        seats: {},
        seatTimers: {},
        showtimeId: null,
      ),
    );
  }

  Future<void> _onTheaterSeatsUpdated(
    TheaterSeatsUpdated event,
    Emitter<TheaterState> emit,
  ) async {

    final seatMap = {for (var seat in event.seats) seat.seatId: seat};
    emit(state.copyWith(seats: seatMap));
  }

  @override
  Future<void> close() {
    _ticker?.cancel();
    _seatSub?.cancel();
    return super.close();
  }
}
