import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_example/09_riverpod_generator_tmdb/tmdb_movie.dart';

part 'riverpod_generator_widget.g.dart';

//riverpod generator 다음만 지원 한다.
// 01. Provider
// 04. FutureProvider
// 07. NotifierProvider
// 08. AsyncNotifierProvider

@riverpod
String helloWorld(HelloWorldRef ref) {
  return 'Hello world';
}

class Movie {
  final int id;
  final String title;
  Movie({
    required this.id,
    required this.title,
  });
}

// 기본 keepAlive = false, AutoDispose (지워짐)   VS  keepAlive = true, AutoDispose NOT (안 지워짐, onDispose 호출 안됨)
@Riverpod(keepAlive: false)
Future<List<Movie>> movies(
  MoviesRef ref, {
  required int page,
}) async {
  ref.onDispose(() {
    print('movies onDispose');
  });
  await Future.delayed(const Duration(seconds: 1));
  return <Movie>[Movie(id: 0, title: 'titanic'), Movie(id: 1, title: 'avatar')];
}

//AutoDispose Notifier Provider
@riverpod
class GCounter extends _$GCounter {
  @override
  int build() {
    return 0;
  }

  void increment() {
    state++;
  }
}

//AutoDispose AsyncNotifier Provider
@riverpod
class GMovie extends _$GMovie {
  @override
  FutureOr<Movie> build({
    required int movieId,
  }) {
    return Movie(id: movieId, title: 'titanic');
  }
}

//AutoDispose AsyncNotifier Provider  비동기 초기 값
@riverpod
class GAMovie extends _$GAMovie {
  @override
  FutureOr<Movie> build({
    required int movieId,
  }) async {
    await Future.delayed(const Duration(seconds: 1));
    return Movie(id: movieId, title: 'avatar II');
  }
}

@riverpod
class LikeMovie extends _$LikeMovie {
  @override
  int build() {
    return 0;
  }

  Future<void> like() async {
    state++;
  }

  Future<void> reset() async {
    ref.invalidateSelf(); //자기 자신 초기화
    ref.invalidate(gCounterProvider); //다른 프로바이더 초기화
  }
}

class RiverpodGeneratorWidget extends ConsumerWidget {
  const RiverpodGeneratorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helloWorld = ref.watch(helloWorldProvider);
    final movies = ref.watch(moviesProvider(page: 0));
    final gCounter = ref.watch(gCounterProvider);
    final gMovie = ref.watch(gMovieProvider(movieId: 100));
    final gaMovie = ref.watch(gAMovieProvider(movieId: 1000));
    final likeMovie = ref.watch(likeMovieProvider);

    return Scaffold(
      appBar: AppBar(title: Text('Riverpod Generator')),
      body: Column(
        children: [
          Text(helloWorld),
          SizedBox(
            height: 50,
          ),
          movies.when(data: ((movies) {
            return ListView.builder(
                itemCount: movies.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  final movie = movies[index];
                  return Text(
                    '${movie.title}',
                    style: TextStyle(fontSize: 24),
                  );
                });
          }), error: ((error, stackTrace) {
            return Text('error');
          }), loading: (() {
            return CircularProgressIndicator();
          })),
          ElevatedButton(
              onPressed: () {
                ref.read(gCounterProvider.notifier).increment();
              },
              child: Text(gCounter.toString())),
          gMovie.maybeWhen(data: (movie) {
            return Text(movie.title);
          }, orElse: (() {
            return Container();
          })),
          gaMovie.maybeWhen(data: (movie) {
            return Text(movie.title);
          }, orElse: (() {
            return CircularProgressIndicator();
          })),
          Row(
            children: [
              ElevatedButton(
                  onPressed: () {
                    ref.read(likeMovieProvider.notifier).like();
                  },
                  child: Text('like movie :' + likeMovie.toString())),
              ElevatedButton(
                  onPressed: () {
                    ref.read(likeMovieProvider.notifier).reset();
                  },
                  child: Text('reset')),
            ],
          )
        ],
      ),
    );
  }
}
