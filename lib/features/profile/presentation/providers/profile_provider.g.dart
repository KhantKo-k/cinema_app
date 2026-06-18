// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'profile_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$profileRemoteDatasourceHash() =>
    r'63754704040bb939857e363eecd83e6864bee8e0';

/// See also [profileRemoteDatasource].
@ProviderFor(profileRemoteDatasource)
final profileRemoteDatasourceProvider =
    AutoDisposeProvider<ProfileRemoteDatasource>.internal(
      profileRemoteDatasource,
      name: r'profileRemoteDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileRemoteDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileRemoteDatasourceRef =
    AutoDisposeProviderRef<ProfileRemoteDatasource>;
String _$profileRepositoryHash() => r'ea4fe153ad503da743c41f20834a0ba0d708bb11';

/// See also [profileRepository].
@ProviderFor(profileRepository)
final profileRepositoryProvider =
    AutoDisposeProvider<ProfileRepository>.internal(
      profileRepository,
      name: r'profileRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$profileRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ProfileRepositoryRef = AutoDisposeProviderRef<ProfileRepository>;
String _$getProfileUseCaseHash() => r'0c1c2f646523daead52cfc79fdca86da09c9b045';

/// See also [getProfileUseCase].
@ProviderFor(getProfileUseCase)
final getProfileUseCaseProvider =
    AutoDisposeProvider<GetProfileUseCase>.internal(
      getProfileUseCase,
      name: r'getProfileUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$getProfileUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef GetProfileUseCaseRef = AutoDisposeProviderRef<GetProfileUseCase>;
String _$updateProfileUseCaseHash() =>
    r'0f8b9a861fa13dabdf79335787e1ae445b5810a1';

/// See also [updateProfileUseCase].
@ProviderFor(updateProfileUseCase)
final updateProfileUseCaseProvider =
    AutoDisposeProvider<UpdateProfileUseCase>.internal(
      updateProfileUseCase,
      name: r'updateProfileUseCaseProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$updateProfileUseCaseHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpdateProfileUseCaseRef = AutoDisposeProviderRef<UpdateProfileUseCase>;
String _$userProfileHash() => r'd7554737e38ad23d1df4b9e69554eb305f968d8e';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [userProfile].
@ProviderFor(userProfile)
const userProfileProvider = UserProfileFamily();

/// See also [userProfile].
class UserProfileFamily extends Family<AsyncValue<ProfileEntity>> {
  /// See also [userProfile].
  const UserProfileFamily();

  /// See also [userProfile].
  UserProfileProvider call({required String userId}) {
    return UserProfileProvider(userId: userId);
  }

  @override
  UserProfileProvider getProviderOverride(
    covariant UserProfileProvider provider,
  ) {
    return call(userId: provider.userId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'userProfileProvider';
}

/// See also [userProfile].
class UserProfileProvider extends AutoDisposeFutureProvider<ProfileEntity> {
  /// See also [userProfile].
  UserProfileProvider({required String userId})
    : this._internal(
        (ref) => userProfile(ref as UserProfileRef, userId: userId),
        from: userProfileProvider,
        name: r'userProfileProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$userProfileHash,
        dependencies: UserProfileFamily._dependencies,
        allTransitiveDependencies: UserProfileFamily._allTransitiveDependencies,
        userId: userId,
      );

  UserProfileProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.userId,
  }) : super.internal();

  final String userId;

  @override
  Override overrideWith(
    FutureOr<ProfileEntity> Function(UserProfileRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: UserProfileProvider._internal(
        (ref) => create(ref as UserProfileRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        userId: userId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<ProfileEntity> createElement() {
    return _UserProfileProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is UserProfileProvider && other.userId == userId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, userId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin UserProfileRef on AutoDisposeFutureProviderRef<ProfileEntity> {
  /// The parameter `userId` of this provider.
  String get userId;
}

class _UserProfileProviderElement
    extends AutoDisposeFutureProviderElement<ProfileEntity>
    with UserProfileRef {
  _UserProfileProviderElement(super.provider);

  @override
  String get userId => (origin as UserProfileProvider).userId;
}

String _$updateProfileControllerHash() =>
    r'af232c41dc7f621fa96892fa4236cb4ffdc781da';

/// See also [UpdateProfileController].
@ProviderFor(UpdateProfileController)
final updateProfileControllerProvider =
    AutoDisposeAsyncNotifierProvider<UpdateProfileController, void>.internal(
      UpdateProfileController.new,
      name: r'updateProfileControllerProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$updateProfileControllerHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

typedef _$UpdateProfileController = AutoDisposeAsyncNotifier<void>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
