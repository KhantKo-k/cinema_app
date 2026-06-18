import 'package:cinema_app/features/cinemas/data/model/cinema_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class CinemaRemoteDatasource {
  Future<List<CinemaModel>> getCinemaByMovie(String id);

}

class CinemaRemoteDatasourceImpl implements CinemaRemoteDatasource {
  final FirebaseFirestore firestore;

  CinemaRemoteDatasourceImpl(this.firestore);

  @override
  Future<List<CinemaModel>> getCinemaByMovie(String id) async {
    final showtimeSnapshot = await firestore
        .collection('showtimes')
        .where('movieId', isEqualTo: id)
        .get();

    final cinemaIds = showtimeSnapshot.docs
        .map((doc) => doc['cinemaId'] as String)
        .toSet()
        .toList();
    if (cinemaIds.isEmpty) return [];

    final cinemaSnapshot = await firestore
        .collection('cinemas')
        .where(FieldPath.documentId, whereIn: cinemaIds)
        .get();

    return cinemaSnapshot.docs
        .map((doc) => CinemaModel.fromFirestore(doc.data(), doc.id))
        .toList();
  }

}
