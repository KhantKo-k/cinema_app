
import 'package:cinema_app/features/booking/data/datasource/booking_remote_datasource.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'datasource_providers.g.dart';

@riverpod   
BookingRemoteDatasource bookingRemoteDatasource(BookingRemoteDatasourceRef ref){
  final firestore = FirebaseFirestore.instance;
  final auth = FirebaseAuth.instance;
  return BookingremoteDatasourceImpl(firestore: firestore, auth: auth);
}