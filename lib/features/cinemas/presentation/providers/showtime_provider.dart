import 'package:cinema_app/features/cinemas/data/datasources/showtime_remote_datasource.dart';
import 'package:cinema_app/features/cinemas/data/repository/showtime_repository_impl.dart';
import 'package:cinema_app/features/cinemas/domain/entities/showtime_entity.dart';
import 'package:cinema_app/features/cinemas/domain/repository/showtime_repository.dart';
import 'package:cinema_app/features/movies/presentation/providers/movie_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:flutter/foundation.dart';
part 'showtime_provider.g.dart';

@riverpod
ShowtimeRemoteDatasource showtimeRemoteDatasource(ShowtimeRemoteDatasourceRef ref){
  final firestore = ref.watch(firestoreProvider);
  return ShowtimeRemoteDatasourceImpl(firestore);
}

@riverpod
ShowtimeRepository showtimeRepository(ShowtimeRepositoryRef ref){
  final datasource = ref.watch(showtimeRemoteDatasourceProvider);
  return ShowtimeRepositoryImpl(datasource: datasource);
}


@riverpod  
Future<List<ShowtimeEntity>> showtimes(ShowtimesRef ref, String movieId, String cinemaId) async {
  final repo = ref.watch(showtimeRepositoryProvider);
  final result = await repo.getShowtimes(movieId, cinemaId);
  return result.fold( 
    (failure) => throw Exception(failure.toString()),
    (showtimes) => showtimes
  );
}
DateTime _dateOnly(DateTime dt) => DateTime(dt.year, dt.month, dt.day);

@riverpod
Future<List<DateTime>> selectableDays(SelectableDaysRef ref, { 
  required String movieId,
  required String cinemaId,
}) async {
  final items = await ref.watch(showtimesProvider(movieId, cinemaId).future);

  final seen = <int>{};
  final days = <DateTime>[];
  for (final s in items){
    final d = _dateOnly(s.startTime);
    final key = d.millisecondsSinceEpoch;
    if(seen.add(key)) days.add(d);
  }

  days.sort();
  return days;
}

@riverpod 
class SelectedDay extends _$SelectedDay {
  @override
  Future<DateTime?> build({
    required String movieId,
    required String cinemaId,
  }) async {
    return null;
  }
  void set(DateTime day){
    state = AsyncData(day);
  }
}
@riverpod
class SelectedShowtime extends _$SelectedShowtime {
  @override
  String? build({required String movieId, required String cinemaId}) {
    // When the movie or cinema changes, reset to null
    return null; 
  }

  void set(String id) => state = id;
  
  void clear() => state = null;
}
@riverpod
Future<List<ShowtimeEntity>> showtimesForSelectedDay(
  ShowtimesForSelectedDayRef ref, {
  required String movieId,
  required String cinemaId,
}) async {
  final all = await ref.watch(
    showtimesProvider(movieId,cinemaId).future,
  );
  final selected = await ref.watch(
    selectedDayProvider(movieId: movieId, cinemaId: cinemaId).future,
  );
  if (selected == null) return const <ShowtimeEntity>[];
  final target = _dateOnly(selected);
  return all.where((s) => _dateOnly(s.startTime) == target).toList();
}