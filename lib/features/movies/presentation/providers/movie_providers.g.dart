// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movie_providers.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$firestoreHash() => r'ef4a6b0737caace50a6d79dd3e4e2aa1bc3031d5';

/// See also [firestore].
@ProviderFor(firestore)
final firestoreProvider = AutoDisposeProvider<FirebaseFirestore>.internal(
  firestore,
  name: r'firestoreProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$firestoreHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef FirestoreRef = AutoDisposeProviderRef<FirebaseFirestore>;
String _$movieRemoteDatasourceHash() =>
    r'6d46359ad70f640397c212bf13a3b705ca66f4b7';

/// See also [movieRemoteDatasource].
@ProviderFor(movieRemoteDatasource)
final movieRemoteDatasourceProvider =
    AutoDisposeProvider<MovieRemoteDatasource>.internal(
      movieRemoteDatasource,
      name: r'movieRemoteDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$movieRemoteDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MovieRemoteDatasourceRef =
    AutoDisposeProviderRef<MovieRemoteDatasource>;
String _$movieRepositoryHash() => r'8e036976ecc8625bb3463c7e313bd1e5db68b3d5';

/// See also [movieRepository].
@ProviderFor(movieRepository)
final movieRepositoryProvider = AutoDisposeProvider<MovieRepository>.internal(
  movieRepository,
  name: r'movieRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$movieRepositoryHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MovieRepositoryRef = AutoDisposeProviderRef<MovieRepository>;
String _$moviesHash() => r'556c151858d290d8f1cab76325eef32bdef08334';

/// See also [movies].
@ProviderFor(movies)
final moviesProvider = AutoDisposeFutureProvider<List<MovieEntity>>.internal(
  movies,
  name: r'moviesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$moviesHash,
  dependencies: null,
  allTransitiveDependencies: null,
);

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef MoviesRef = AutoDisposeFutureProviderRef<List<MovieEntity>>;
String _$upcomingMoviesHash() => r'9a2c4b96f4e07558d74501b360f0e9a23b17665b';

/// See also [upcomingMovies].
@ProviderFor(upcomingMovies)
final upcomingMoviesProvider =
    AutoDisposeFutureProvider<List<MovieEntity>>.internal(
      upcomingMovies,
      name: r'upcomingMoviesProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$upcomingMoviesHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef UpcomingMoviesRef = AutoDisposeFutureProviderRef<List<MovieEntity>>;
// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
