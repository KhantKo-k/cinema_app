import 'package:cinema_app/features/cinemas/domain/entities/cinema_entity.dart';
import 'package:json_annotation/json_annotation.dart';

part 'cinema_model.g.dart';

@JsonSerializable()
class CinemaModel extends CinemaEntity {
  final String? id;
  final String name;
  final String location;
  final String cinemaUrl;

  const CinemaModel({
    this.id,
    required this.name,
    required this.location,
    required this.cinemaUrl,
  }) : super(
          id: id,
          name: name,
          location: location,
          cinemaUrl: cinemaUrl,
        );

  factory CinemaModel.fromJson(Map<String, dynamic> json) =>
      _$CinemaModelFromJson(json);

  Map<String, dynamic> toJson() => _$CinemaModelToJson(this);

  factory CinemaModel.fromFirestore(Map<String, dynamic> json, String id) {
    return CinemaModel(
      id: id,
      name: json['name'],
      location: json['location'],
      cinemaUrl: json['cinemaUrl'],
    );
  }
}