// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riverpod_generator_widget.dart';

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

String _$helloWorldHash() => r'8bbe6cff2b7b1f4e1f7be3d1820da793259f7bfc';

/// See also [helloWorld].
final helloWorldProvider = AutoDisposeProvider<String>(
  helloWorld,
  name: r'helloWorldProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$helloWorldHash,
);
typedef HelloWorldRef = AutoDisposeProviderRef<String>;
String _$moviesHash() => r'59426cb14898a9ae440f0da9be3cbed0b3ca12d6';

/// See also [movies].
class MoviesProvider extends AutoDisposeFutureProvider<List<Movie>> {
  MoviesProvider({
    required this.page,
  }) : super(
          (ref) => movies(
            ref,
            page: page,
          ),
          from: moviesProvider,
          name: r'moviesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$moviesHash,
        );

  final int page;

  @override
  bool operator ==(Object other) {
    return other is MoviesProvider && other.page == page;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, page.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef MoviesRef = AutoDisposeFutureProviderRef<List<Movie>>;

/// See also [movies].
final moviesProvider = MoviesFamily();

class MoviesFamily extends Family<AsyncValue<List<Movie>>> {
  MoviesFamily();

  MoviesProvider call({
    required int page,
  }) {
    return MoviesProvider(
      page: page,
    );
  }

  @override
  AutoDisposeFutureProvider<List<Movie>> getProviderOverride(
    covariant MoviesProvider provider,
  ) {
    return call(
      page: provider.page,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'moviesProvider';
}
