import 'package:equatable/equatable.dart';

class ShowtimeEntity extends Equatable{
  final String? id;
  final String cinemaId;
  final String movieId;
  final String theaterId;
  final DateTime startTime;
  final DateTime endTime;
  final String theaterName;

  const ShowtimeEntity({
    this.id,
    required this.cinemaId,
    required this.movieId,
    required this.theaterId,
    required this.startTime,
    required this.endTime,
    required this.theaterName,
  });

  @override 
  List<Object?> get props => [
    id, cinemaId, movieId, theaterId, startTime, endTime, theaterName
  ];
}