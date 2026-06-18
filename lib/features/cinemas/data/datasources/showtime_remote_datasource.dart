import 'package:cinema_app/features/cinemas/data/model/showtime_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ShowtimeRemoteDatasource {
    Future<List<ShowtimeModel>> getShowtimes(String movieId, String cinemaId);
}

class ShowtimeRemoteDatasourceImpl implements ShowtimeRemoteDatasource{
  final FirebaseFirestore firestore;
  const ShowtimeRemoteDatasourceImpl(this.firestore);


    @override
  Future<List<ShowtimeModel>> getShowtimes(
    String movieId,
    String cinemaId,
  ) async {
    final now = DateTime.now();

    final snapshot = await firestore
        .collection('showtimes')
        .where('cinemaId', isEqualTo: cinemaId)
        .where('movieId', isEqualTo: movieId)
        .where('startTime', isGreaterThan: now)
        .orderBy('startTime')
        .get();
    return snapshot.docs
        .map((doc) => ShowtimeModel.fromFirebase(doc.data(), doc.id))
        .toList();
  }
}