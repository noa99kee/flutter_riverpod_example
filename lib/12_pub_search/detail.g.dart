// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'detail.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// ignore_for_file: avoid_private_typedef_functions, non_constant_identifier_names, subtype_of_sealed_class, invalid_use_of_internal_member, unused_element, constant_identifier_names, unnecessary_raw_strings, library_private_types_in_public_api

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

String _$PackageMetricsHash() => r'67cd25e50357e6e970d432c1d255085a23b856ac';

/// A provider that fetches the likes count, popularity score and pub points
/// for a given package.
///
/// It also exposes utilities to like/unlike a package, assuming the user
/// is logged-in.
///
/// Copied from [PackageMetrics].
class PackageMetricsProvider extends AutoDisposeAsyncNotifierProviderImpl<
    PackageMetrics, PackageMetricsScore> {
  PackageMetricsProvider({
    required this.packageName,
  }) : super(
          () => PackageMetrics()..packageName = packageName,
          from: packageMetricsProvider,
          name: r'packageMetricsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$PackageMetricsHash,
        );

  final String packageName;

  @override
  bool operator ==(Object other) {
    return other is PackageMetricsProvider && other.packageName == packageName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, packageName.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<PackageMetricsScore> runNotifierBuild(
    covariant _$PackageMetrics notifier,
  ) {
    return notifier.build(
      packageName: packageName,
    );
  }
}

typedef PackageMetricsRef
    = AutoDisposeAsyncNotifierProviderRef<PackageMetricsScore>;

/// A provider that fetches the likes count, popularity score and pub points
/// for a given package.
///
/// It also exposes utilities to like/unlike a package, assuming the user
/// is logged-in.
///
/// Copied from [PackageMetrics].
final packageMetricsProvider = PackageMetricsFamily();

class PackageMetricsFamily extends Family<AsyncValue<PackageMetricsScore>> {
  PackageMetricsFamily();

  PackageMetricsProvider call({
    required String packageName,
  }) {
    return PackageMetricsProvider(
      packageName: packageName,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderImpl<PackageMetrics, PackageMetricsScore>
      getProviderOverride(
    covariant PackageMetricsProvider provider,
  ) {
    return call(
      packageName: provider.packageName,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'packageMetricsProvider';
}

abstract class _$PackageMetrics
    extends BuildlessAutoDisposeAsyncNotifier<PackageMetricsScore> {
  late final String packageName;

  FutureOr<PackageMetricsScore> build({
    required String packageName,
  });
}

String _$fetchPackageDetailsHash() =>
    r'30e62529e7046db38fb71c2d103aca310277aa09';

/// See also [fetchPackageDetails].
class FetchPackageDetailsProvider extends AutoDisposeFutureProvider<Package> {
  FetchPackageDetailsProvider({
    required this.packageName,
  }) : super(
          (ref) => fetchPackageDetails(
            ref,
            packageName: packageName,
          ),
          from: fetchPackageDetailsProvider,
          name: r'fetchPackageDetailsProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchPackageDetailsHash,
        );

  final String packageName;

  @override
  bool operator ==(Object other) {
    return other is FetchPackageDetailsProvider &&
        other.packageName == packageName;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, packageName.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef FetchPackageDetailsRef = AutoDisposeFutureProviderRef<Package>;

/// See also [fetchPackageDetails].
final fetchPackageDetailsProvider = FetchPackageDetailsFamily();

class FetchPackageDetailsFamily extends Family<AsyncValue<Package>> {
  FetchPackageDetailsFamily();

  FetchPackageDetailsProvider call({
    required String packageName,
  }) {
    return FetchPackageDetailsProvider(
      packageName: packageName,
    );
  }

  @override
  AutoDisposeFutureProvider<Package> getProviderOverride(
    covariant FetchPackageDetailsProvider provider,
  ) {
    return call(
      packageName: provider.packageName,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'fetchPackageDetailsProvider';
}

String _$likedPackagesHash() => r'85a5d34b7602b28a2eb904f232b1353e9dbffd91';

/// See also [likedPackages].
final likedPackagesProvider = AutoDisposeFutureProvider<List<String>>(
  likedPackages,
  name: r'likedPackagesProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$likedPackagesHash,
);
typedef LikedPackagesRef = AutoDisposeFutureProviderRef<List<String>>;
String _$pubRepositoryHash() => r'1f4dbfa0911f6467067fab244677acbcb8c7ad4e';

/// See also [pubRepository].
final pubRepositoryProvider = AutoDisposeProvider<PubRepository>(
  pubRepository,
  name: r'pubRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$pubRepositoryHash,
);
typedef PubRepositoryRef = AutoDisposeProviderRef<PubRepository>;
