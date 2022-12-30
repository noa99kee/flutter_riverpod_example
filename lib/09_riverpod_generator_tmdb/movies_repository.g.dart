// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'movies_repository.dart';

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

String _$moviesRepositoryHash() => r'ed680fa27bb4ac74e064abf9a2691516e0ae6405';

/// See also [moviesRepository].
final moviesRepositoryProvider = AutoDisposeProvider<MoviesRepository>(
  moviesRepository,
  name: r'moviesRepositoryProvider',
  debugGetCreateSourceHash: const bool.fromEnvironment('dart.vm.product')
      ? null
      : _$moviesRepositoryHash,
);
typedef MoviesRepositoryRef = AutoDisposeProviderRef<MoviesRepository>;
String _$fetchMoviesHash() => r'3e3a7b8d1f035438db0c08326996250032c5b7b2';

/// Provider to fetch paginated movies data
///
/// Copied from [fetchMovies].
class FetchMoviesProvider extends AutoDisposeFutureProvider<List<TMDBMovie>> {
  FetchMoviesProvider({
    required this.pagination,
  }) : super(
          (ref) => fetchMovies(
            ref,
            pagination: pagination,
          ),
          from: fetchMoviesProvider,
          name: r'fetchMoviesProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$fetchMoviesHash,
        );

  final MoviesPagination pagination;

  @override
  bool operator ==(Object other) {
    return other is FetchMoviesProvider && other.pagination == pagination;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, pagination.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef FetchMoviesRef = AutoDisposeFutureProviderRef<List<TMDBMovie>>;

/// Provider to fetch paginated movies data
///
/// Copied from [fetchMovies].
final fetchMoviesProvider = FetchMoviesFamily();

class FetchMoviesFamily extends Family<AsyncValue<List<TMDBMovie>>> {
  FetchMoviesFamily();

  FetchMoviesProvider call({
    required MoviesPagination pagination,
  }) {
    return FetchMoviesProvider(
      pagination: pagination,
    );
  }

  @override
  AutoDisposeFutureProvider<List<TMDBMovie>> getProviderOverride(
    covariant FetchMoviesProvider provider,
  ) {
    return call(
      pagination: provider.pagination,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'fetchMoviesProvider';
}

String _$movieHash() => r'698ad6b3eb2222dfeefe2149366ec22167096500';

/// Provider to fetch a movie by ID
///
/// Copied from [movie].
class MovieProvider extends AutoDisposeFutureProvider<TMDBMovie> {
  MovieProvider({
    required this.movieId,
  }) : super(
          (ref) => movie(
            ref,
            movieId: movieId,
          ),
          from: movieProvider,
          name: r'movieProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$movieHash,
        );

  final int movieId;

  @override
  bool operator ==(Object other) {
    return other is MovieProvider && other.movieId == movieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);

    return _SystemHash.finish(hash);
  }
}

typedef MovieRef = AutoDisposeFutureProviderRef<TMDBMovie>;

/// Provider to fetch a movie by ID
///
/// Copied from [movie].
final movieProvider = MovieFamily();

class MovieFamily extends Family<AsyncValue<TMDBMovie>> {
  MovieFamily();

  MovieProvider call({
    required int movieId,
  }) {
    return MovieProvider(
      movieId: movieId,
    );
  }

  @override
  AutoDisposeFutureProvider<TMDBMovie> getProviderOverride(
    covariant MovieProvider provider,
  ) {
    return call(
      movieId: provider.movieId,
    );
  }

  @override
  List<ProviderOrFamily>? get allTransitiveDependencies => null;

  @override
  List<ProviderOrFamily>? get dependencies => null;

  @override
  String? get name => r'movieProvider';
}
