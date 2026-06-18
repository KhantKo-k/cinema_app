import 'package:cinema_app/features/profile/data/model/profile_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

abstract class ProfileRemoteDatasource {
  Future<ProfileModel> getProfile(String userId);
  Future<void> updateProfile(ProfileModel profile);
}

class ProfileRemoteDatasourceImpl implements ProfileRemoteDatasource {
  final FirebaseFirestore firestore;

  ProfileRemoteDatasourceImpl({required this.firestore});

  @override
  Future<ProfileModel> getProfile(String userId) async {
    final doc = await firestore.collection('users').doc(userId).get();

    if (!doc.exists || doc.data() == null) {
      throw Exception("User not found");
    }

    return ProfileModel.fromFirestore(doc.id, doc.data()!);
  }

  @override
  Future<void> updateProfile(ProfileModel profile) async {
    await firestore.collection('users').doc(profile.id).update({
      'display_name': profile.name,
      'phone': profile.phone,
      'address': profile.address,
    });
  }
}
