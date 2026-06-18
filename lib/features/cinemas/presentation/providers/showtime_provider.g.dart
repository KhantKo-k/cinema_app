// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'showtime_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$showtimeRemoteDatasourceHash() =>
    r'73a2b52806443e8ccae2f9816422803e49d081c7';

/// See also [showtimeRemoteDatasource].
@ProviderFor(showtimeRemoteDatasource)
final showtimeRemoteDatasourceProvider =
    AutoDisposeProvider<ShowtimeRemoteDatasource>.internal(
      showtimeRemoteDatasource,
      name: r'showtimeRemoteDatasourceProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$showtimeRemoteDatasourceHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ShowtimeRemoteDatasourceRef =
    AutoDisposeProviderRef<ShowtimeRemoteDatasource>;
String _$showtimeRepositoryHash() =>
    r'd31316f7b9f0d96d18e99ca7a2c1cf191b19b822';

/// See also [showtimeRepository].
@ProviderFor(showtimeRepository)
final showtimeRepositoryProvider =
    AutoDisposeProvider<ShowtimeRepository>.internal(
      showtimeRepository,
      name: r'showtimeRepositoryProvider',
      debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
          ? null
          : _$showtimeRepositoryHash,
      dependencies: null,
      allTransitiveDependencies: null,
    );

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
typedef ShowtimeRepositoryRef = AutoDisposeProviderRef<ShowtimeRepository>;
String _$showtimesHash() => r'49af741e9f430d4013513596fd0089441c438b80';

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

/// See also [showtimes].
@ProviderFor(showtimes)
const showtimesProvider = ShowtimesFamily();

/// See also [showtimes].
class ShowtimesFamily extends Family<AsyncValue<List<ShowtimeEntity>>> {
  /// See also [showtimes].
  const ShowtimesFamily();

  /// See also [showtimes].
  ShowtimesProvider call(String movieId, String cinemaId) {
    return ShowtimesProvider(movieId, cinemaId);
  }

  @override
  ShowtimesProvider getProviderOverride(covariant ShowtimesProvider provider) {
    return call(provider.movieId, provider.cinemaId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'showtimesProvider';
}

/// See also [showtimes].
class ShowtimesProvider
    extends AutoDisposeFutureProvider<List<ShowtimeEntity>> {
  /// See also [showtimes].
  ShowtimesProvider(String movieId, String cinemaId)
    : this._internal(
        (ref) => showtimes(ref as ShowtimesRef, movieId, cinemaId),
        from: showtimesProvider,
        name: r'showtimesProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$showtimesHash,
        dependencies: ShowtimesFamily._dependencies,
        allTransitiveDependencies: ShowtimesFamily._allTransitiveDependencies,
        movieId: movieId,
        cinemaId: cinemaId,
      );

  ShowtimesProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieId,
    required this.cinemaId,
  }) : super.internal();

  final String movieId;
  final String cinemaId;

  @override
  Override overrideWith(
    FutureOr<List<ShowtimeEntity>> Function(ShowtimesRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ShowtimesProvider._internal(
        (ref) => create(ref as ShowtimesRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        movieId: movieId,
        cinemaId: cinemaId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ShowtimeEntity>> createElement() {
    return _ShowtimesProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShowtimesProvider &&
        other.movieId == movieId &&
        other.cinemaId == cinemaId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);
    hash = _SystemHash.combine(hash, cinemaId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ShowtimesRef on AutoDisposeFutureProviderRef<List<ShowtimeEntity>> {
  /// The parameter `movieId` of this provider.
  String get movieId;

  /// The parameter `cinemaId` of this provider.
  String get cinemaId;
}

class _ShowtimesProviderElement
    extends AutoDisposeFutureProviderElement<List<ShowtimeEntity>>
    with ShowtimesRef {
  _ShowtimesProviderElement(super.provider);

  @override
  String get movieId => (origin as ShowtimesProvider).movieId;
  @override
  String get cinemaId => (origin as ShowtimesProvider).cinemaId;
}

String _$selectableDaysHash() => r'd6266fa4b3da7051330734bb6fb74bf5a70ac0b5';

/// See also [selectableDays].
@ProviderFor(selectableDays)
const selectableDaysProvider = SelectableDaysFamily();

/// See also [selectableDays].
class SelectableDaysFamily extends Family<AsyncValue<List<DateTime>>> {
  /// See also [selectableDays].
  const SelectableDaysFamily();

  /// See also [selectableDays].
  SelectableDaysProvider call({
    required String movieId,
    required String cinemaId,
  }) {
    return SelectableDaysProvider(movieId: movieId, cinemaId: cinemaId);
  }

  @override
  SelectableDaysProvider getProviderOverride(
    covariant SelectableDaysProvider provider,
  ) {
    return call(movieId: provider.movieId, cinemaId: provider.cinemaId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectableDaysProvider';
}

/// See also [selectableDays].
class SelectableDaysProvider extends AutoDisposeFutureProvider<List<DateTime>> {
  /// See also [selectableDays].
  SelectableDaysProvider({required String movieId, required String cinemaId})
    : this._internal(
        (ref) => selectableDays(
          ref as SelectableDaysRef,
          movieId: movieId,
          cinemaId: cinemaId,
        ),
        from: selectableDaysProvider,
        name: r'selectableDaysProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$selectableDaysHash,
        dependencies: SelectableDaysFamily._dependencies,
        allTransitiveDependencies:
            SelectableDaysFamily._allTransitiveDependencies,
        movieId: movieId,
        cinemaId: cinemaId,
      );

  SelectableDaysProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieId,
    required this.cinemaId,
  }) : super.internal();

  final String movieId;
  final String cinemaId;

  @override
  Override overrideWith(
    FutureOr<List<DateTime>> Function(SelectableDaysRef provider) create,
  ) {
    return ProviderOverride(
      origin: this,
      override: SelectableDaysProvider._internal(
        (ref) => create(ref as SelectableDaysRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        movieId: movieId,
        cinemaId: cinemaId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<DateTime>> createElement() {
    return _SelectableDaysProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectableDaysProvider &&
        other.movieId == movieId &&
        other.cinemaId == cinemaId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);
    hash = _SystemHash.combine(hash, cinemaId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SelectableDaysRef on AutoDisposeFutureProviderRef<List<DateTime>> {
  /// The parameter `movieId` of this provider.
  String get movieId;

  /// The parameter `cinemaId` of this provider.
  String get cinemaId;
}

class _SelectableDaysProviderElement
    extends AutoDisposeFutureProviderElement<List<DateTime>>
    with SelectableDaysRef {
  _SelectableDaysProviderElement(super.provider);

  @override
  String get movieId => (origin as SelectableDaysProvider).movieId;
  @override
  String get cinemaId => (origin as SelectableDaysProvider).cinemaId;
}

String _$showtimesForSelectedDayHash() =>
    r'13bc7aed7ede341f4bcebad346839e0a28bc59b8';

/// See also [showtimesForSelectedDay].
@ProviderFor(showtimesForSelectedDay)
const showtimesForSelectedDayProvider = ShowtimesForSelectedDayFamily();

/// See also [showtimesForSelectedDay].
class ShowtimesForSelectedDayFamily
    extends Family<AsyncValue<List<ShowtimeEntity>>> {
  /// See also [showtimesForSelectedDay].
  const ShowtimesForSelectedDayFamily();

  /// See also [showtimesForSelectedDay].
  ShowtimesForSelectedDayProvider call({
    required String movieId,
    required String cinemaId,
  }) {
    return ShowtimesForSelectedDayProvider(
      movieId: movieId,
      cinemaId: cinemaId,
    );
  }

  @override
  ShowtimesForSelectedDayProvider getProviderOverride(
    covariant ShowtimesForSelectedDayProvider provider,
  ) {
    return call(movieId: provider.movieId, cinemaId: provider.cinemaId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'showtimesForSelectedDayProvider';
}

/// See also [showtimesForSelectedDay].
class ShowtimesForSelectedDayProvider
    extends AutoDisposeFutureProvider<List<ShowtimeEntity>> {
  /// See also [showtimesForSelectedDay].
  ShowtimesForSelectedDayProvider({
    required String movieId,
    required String cinemaId,
  }) : this._internal(
         (ref) => showtimesForSelectedDay(
           ref as ShowtimesForSelectedDayRef,
           movieId: movieId,
           cinemaId: cinemaId,
         ),
         from: showtimesForSelectedDayProvider,
         name: r'showtimesForSelectedDayProvider',
         debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
             ? null
             : _$showtimesForSelectedDayHash,
         dependencies: ShowtimesForSelectedDayFamily._dependencies,
         allTransitiveDependencies:
             ShowtimesForSelectedDayFamily._allTransitiveDependencies,
         movieId: movieId,
         cinemaId: cinemaId,
       );

  ShowtimesForSelectedDayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieId,
    required this.cinemaId,
  }) : super.internal();

  final String movieId;
  final String cinemaId;

  @override
  Override overrideWith(
    FutureOr<List<ShowtimeEntity>> Function(ShowtimesForSelectedDayRef provider)
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: ShowtimesForSelectedDayProvider._internal(
        (ref) => create(ref as ShowtimesForSelectedDayRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        movieId: movieId,
        cinemaId: cinemaId,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<List<ShowtimeEntity>> createElement() {
    return _ShowtimesForSelectedDayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is ShowtimesForSelectedDayProvider &&
        other.movieId == movieId &&
        other.cinemaId == cinemaId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);
    hash = _SystemHash.combine(hash, cinemaId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin ShowtimesForSelectedDayRef
    on AutoDisposeFutureProviderRef<List<ShowtimeEntity>> {
  /// The parameter `movieId` of this provider.
  String get movieId;

  /// The parameter `cinemaId` of this provider.
  String get cinemaId;
}

class _ShowtimesForSelectedDayProviderElement
    extends AutoDisposeFutureProviderElement<List<ShowtimeEntity>>
    with ShowtimesForSelectedDayRef {
  _ShowtimesForSelectedDayProviderElement(super.provider);

  @override
  String get movieId => (origin as ShowtimesForSelectedDayProvider).movieId;
  @override
  String get cinemaId => (origin as ShowtimesForSelectedDayProvider).cinemaId;
}

String _$selectedDayHash() => r'8291e924607c953410dea3f288292d62a8ea2a21';

abstract class _$SelectedDay
    extends BuildlessAutoDisposeAsyncNotifier<DateTime?> {
  late final String movieId;
  late final String cinemaId;

  FutureOr<DateTime?> build({
    required String movieId,
    required String cinemaId,
  });
}

/// See also [SelectedDay].
@ProviderFor(SelectedDay)
const selectedDayProvider = SelectedDayFamily();

/// See also [SelectedDay].
class SelectedDayFamily extends Family<AsyncValue<DateTime?>> {
  /// See also [SelectedDay].
  const SelectedDayFamily();

  /// See also [SelectedDay].
  SelectedDayProvider call({
    required String movieId,
    required String cinemaId,
  }) {
    return SelectedDayProvider(movieId: movieId, cinemaId: cinemaId);
  }

  @override
  SelectedDayProvider getProviderOverride(
    covariant SelectedDayProvider provider,
  ) {
    return call(movieId: provider.movieId, cinemaId: provider.cinemaId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedDayProvider';
}

/// See also [SelectedDay].
class SelectedDayProvider
    extends AutoDisposeAsyncNotifierProviderImpl<SelectedDay, DateTime?> {
  /// See also [SelectedDay].
  SelectedDayProvider({required String movieId, required String cinemaId})
    : this._internal(
        () => SelectedDay()
          ..movieId = movieId
          ..cinemaId = cinemaId,
        from: selectedDayProvider,
        name: r'selectedDayProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$selectedDayHash,
        dependencies: SelectedDayFamily._dependencies,
        allTransitiveDependencies: SelectedDayFamily._allTransitiveDependencies,
        movieId: movieId,
        cinemaId: cinemaId,
      );

  SelectedDayProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieId,
    required this.cinemaId,
  }) : super.internal();

  final String movieId;
  final String cinemaId;

  @override
  FutureOr<DateTime?> runNotifierBuild(covariant SelectedDay notifier) {
    return notifier.build(movieId: movieId, cinemaId: cinemaId);
  }

  @override
  Override overrideWith(SelectedDay Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectedDayProvider._internal(
        () => create()
          ..movieId = movieId
          ..cinemaId = cinemaId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        movieId: movieId,
        cinemaId: cinemaId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<SelectedDay, DateTime?>
  createElement() {
    return _SelectedDayProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedDayProvider &&
        other.movieId == movieId &&
        other.cinemaId == cinemaId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);
    hash = _SystemHash.combine(hash, cinemaId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SelectedDayRef on AutoDisposeAsyncNotifierProviderRef<DateTime?> {
  /// The parameter `movieId` of this provider.
  String get movieId;

  /// The parameter `cinemaId` of this provider.
  String get cinemaId;
}

class _SelectedDayProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<SelectedDay, DateTime?>
    with SelectedDayRef {
  _SelectedDayProviderElement(super.provider);

  @override
  String get movieId => (origin as SelectedDayProvider).movieId;
  @override
  String get cinemaId => (origin as SelectedDayProvider).cinemaId;
}

String _$selectedShowtimeHash() => r'2d148fe1dfc28357c4d30050674aa93923ed0ae4';

abstract class _$SelectedShowtime
    extends BuildlessAutoDisposeNotifier<String?> {
  late final String movieId;
  late final String cinemaId;

  String? build({required String movieId, required String cinemaId});
}

/// See also [SelectedShowtime].
@ProviderFor(SelectedShowtime)
const selectedShowtimeProvider = SelectedShowtimeFamily();

/// See also [SelectedShowtime].
class SelectedShowtimeFamily extends Family<String?> {
  /// See also [SelectedShowtime].
  const SelectedShowtimeFamily();

  /// See also [SelectedShowtime].
  SelectedShowtimeProvider call({
    required String movieId,
    required String cinemaId,
  }) {
    return SelectedShowtimeProvider(movieId: movieId, cinemaId: cinemaId);
  }

  @override
  SelectedShowtimeProvider getProviderOverride(
    covariant SelectedShowtimeProvider provider,
  ) {
    return call(movieId: provider.movieId, cinemaId: provider.cinemaId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'selectedShowtimeProvider';
}

/// See also [SelectedShowtime].
class SelectedShowtimeProvider
    extends AutoDisposeNotifierProviderImpl<SelectedShowtime, String?> {
  /// See also [SelectedShowtime].
  SelectedShowtimeProvider({required String movieId, required String cinemaId})
    : this._internal(
        () => SelectedShowtime()
          ..movieId = movieId
          ..cinemaId = cinemaId,
        from: selectedShowtimeProvider,
        name: r'selectedShowtimeProvider',
        debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
            ? null
            : _$selectedShowtimeHash,
        dependencies: SelectedShowtimeFamily._dependencies,
        allTransitiveDependencies:
            SelectedShowtimeFamily._allTransitiveDependencies,
        movieId: movieId,
        cinemaId: cinemaId,
      );

  SelectedShowtimeProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.movieId,
    required this.cinemaId,
  }) : super.internal();

  final String movieId;
  final String cinemaId;

  @override
  String? runNotifierBuild(covariant SelectedShowtime notifier) {
    return notifier.build(movieId: movieId, cinemaId: cinemaId);
  }

  @override
  Override overrideWith(SelectedShowtime Function() create) {
    return ProviderOverride(
      origin: this,
      override: SelectedShowtimeProvider._internal(
        () => create()
          ..movieId = movieId
          ..cinemaId = cinemaId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        movieId: movieId,
        cinemaId: cinemaId,
      ),
    );
  }

  @override
  AutoDisposeNotifierProviderElement<SelectedShowtime, String?>
  createElement() {
    return _SelectedShowtimeProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is SelectedShowtimeProvider &&
        other.movieId == movieId &&
        other.cinemaId == cinemaId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);
    hash = _SystemHash.combine(hash, cinemaId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin SelectedShowtimeRef on AutoDisposeNotifierProviderRef<String?> {
  /// The parameter `movieId` of this provider.
  String get movieId;

  /// The parameter `cinemaId` of this provider.
  String get cinemaId;
}

class _SelectedShowtimeProviderElement
    extends AutoDisposeNotifierProviderElement<SelectedShowtime, String?>
    with SelectedShowtimeRef {
  _SelectedShowtimeProviderElement(super.provider);

  @override
  String get movieId => (origin as SelectedShowtimeProvider).movieId;
  @override
  String get cinemaId => (origin as SelectedShowtimeProvider).cinemaId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
