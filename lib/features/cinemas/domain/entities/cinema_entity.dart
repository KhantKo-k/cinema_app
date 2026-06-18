import 'package:equatable/equatable.dart';

class CinemaEntity extends Equatable{
  final String? id;
  final String name;
  final String location;
  final String cinemaUrl;

  const CinemaEntity({
    this.id,
    required this.name,
    required this.location,
    required this.cinemaUrl,
  });

  @override
  List<Object?> get props => [
    id, name, location, cinemaUrl
  ];
}