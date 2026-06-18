// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cinema_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$cinemaRemoteDatasourceHash() =>
    r'8598f82eb24ab0174cc526e636821d4a5597879c';

/// See also [cinemaRemoteDatasource].
@ProviderFor(cinemaRemoteDatasource)
final cinemaRemoteDatasourceProvider =
    AutoDisposeProvider<CinemaRemoteDatasource>.internal(
      cinemaRemoteDatasource,
      name: r'cinemaRemoteDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$cinemaRemoteDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CinemaRemoteDatasourceRef =
    AutoDisposeProviderRef<CinemaRemoteDatasource>;
String _$cinemaRepositoryHash() => r'e0b22f6546aaae0af70d1c2231698d7ad6fe17c9';

/// See also [cinemaRepository].
@ProviderFor(cinemaRepository)
final cinemaRepositoryProvider = AutoDisposeProvider<CinemaRepository>.internal(
  cinemaRepository,
  name: r'cinemaRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$cinemaRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef CinemaRepositoryRef = AutoDisposeProviderRef<CinemaRepository>;
String _$cinemasHash() => r'6666c04aae3481f263d7f5e03cadce0757735d57';

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

/// See also [cinemas].
@ProviderFor(cinemas)
const cinemasProvider = CinemasFamily();

/// See also [cinemas].
class CinemasFamily extends Family<AsyncValue<List<CinemaEntity>>> {
  /// See also [cinemas].
  const CinemasFamily();

  /// See also [cinemas].
  CinemasProvider call(String movieId) {
    return CinemasProvider(movieId);
  }

  @override
  CinemasProvider getProviderOverride(covariant CinemasProvider provider) {
    return call(provider.movieId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'cinemasProvider';
}

/// See also [cinemas].
class CinemasProvider extends AutoDisposeFutureProvider<List<CinemaEntity>> {
  /// See also [cinemas].
  CinemasProvider(String movieId)
    : this._internal(
        (ref) => cinemas(ref as CinemasRef, movieId),
        from: cinemasProvider,
        name: r'cinemasProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$cinemasHash,
        dependencies: CinemasFamily._dependencies,
        allTransitiveDependencies: CinemasFamily._allTransitiveDependencies,
        movieId: movieId,
      );

  CinemasProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieId,
  }) : super.internal();

  final String movieId;

  @override
  Override overrideWith(
    FutureOr<List<CinemaEntity>> Function(CinemasRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: CinemasProvider._internal(
        (ref) => create(ref as CinemasRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        movieId: movieId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<CinemaEntity>> createElement() {
    return _CinemasProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is CinemasProvider && other.movieId == movieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin CinemasRef on AutoDisposeFutureProviderRef<List<CinemaEntity>> {
  /// The parameter `movieId` of this provider.
  String get movieId;
}

class _CinemasProviderElement
    extends AutoDisposeFutureProviderElement<List<CinemaEntity>>
    with CinemasRef {
  _CinemasProviderElement(super.provider);

  @override
  String get movieId => (origin as CinemasProvider).movieId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
