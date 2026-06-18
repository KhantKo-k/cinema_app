
import 'package:cinema_app/features/booking/domain/usecases/book_seats_use_case.dart';
import 'package:cinema_app/features/booking/domain/usecases/buy_seats_use_case.dart';
import 'package:cinema_app/features/booking/presentation/providers/repository_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'usecase_providers.g.dart';

@riverpod   
BookSeatsUseCase bookSeatsUseCase(BookSeatsUseCaseRef ref) {
  final repository = ref.read(bookingRepositoryProvider);
  return BookSeatsUseCase(repository: repository);
}

@riverpod   
BuySeatsUseCase buySeatsUseCase(BuySeatsUseCaseRef ref) {
  final repository = ref.read(bookingRepositoryProvider);
  return BuySeatsUseCase(repository: repository);
}