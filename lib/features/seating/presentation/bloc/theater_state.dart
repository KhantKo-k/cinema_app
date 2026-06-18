import 'package:cinema_app/core/error/failure.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_entity.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_type_entity.dart';
import 'package:cinema_app/features/seating/domain/entities/theater_entity.dart';
import 'package:equatable/equatable.dart';

enum TheaterStatus {
  initial,
  loading,
  loaded,
  error,
}

class TheaterState extends Equatable {
  final TheaterStatus status;
  final TheaterEntity? theater;
  final String? showtimeId;
  final Set<String> selectedSeats;
  final List<SeatTypeEntity>? seatTypes;
  final Map<String, SeatEntity> seats;
  final Failure? failure;
  final String? toastMessage;
  final Map<String, int> seatTimers;

  const TheaterState({
    this.status = TheaterStatus.initial,
    this.theater,
    this.showtimeId,
    this.seatTypes,
    this.selectedSeats = const {},
    this.seats = const {},
    this.failure,
    this.toastMessage,
    this.seatTimers = const {},
  });

  String get selectedSeatsLabel{
    if(selectedSeats.isEmpty) return "None";
    final sortedList = selectedSeats.toList()..sort();
    return sortedList.join(", ");
  }

  double get totalPrice {
    if(theater == null || seatTypes == null || selectedSeats.isEmpty) return 0.0;

    double total = 0;
    for(var seatId in selectedSeats){
      total += getPriceForSeat(seatId);
    }
    return total;
  }

  double getPriceForSeat(String seatId){
    final rowLetter = seatId.replaceAll(RegExp(r'[0-9]'), '');
    final rowIndex = rowLetter.codeUnitAt(0) - 'A'.codeUnitAt(0);

    int cumulativeRows = 0;
    String typeId = '';
    final List<SeatTypeEntity> types = seatTypes!.cast<SeatTypeEntity>();

    for(var typeRow in theater!.seatTypeRows){
      cumulativeRows += typeRow.count;
      if(rowIndex < cumulativeRows){
        typeId = typeRow.type;
        break;
      }
    } 

    final type = types.firstWhere(
      (t) => t.id == typeId,
      orElse: () => types.first
    );
    return type.price;
  }

   TheaterState copyWith({
    TheaterStatus? status,
    TheaterEntity? Function()? theater,
    String? showtimeId,
    List<SeatTypeEntity>? seatTypes,
    Map<String, SeatEntity>? seats,
    Set<String>? selectedSeats,
    Failure? failure,
    String? Function()? toastMessage,
    Map<String, int>? seatTimers,
  }) {
    return TheaterState(
      status: status ?? this.status,
      theater: theater != null ? theater() : this.theater,
      showtimeId: showtimeId ?? this.showtimeId,
      seats: seats ?? this.seats,
      seatTypes: seatTypes ?? this.seatTypes,
      selectedSeats: selectedSeats ?? this.selectedSeats,
      failure: failure ?? this.failure,
      toastMessage: toastMessage != null ? toastMessage() : this.toastMessage,
      seatTimers: seatTimers ?? this.seatTimers,
    );
  }
  
  @override
  List<Object?> get props => [status, theater, seatTypes, selectedSeats, seats, failure, toastMessage, seatTimers];
}