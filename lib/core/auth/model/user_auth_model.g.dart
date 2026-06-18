// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user_auth_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

UserAuthModel _$UserAuthModelFromJson(Map<String, dynamic> json) =>
    UserAuthModel(
      uid: json['uid'] as String,
      email: json['email'] as String,
      displayName: json['display_name'] as String?,
      role: json['role'] as String?,
      phone: json['phone'] as String?,
    );

Map<String, dynamic> _$UserAuthModelToJson(UserAuthModel instance) =>
    <String, dynamic>{
      'uid': instance.uid,
      'email': instance.email,
      'display_name': instance.displayName,
      'role': instance.role,
      'phone': instance.phone,
    };
