// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

ProfileModel _$ProfileModelFromJson(Map<String, dynamic> json) => ProfileModel(
  id: json['id'] as String,
  name: json['display_name'] as String,
  email: json['email'] as String,
  phone: json['phone'] as String?,
  address: json['address'] as String?,
);

Map<String, dynamic> _$ProfileModelToJson(ProfileModel instance) =>
    <String, dynamic>{
      'id': instance.id,
      'email': instance.email,
      'phone': instance.phone,
      'address': instance.address,
      'display_name': instance.name,
    };
