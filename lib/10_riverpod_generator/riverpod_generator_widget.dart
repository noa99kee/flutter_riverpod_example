import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:riverpod_example/09_riverpod_generator_tmdb/tmdb_movie.dart';

part 'riverpod_generator_widget.g.dart';

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

@riverpod
Future<List<Movie>> movies(
  MoviesRef ref, {
  required int page,
}) async {
  await Future.delayed(const Duration(seconds: 1));
  return <Movie>[Movie(id: 0, title: 'titanic'), Movie(id: 1, title: 'avatar')];
}

class RiverpodGeneratorWidget extends ConsumerWidget {
  const RiverpodGeneratorWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final helloWorld = ref.watch(helloWorldProvider);
    final movies = ref.watch(moviesProvider(page: 0));
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
          }))
        ],
      ),
    );
  }
}
