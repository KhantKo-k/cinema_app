
import 'package:cinema_app/features/profile/data/datasource/profile_remote_datasource.dart';
import 'package:cinema_app/features/profile/data/repository/profile_repository_impl.dart';
import 'package:cinema_app/features/profile/domain/entity/profile_entity.dart';
import 'package:cinema_app/features/profile/domain/repository/profile_repository.dart';
import 'package:cinema_app/features/profile/domain/usecases/get_profile_use_case.dart';
import 'package:cinema_app/features/profile/domain/usecases/update_profile_use_case.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'profile_provider.g.dart';

@riverpod     
ProfileRemoteDatasource profileRemoteDatasource(ProfileRemoteDatasourceRef ref) {
  return ProfileRemoteDatasourceImpl(firestore: FirebaseFirestore.instance);
}

@riverpod 
ProfileRepository profileRepository(ProfileRepositoryRef ref) {
  final datasource = ref.read(profileRemoteDatasourceProvider);
  return ProfileRepositoryImpl(datasource: datasource);
}

@riverpod 
GetProfileUseCase getProfileUseCase(GetProfileUseCaseRef ref) {
  final repository = ref.read(profileRepositoryProvider);
  return GetProfileUseCase(repository: repository);
}

@riverpod 
UpdateProfileUseCase updateProfileUseCase(UpdateProfileUseCaseRef ref) {
  final repository = ref.read(profileRepositoryProvider);
  return UpdateProfileUseCase(repository: repository);
}


@riverpod
Future<ProfileEntity> userProfile(UserProfileRef ref, {required String userId}) async {

  final usecase = ref.watch(getProfileUseCaseProvider);

  final result = await usecase(userId);

  return result.fold(
    (failure) => throw failure.toString(), 
    (user) => user,
  );
}

@riverpod
class UpdateProfileController extends _$UpdateProfileController {
  @override
  FutureOr<void> build() {
    
  }

  Future<void> updateProfile(ProfileEntity profile) async {
    state = const AsyncLoading();

    final result = await ref.read(updateProfileUseCaseProvider)(profile);

    result.fold(
      (failure) => state = AsyncError(failure, StackTrace.current),
      (_) {
        ref.invalidate(userProfileProvider(userId: profile.id));
        state = const AsyncData(null);
      },
    );
  }
}