import 'package:json_annotation/json_annotation.dart';

part 'user_auth_model.g.dart';

@JsonSerializable()
class UserAuthModel {
  final String uid;

  final String email;

  @JsonKey(name: 'display_name')
  final String? displayName;

  final String? role;
  final String? phone;
  

  UserAuthModel({
    required this.uid,
    required this.email,
    this.displayName,
    this.role,
    this.phone,
  });

  factory UserAuthModel.fromJson(Map<String, dynamic> json) => _$UserAuthModelFromJson(json);

  factory UserAuthModel.fromFirestore(
    String uid,
    Map<String, dynamic> json,
  ) {
    return UserAuthModel(
      uid: uid,
      email: json['email'] as String,
      displayName: json['display_name'] as String?,
      role: json['role'] as String?,
      phone: json['phone'] as String?,
    );
  }

  Map<String, dynamic> toJson() => _$UserAuthModelToJson(this);
}