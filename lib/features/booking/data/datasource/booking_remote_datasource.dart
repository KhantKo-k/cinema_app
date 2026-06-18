import 'package:cinema_app/features/booking/data/model/order_model.dart';
import 'package:cinema_app/features/booking/domain/entity/order_entity.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

abstract class BookingRemoteDatasource {
  Future<String> createOrder({
    required String showtimeId,
    required List<String> selectedSeats,
    required OrderAction action,
  });

  Future<List<OrderEntity>> fetchUserOrders(String userId);
}

class BookingremoteDatasourceImpl implements BookingRemoteDatasource {
  final FirebaseFirestore firestore;
  final FirebaseAuth auth;

  BookingremoteDatasourceImpl({required this.firestore, required this.auth});

  @override
  Future<String> createOrder({
    required String showtimeId,
    required List<String> selectedSeats,
    required OrderAction action,
  }) async {
    final user = auth.currentUser;
    if (user == null) {
      throw Exception('User not authenticated');
    }
    final orderRef = firestore.collection('orders').doc();

    final payMentStatus = action == OrderAction.buy
        ? PaymentStatus.paid
        : PaymentStatus.unpaid;
    final order = OrderModel(
      orderId: orderRef.id,
      userId: user.uid,
      showtimeId: showtimeId,
      seatIds: selectedSeats.map((e) => e).toList(),
      action: action,
      paymentStatus: payMentStatus,
      createdAt: DateTime.now(),
    );

    await firestore.runTransaction((transaction) async {
      final seatRefs = selectedSeats.map((seatId) {
        return firestore
            .collection('showtimes')
            .doc(showtimeId)
            .collection('seats')
            .doc(seatId);
      }).toList();

      final snapshots = <DocumentSnapshot>[];

      for (final ref in seatRefs) {
        final snap = await transaction.get(ref);
        snapshots.add(snap);
      }

      for (int i = 0; i < snapshots.length; i++) {
        final snap = snapshots[i];
        final seatId = selectedSeats[i];

        if (snap.exists) {
          final data = snap.data() as Map<String, dynamic>;
          final status = data['status'];

          if (status == 'booked') {
            throw Exception('Seat $seatId already booked');
          }
        }
      }
      for (int i = 0; i < seatRefs.length; i++) {
        final seatId = selectedSeats[i];
        final ref = seatRefs[i];

        final row = seatId.substring(0, 1);
        final column = int.parse(seatId.substring(1));
        final status = action == OrderAction.book ? "booked" : "locked";

        transaction.set(ref, {
          'row': row,
          'column': column,
          'status': status,
          'lockedAt': null,
          'lockedBy': null,
          'userId': user.uid,
          'orderId': orderRef.id,
        });
      }

      transaction.set(orderRef, order.toJson());
    });

    return orderRef.id;
  }

  @override
  Future<List<OrderModel>> fetchUserOrders(String userId) async {
    final snapshot = await firestore
        .collection('orders')
        .where('userId', isEqualTo: userId)
        .get();

    return snapshot.docs.map((doc) => OrderModel.fromJson(doc.data())).toList();
  }
}
