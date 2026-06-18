
import 'package:equatable/equatable.dart';

class MovieEntity extends Equatable{
  final String? id;
  final String title;
  final String description;
  final String posterUrl;
  final String trailerUrl;
  final String director;
  final String subtitles;
  final int duration;
  final String rating;
  final List<String> genre;
  final List<String> cast;
  final DateTime startDate;
  final DateTime endDate;
  final String status;
  final DateTime createdAt;
  final DateTime updatedAt;

  const MovieEntity({
    this.id,
    required this.title,
    required this.description,
    required this.posterUrl,
    required this.trailerUrl,
    required this.director,
    required this.subtitles,
    required this.duration,
    required this.rating,
    required this.genre,
    required this.cast,
    required this.startDate,
    required this.endDate,
    required this.status,
    required this.createdAt,
    required this.updatedAt,
  });

  @override
  List<Object?> get props => [
    id,title,description,posterUrl,trailerUrl,
    director,subtitles,duration,rating,cast,
    genre,startDate,endDate,status,createdAt,
    updatedAt
  ];

}