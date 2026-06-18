import 'package:cinema_app/features/movies/data/datasources/movie_remote_datasource.dart';
import 'package:cinema_app/features/movies/data/repository/movie_repository_impl.dart';
import 'package:cinema_app/features/movies/domain/entities/movie_entity.dart';
import 'package:cinema_app/features/movies/domain/repository/movie_repository.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'movie_providers.g.dart';

@riverpod
FirebaseFirestore firestore(FirestoreRef ref){
  return FirebaseFirestore.instance;
}

@riverpod 
MovieRemoteDatasource movieRemoteDatasource(MovieRemoteDatasourceRef ref){
  final firestore = ref.watch(firestoreProvider);
  return MovieRemoteDatasourceImpl(firestore);
}

@riverpod 
MovieRepository movieRepository(MovieRepositoryRef ref){
  final datasource = ref.watch(movieRemoteDatasourceProvider);
  return MovieRepositoryImpl(datasource: datasource);
}

@riverpod 
Future<List<MovieEntity>> movies(MoviesRef ref) async {
  final repo = ref.watch(movieRepositoryProvider);
  final result = await repo.getMovies();

  return result.fold( 
    (failure) => throw Exception(failure.toString()),
    (movies) => movies
  );
}

@riverpod 
Future<List<MovieEntity>> upcomingMovies(UpcomingMoviesRef ref) async {
  final repo = ref.watch(movieRepositoryProvider);
  final result = await repo.getUpcomingMovies();
  return result.fold( 
    (failure) => throw Exception(failure.toString()),
    (upcomingMovies) => upcomingMovies
  );
}