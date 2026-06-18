
import 'package:cinema_app/features/booking/data/repositories/booking_repository_impl.dart';
import 'package:cinema_app/features/booking/domain/repository/booking_repository.dart';
import 'package:cinema_app/features/booking/presentation/providers/datasource_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'repository_providers.g.dart';

@riverpod   
BookingRepository bookingRepository(BookingRepositoryRef ref) {
  final datasource = ref.read(bookingRemoteDatasourceProvider);
  return BookingRepositoryImpl(datasource: datasource);
}