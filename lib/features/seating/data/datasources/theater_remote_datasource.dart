import 'package:cinema_app/features/seating/data/models/seat_model.dart';
import 'package:cinema_app/features/seating/data/models/seat_type_model.dart';
import 'package:cinema_app/features/seating/data/models/theater_model.dart';
import 'package:cinema_app/features/seating/domain/entities/seat_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class TheaterRemoteDatasource {
  Future<TheaterModel> getTheater(String theaterId);
  Future<List<SeatTypeModel>> getSeatTypes();
  Stream<List<SeatModel>> watchSeats(String showtimeId);
}

class TheaterRemoteDatasourceImpl implements TheaterRemoteDatasource {
  final FirebaseFirestore firestore;

  const TheaterRemoteDatasourceImpl(this.firestore);

  @override
  Future<TheaterModel> getTheater(String theaterId) async {
    final snap = await firestore.collection('theraters').doc(theaterId).get();
    if (!snap.exists) {
      throw Exception('Theater not found');
    }
    return TheaterModel.fromJson({
      'id': snap.id,
      ...snap
          .data()!,
    });
  }

  @override
  Future<List<SeatTypeModel>> getSeatTypes() async {
    final snap = await firestore.collection('seatTypes').get();

    return snap.docs.map((doc) {
      return SeatTypeModel.fromJson({'id': doc.id, ...doc.data()});
    }).toList();
  }

  @override
  Stream<List<SeatModel>> watchSeats(String showtimeId) {
    return firestore
        .collection('showtimes')
        .doc(showtimeId)
        .collection('seats')
        .snapshots()
        .asyncMap((snapshot) async {
      return Future.wait(snapshot.docs.map((doc) async {
        return await _mapSeat(doc);
      }));
    });
  }

  Future<SeatModel> _mapSeat( 
    QueryDocumentSnapshot<Map<String, dynamic>> doc
  ) async {
    final data = doc.data();
    return SeatModel(
      seatId: doc.id, 
      row: data['row'] as String, 
      column: data['column'].toString(), 
      status: _parseSeatStatus(data['status']),
      lockedBy: data['lockedBy'] as String?,
      lockedAt: (data['lockedAt'] as Timestamp?)?.toDate(),
    );
  }

  SeatStatus _parseSeatStatus(String status) {
    switch (status) {
      case 'available':
        return SeatStatus.available;
      case 'booked':
        return SeatStatus.booked;
      case 'locked':
        return SeatStatus.locked;
      default:
        return SeatStatus.unknown;
    }
  }
}
