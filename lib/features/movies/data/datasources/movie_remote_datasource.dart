import 'package:cinema_app/features/movies/data/model/movie_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class MovieRemoteDatasource {
  Future<List<MovieModel>> getMovies();
  Future<List<MovieModel>> getUpcomingMovies();
}

class MovieRemoteDatasourceImpl implements MovieRemoteDatasource {
  final FirebaseFirestore firestore;

  MovieRemoteDatasourceImpl(this.firestore);

  @override
  Future<List<MovieModel>> getMovies() async {
    final now = DateTime.now().toUtc();

    final snapshot = await firestore
        .collection('movies')
        .where('status', isEqualTo: 'showing')
        .where('startDate', isLessThanOrEqualTo: Timestamp.fromDate(now))
        .where('endDate', isGreaterThanOrEqualTo: Timestamp.fromDate(now))
        .get();

    return snapshot.docs.map((doc) {
      return MovieModel.fromFirebase(doc.data(), doc.id);
    }).toList();
  }

  @override
  Future<List<MovieModel>> getUpcomingMovies() async {
    final snapshot = await firestore
        .collection('movies')
        .where('status', isEqualTo: 'upcoming')
        .get();
    return snapshot.docs.map((doc) {
      return MovieModel.fromFirebase(doc.data(), doc.id);
    }).toList();
  }
}
