import 'package:json_annotation/json_annotation.dart';
// Ensure this matches your actual entity path
import 'package:cinema_app/features/profile/domain/entity/profile_entity.dart';

part 'profile_model.g.dart';

@JsonSerializable()
class ProfileModel extends ProfileEntity{
  // final String id;
  
  @override
  @JsonKey(name: 'display_name')
  final String name;

  // final String email;
  // final String? phone;
  // final String? address;

  ProfileModel({
    required super.id,
    required this.name,
    required super.email,
    super.phone,
    super.address,
  }) : super(name: name);

  // Connect the generated function
  factory ProfileModel.fromJson(Map<String, dynamic> json) => 
      _$ProfileModelFromJson(json);

  // Connect the generated function
  Map<String, dynamic> toJson() => _$ProfileModelToJson(this);

  // Custom factory for Firestore
  factory ProfileModel.fromFirestore(String docId, Map<String, dynamic> json) {
    return ProfileModel(
      id: docId, 
      name: json['display_name'] as String? ?? '', 
      email: json['email'] as String? ?? '',
      phone: json['phone'] as String?,
      address: json['address'] as String?,
    );
  }
}