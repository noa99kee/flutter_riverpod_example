import 'dart:async';

import 'package:dio/dio.dart';
import 'package:riverpod_example/09_riverpod_generator/my_dio_provider.dart';
import 'package:riverpod_example/09_riverpod_generator/tmdb_movie.dart';
import 'package:riverpod_example/09_riverpod_generator/tmdb_movies_response.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'movies_repository.g.dart';

class MoviesRepository {
  final Dio dio;
  final String apiKey;

  MoviesRepository({
    required this.dio,
    required this.apiKey,
  });

  Future<List<TMDBMovie>> searchMovies(
      {required int page, String query = '', CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/search/movie',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
        'page': '$page',
        'query': query,
      },
    ).toString();
    final response = await dio.get(url);
    final movies = TMDBMoviesResponse.fromJson(response.data);
    return movies.results;
  }

  Future<List<TMDBMovie>> nowPlayingMovies(
      {required int page, CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/now_playing',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
        'page': '$page',
      },
    ).toString();
    final response = await dio.get(url);
    final movies = TMDBMoviesResponse.fromJson(response.data);
    return movies.results;
  }

  // get the movie for a given id
  Future<TMDBMovie> movie(
      {required int movieId, CancelToken? cancelToken}) async {
    final url = Uri(
      scheme: 'https',
      host: 'api.themoviedb.org',
      path: '3/movie/$movieId',
      queryParameters: {
        'api_key': apiKey,
        'include_adult': 'false',
      },
    ).toString();
    final response = await dio.get(url);
    return TMDBMovie.fromJson(response.data);
  }
}

//moviesRepositoryProvider
@riverpod
MoviesRepository moviesRepository(MoviesRepositoryRef ref) => MoviesRepository(
      dio: ref.watch(myDioProvider),
      apiKey: 'f4fe0fea24f43e90075c5835794ec63b',
    );

/// Provider to fetch paginated movies data
//fetchMoviesProvider
@riverpod
Future<List<TMDBMovie>> fetchMovies(
  FetchMoviesRef ref, {
  required MoviesPagination pagination,
}) async {
  final moviesRepo = ref.watch(moviesRepositoryProvider);
  // Cancel the page request if the UI no longer needs it.
  // This happens if the user scrolls very fast or if we type a different search
  // term.
  final cancelToken = CancelToken();
  // When a page is no-longer used, keep it in the cache.
  final link = ref.keepAlive();
  final timer = Timer(const Duration(seconds: 30), () {
    link.close();
  });
  ref.onDispose(() {
    cancelToken.cancel();
    timer.cancel();
  });
  if (pagination.query.isEmpty) {
    // use non-search endpoint
    return moviesRepo.nowPlayingMovies(
      page: pagination.page,
      cancelToken: cancelToken,
    );
  } else {
    // Debounce the request. By having this delay, consumers can subscribe to
    // different parameters. In which case, this request will be aborted.
    await Future.delayed(const Duration(milliseconds: 500));
    if (cancelToken.isCancelled) throw AbortedException();
    // use search endpoint
    return moviesRepo.searchMovies(
      page: pagination.page,
      query: pagination.query,
      cancelToken: cancelToken,
    );
  }
}

/// Provider to fetch a movie by ID
//movieProvider
@riverpod
Future<TMDBMovie> movie(
  MovieRef ref, {
  required int movieId,
}) {
  final cancelToken = CancelToken();
  return ref
      .watch(moviesRepositoryProvider)
      .movie(movieId: movieId, cancelToken: cancelToken);
}

//////////////////////////////////////////////////
class AbortedException implements Exception {}

class MoviesPagination {
  MoviesPagination({required this.page, required this.query});
  final int page;
  final String query;

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is MoviesPagination &&
        other.query == query &&
        other.page == page;
  }

  @override
  int get hashCode => query.hashCode ^ page.hashCode;
}
