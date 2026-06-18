import 'package:cinema_app/features/booking/domain/usecases/book_seats_use_case.dart';
import 'package:cinema_app/features/booking/domain/usecases/buy_seats_use_case.dart';
import 'package:cinema_app/features/booking/presentation/providers/usecase_providers.dart';
import 'package:cinema_app/core/error/failure.dart';
import 'package:dartz/dartz.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'booking_notifier.g.dart';

@riverpod
class BookingNotifier extends _$BookingNotifier {
  late final BookSeatsUseCase bookSeatsUseCase;
  late final BuySeatsUseCase buySeatsUseCase;

  @override
  BookingState build() {
    bookSeatsUseCase = ref.read(bookSeatsUseCaseProvider);
    buySeatsUseCase = ref.read(buySeatsUseCaseProvider);
    return BookingState();
  }

  Future<void> bookSeats(String showtimeId, List<String> seats) async {
    state = state.copyWith(loading: true, error: null, orderId: null);

    final Either<Failure, String> result =
        await bookSeatsUseCase(showtimeId, seats);

    result.fold(
      (failure) {
        state = state.copyWith(loading: false, error: failure.interpretation.message);
      },
      (orderId) {
        state = state.copyWith(loading: false, orderId: orderId, error: null);
      },
    );
  }

  Future<void> buySeats(String showtimeId, List<String> seats) async {
    state = state.copyWith(loading: true, error: null, orderId: null);

    final Either<Failure, String> result =
        await buySeatsUseCase(showtimeId, seats);

    result.fold(
      (failure) {
        state = state.copyWith(loading: false, error: failure.interpretation.message);
      },
      (orderId) {
        state = state.copyWith(loading: false, orderId: orderId, error: null);
      },
    );
  }
}

class BookingState {
  final bool loading;
  final String? orderId;
  final String? error;

  BookingState({this.loading = false, this.orderId, this.error});

  BookingState copyWith({bool? loading, String? orderId, String? error}) {
    return BookingState(
      loading: loading ?? this.loading,
      orderId: orderId ?? this.orderId,
      error: error ?? this.error,
    );
  }
}