// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'riverpod_generator_widget.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Todo _$$_TodoFromJson(Map<String, dynamic> json) => _$_Todo(
      id: json['id'] as String,
      description: json['description'] as String,
      completed: json['completed'] as bool,
    );

Map<String, dynamic> _$$_TodoToJson(_$_Todo instance) => <String, dynamic>{
      'id': instance.id,
      'description': instance.description,
      'completed': instance.completed,
    };

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

String _$GCounterHash() => r'9d479f0e583d5c8f26086e13f3d5dc188e151488';

/// See also [GCounter].
final gCounterProvider = AutoDisposeNotifierProvider<GCounter, int>(
  GCounter.new,
  name: r'gCounterProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$GCounterHash,
);
typedef GCounterRef = AutoDisposeNotifierProviderRef<int>;

abstract class _$GCounter extends AutoDisposeNotifier<int> {
  @override
  int build();
}

String _$GMovieHash() => r'ea35727a5309d941e1209a4b106f609c5e911787';

/// See also [GMovie].
class GMovieProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GMovie, Movie> {
  GMovieProvider({
    required this.movieId,
  }) : super(
          () => GMovie()..movieId = movieId,
          from: gMovieProvider,
          name: r'gMovieProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$GMovieHash,
        );

  final int movieId;

  @override
  bool operator ==(Object other) {
    return other is GMovieProvider && other.movieId == movieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<Movie> runNotifierBuild(
    covariant _$GMovie notifier,
  ) {
    return notifier.build(
      movieId: movieId,
    );
  }
}

typedef GMovieRef = AutoDisposeAsyncNotifierProviderRef<Movie>;

/// See also [GMovie].
final gMovieProvider = GMovieFamily();

class GMovieFamily extends Family<AsyncValue<Movie>> {
  GMovieFamily();

  GMovieProvider call({
    required int movieId,
  }) {
    return GMovieProvider(
      movieId: movieId,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderImpl<GMovie, Movie> getProviderOverride(
    covariant GMovieProvider provider,
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
  String? get name => r'gMovieProvider';
}

abstract class _$GMovie extends BuildlessAutoDisposeAsyncNotifier<Movie> {
  late final int movieId;

  FutureOr<Movie> build({
    required int movieId,
  });
}

String _$GAMovieHash() => r'0c3630cbe5caafe464fc4d78a5949e872c63b7e4';

/// See also [GAMovie].
class GAMovieProvider
    extends AutoDisposeAsyncNotifierProviderImpl<GAMovie, Movie> {
  GAMovieProvider({
    required this.movieId,
  }) : super(
          () => GAMovie()..movieId = movieId,
          from: gAMovieProvider,
          name: r'gAMovieProvider',
          debugGetCreateSourceHash:
              const bool.fromEnvironment('dart.vm.product')
                  ? null
                  : _$GAMovieHash,
        );

  final int movieId;

  @override
  bool operator ==(Object other) {
    return other is GAMovieProvider && other.movieId == movieId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, movieId.hashCode);

    return _SystemHash.finish(hash);
  }

  @override
  FutureOr<Movie> runNotifierBuild(
    covariant _$GAMovie notifier,
  ) {
    return notifier.build(
      movieId: movieId,
    );
  }
}

typedef GAMovieRef = AutoDisposeAsyncNotifierProviderRef<Movie>;

/// See also [GAMovie].
final gAMovieProvider = GAMovieFamily();

class GAMovieFamily extends Family<AsyncValue<Movie>> {
  GAMovieFamily();

  GAMovieProvider call({
    required int movieId,
  }) {
    return GAMovieProvider(
      movieId: movieId,
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderImpl<GAMovie, Movie> getProviderOverride(
    covariant GAMovieProvider provider,
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
  String? get name => r'gAMovieProvider';
}

abstract class _$GAMovie extends BuildlessAutoDisposeAsyncNotifier<Movie> {
  late final int movieId;

  FutureOr<Movie> build({
    required int movieId,
  });
}

String _$LikeMovieHash() => r'fc026109d5a49c3f6927d09406d007dca458f485';

/// See also [LikeMovie].
final likeMovieProvider = AutoDisposeNotifierProvider<LikeMovie, int>(
  LikeMovie.new,
  name: r'likeMovieProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$LikeMovieHash,
);
typedef LikeMovieRef = AutoDisposeNotifierProviderRef<int>;

abstract class _$LikeMovie extends AutoDisposeNotifier<int> {
  @override
  int build();
}

String _$TodosHash() => r'adb388ec4ec3adaf1f7b7014996c10fea35caf24';

/// See also [Todos].
final todosProvider = AutoDisposeNotifierProvider<Todos, List<Todo>>(
  Todos.new,
  name: r'todosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$TodosHash,
);
typedef TodosRef = AutoDisposeNotifierProviderRef<List<Todo>>;

abstract class _$Todos extends AutoDisposeNotifier<List<Todo>> {
  @override
  List<Todo> build();
}

String _$AsyncTodosHash() => r'b0660f114ba36d0416a3d2a7c1bb2dcd6632a090';

/// See also [AsyncTodos].
final asyncTodosProvider =
    AutoDisposeAsyncNotifierProvider<AsyncTodos, List<Todo>>(
  AsyncTodos.new,
  name: r'asyncTodosProvider',
  debugGetCreateSourceHash:
      const bool.fromEnvironment('dart.vm.product') ? null : _$AsyncTodosHash,
);
typedef AsyncTodosRef = AutoDisposeAsyncNotifierProviderRef<List<Todo>>;

abstract class _$AsyncTodos extends AutoDisposeAsyncNotifier<List<Todo>> {
  @override
  FutureOr<List<Todo>> build();
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
String _$moviesHash() => r'424f39443015f3916214eab12823a95444a5ebd7';

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
