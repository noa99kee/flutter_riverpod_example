import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/09_riverpod_generator_tmdb/movies_repository.dart';
import 'package:riverpod_example/09_riverpod_generator_tmdb/movies_search_bar.dart';
import 'package:riverpod_example/09_riverpod_generator_tmdb/tmdb_movie.dart';
import 'package:shimmer/shimmer.dart';

class RiverpodGeneratorTMDBWidget extends ConsumerWidget {
  const RiverpodGeneratorTMDBWidget({super.key});

  static const pageSize = 20;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final query = ref.watch(moviesSearchTextProvider); //query 가 바뀌면 리 빌드 됨

    return Scaffold(
      appBar: AppBar(title: Text('RiverpodGenerator')),
      body: Column(
        children: [
          const MoviesSearchBar(),
          Expanded(
            child: RefreshIndicator(
              onRefresh: () {
                //onRefresh 함수는 Future type return 해야한다.

                //container.invalidate(provider)/ ref.invalidate(provider)및 ref.invalidateSelf().
                //이는 ref.refresh메서드와 유사하지만 공급자를 즉시 ​​다시 빌드하지 않습니다.
                ref.invalidate(fetchMoviesProvider);

                // ? 왜 그런지 잘 모르겠당...
                final refreshableFutureMovies = fetchMoviesProvider(
                        pagination: MoviesPagination(page: 1, query: query))
                    .future;

                final futureMovies = ref.read(refreshableFutureMovies);
                return futureMovies;
              },
              child: ListView.custom(
                childrenDelegate: SliverChildBuilderDelegate(
                  (context, index) {
                    final page = index ~/ pageSize + 1;
                    final indexInPage = index % pageSize;
                    final asyncMovies = ref.watch(
                      fetchMoviesProvider(
                          pagination:
                              MoviesPagination(page: page, query: query)),
                    );

                    return asyncMovies.when(
                      // TODO: Improve error handling
                      error: (err, stack) => Text('Error $err'),
                      loading: () => const MovieListTileShimmer(),
                      data: (movies) {
                        if (indexInPage >= movies.length) {
                          return const MovieListTileShimmer();
                        }
                        final movie = movies[indexInPage];
                        return MovieListTile(
                          movie: movie,
                          //debugIndex: index,
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => MovieDetailsScreen(
                                  movieId: movie.id,
                                  movie: movie,
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  },
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class MovieListTile extends StatelessWidget {
  const MovieListTile({
    super.key,
    required this.movie,
    // debugging hint to show the tile index
    this.debugIndex,
    this.onPressed,
  });
  final TMDBMovie movie;
  final int? debugIndex;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
      child: Row(
        children: [
          GestureDetector(
            onTap: onPressed,
            child: Stack(
              children: [
                SizedBox(
                  width: MoviePoster.width,
                  height: MoviePoster.height,
                  child: MoviePoster(imagePath: movie.posterPath),
                ),
                if (debugIndex != null) ...[
                  const Positioned.fill(child: TopGradient()),
                  Positioned(
                    left: 8,
                    top: 8,
                    child: Text(
                      '$debugIndex',
                      style: const TextStyle(color: Colors.white, fontSize: 14),
                    ),
                  ),
                ]
              ],
            ),
          ),
          const SizedBox(width: 8),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  movie.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                if (movie.releaseDate != null) ...[
                  const SizedBox(height: 8),
                  Text('Released: ${movie.releaseDate}'),
                ],
              ],
            ),
          )
        ],
      ),
    );
  }
}

class MoviePoster extends StatelessWidget {
  const MoviePoster({super.key, this.imagePath});
  final String? imagePath;

  static const width = 154.0;
  static const height = 231.0;

  @override
  Widget build(BuildContext context) {
    if (imagePath != null) {
      return CachedNetworkImage(
        //fit: BoxFit.fitWidth,
        imageUrl: TMDBPoster.imageUrl(imagePath!, PosterSize.w185),
        placeholder: (_, __) => Shimmer.fromColors(
          baseColor: Colors.black26,
          highlightColor: Colors.black12,
          child: Container(
            width: width,
            height: height,
            color: Colors.black,
          ),
        ),
      );
    }
    return const Placeholder(
      color: Colors.black87,
    );
  }
}

class TopGradient extends StatelessWidget {
  const TopGradient({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          colors: [
            Colors.black87,
            Colors.transparent,
          ],
          stops: [0.0, 0.3],
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          tileMode: TileMode.repeated,
        ),
      ),
    );
  }
}

enum PosterSize {
  w92,
  w154,
  w185,
  w342,
  w500,
  w780,
  original,
}

Map<PosterSize, String> _posterSizes = {
  PosterSize.w92: "w92",
  PosterSize.w154: "w154",
  PosterSize.w185: "w185",
  PosterSize.w342: "w342",
  PosterSize.w500: "w500",
  PosterSize.w780: "w780",
  PosterSize.original: "original",
};

class TMDBPoster {
  static String tmdbBaseImageUrl = "http://image.tmdb.org/t/p/";

  static String imageUrl(String path, PosterSize size) {
    return tmdbBaseImageUrl + _posterSizes[size]! + path;
  }
}

class MovieListTileShimmer extends StatelessWidget {
  const MovieListTileShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: Colors.black26,
      highlightColor: Colors.black12,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
        child: Row(
          children: [
            Container(
              width: MoviePoster.width,
              height: MoviePoster.height,
              color: Colors.black,
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    width: double.infinity,
                    height: 20.0,
                    color: Colors.black,
                    margin: const EdgeInsets.only(bottom: 8.0),
                  ),
                  Container(
                    width: 100.0,
                    height: 15.0,
                    color: Colors.black,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}

class MovieDetailsScreen extends ConsumerWidget {
  const MovieDetailsScreen(
      {super.key, required this.movieId, required this.movie});
  final int movieId;
  final TMDBMovie? movie;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    if (movie != null) {
      return Scaffold(
        appBar: AppBar(
          title: Text(movie!.title),
        ),
        body: Column(
          children: [
            MovieListTile(movie: movie!),
          ],
        ),
      );
    } else {
      final movieAsync = ref.watch(movieProvider(movieId: movieId));
      return movieAsync.when(
        error: (e, st) => Scaffold(
          appBar: AppBar(
            title: Text(movie?.title ?? 'Error'),
          ),
          body: Center(child: Text(e.toString())),
        ),
        loading: () => Scaffold(
          appBar: AppBar(
            title: Text(movie?.title ?? 'Loading'),
          ),
          body: Column(
            children: const [
              MovieListTileShimmer(),
            ],
          ),
        ),
        data: (movie) => Scaffold(
          appBar: AppBar(
            title: Text(movie.title),
          ),
          body: Column(
            children: [
              MovieListTile(movie: movie),
            ],
          ),
        ),
      );
    }
  }
}
