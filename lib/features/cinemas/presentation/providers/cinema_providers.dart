import 'package:cinema_app/features/cinemas/data/datasources/cinema_remote_datasource.dart';
import 'package:cinema_app/features/cinemas/data/repository/cinema_repository_impl.dart';
import 'package:cinema_app/features/cinemas/domain/entities/cinema_entity.dart';
import 'package:cinema_app/features/cinemas/domain/repository/cinema_repository.dart';
import 'package:cinema_app/features/movies/presentation/providers/movie_providers.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'cinema_providers.g.dart';

@riverpod
CinemaRemoteDatasource cinemaRemoteDatasource(CinemaRemoteDatasourceRef ref){
  final firestore = ref.watch(firestoreProvider);
  return CinemaRemoteDatasourceImpl(firestore);
}

@riverpod
CinemaRepository cinemaRepository(CinemaRepositoryRef ref){
  final datasource = ref.watch(cinemaRemoteDatasourceProvider);
  return CinemaRepositoryImpl(datasource: datasource);
}

@riverpod  
Future<List<CinemaEntity>> cinemas(CinemasRef ref, String movieId) async {
  final repo = ref.watch(cinemaRepositoryProvider);
  final result = await repo.getCinemaByMovie(movieId);

  return result.fold( 
    (failure) => throw Exception(failure.toString()),
    (cinemas) => cinemas
  );
}