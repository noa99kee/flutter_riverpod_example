import 'dart:async';
import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:http/http.dart' as http;

part 'riverpod_generator_widget.g.dart';
part 'riverpod_generator_widget.freezed.dart';

//riverpod generator 다음만 지원 한다.
// 01. Provider
// 04. FutureProvider
// 07. NotifierProvider
// 08. AsyncNotifierProvider

// 01. Provider
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

// 04. FutureProvider
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

// 07. NotifierProvider
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

// 08. AsyncNotifierProvider
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

// 08. AsyncNotifierProvider
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

// 07. NotifierProvider
//AutoDispose Notifier Provider
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

@freezed
class Todo with _$Todo {
  factory Todo({
    required String id,
    required String description,
    required bool completed,
  }) = _Todo;
  factory Todo.fromJson(Map<String, dynamic> json) => _$TodoFromJson(json);
}

@riverpod
class Todos extends _$Todos {
  @override
  List<Todo> build() {
    return [
      Todo(id: '0', description: '쁘미 밥 주기', completed: false),
      Todo(id: '1', description: '또리 물 주기', completed: false),
      Todo(id: '2', description: '깜봉 놀아 주기', completed: true),
    ];
  }

  // Let's allow the UI to add todos.
  void addTodo(Todo todo) {
    // Since our state is immutable, we are not allowed to do `state.add(todo)`.
    // Instead, we should create a new list of todos which contains the previous
    // items and the new one.
    // Using Dart's spread operator here is helpful!
    state = [...state, todo];
    // No need to call "notifyListeners" or anything similar. Calling "state ="
    // will automatically rebuild the UI when necessary.
  }

  // Let's allow removing todos
  void removeTodo(String todoId) {
    // Again, our state is immutable. So we're making a new list instead of
    // changing the existing list.
    state = [
      for (final todo in state)
        if (todo.id != todoId) todo,
    ];
  }

  // Let's mark a todo as completed
  void toggle(String todoId) {
    state = [
      for (final todo in state)
        // we're marking only the matching todo as completed
        if (todo.id == todoId)
          // Once more, since our state is immutable, we need to make a copy
          // of the todo. We're using our `copyWith` method implemented before
          // to help with that.
          todo.copyWith(completed: !todo.completed)
        else
          // other todos are not modified
          todo,
    ];
  }
}

@riverpod
class AsyncTodos extends _$AsyncTodos {
  Future<List<Todo>> _fetchTodo() async {
    final json = await http.get(Uri.http('api/todos'));
    final todos = jsonDecode(json.body) as List<Map<String, dynamic>>;
    return todos.map((todo) => Todo.fromJson(todo)).toList();
  }

  @override
  FutureOr<List<Todo>> build() async {
    // Load initial todo list from the remote repository
    return _fetchTodo();
  }

  Future<void> addTodo(Todo todo) async {
    // Set the state to loading
    state = const AsyncValue.loading();
    // Add the new todo and reload the todo list from the remote repository
    state = await AsyncValue.guard(() async {
      await http.post(Uri.http('api/todos'), body: todo.toJson());
      return _fetchTodo();
    });
  }

  // Let's allow removing todos
  Future<void> removeTodo(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await http.delete(Uri.http('api/todos/$todoId'));
      return _fetchTodo();
    });
  }

  // Let's mark a todo as completed
  Future<void> toggle(String todoId) async {
    state = const AsyncValue.loading();
    state = await AsyncValue.guard(() async {
      await http.patch(
        Uri.http('api/todos/$todoId'),
        body: <String, dynamic>{'completed': true},
      );
      return _fetchTodo();
    });
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

    final List<Todo> todos = ref.watch(todosProvider);

    final asyncTodos = ref.watch(asyncTodosProvider);

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
          ),
          ListView(
            shrinkWrap: true,
            children: [
              for (final todo in todos)
                CheckboxListTile(
                  value: todo.completed,
                  onChanged: (value) {
                    ref.read(todosProvider.notifier).toggle(todo.id);
                  },
                  title: Text(todo.description),
                )
            ],
          ),
          asyncTodos.when(
            data: (todos) => ListView(
              children: [
                for (final todo in todos)
                  CheckboxListTile(
                    value: todo.completed,
                    // When tapping on the todo, change its completed status
                    onChanged: (value) =>
                        ref.read(asyncTodosProvider.notifier).toggle(todo.id),
                    title: Text(todo.description),
                  ),
              ],
            ),
            loading: () => const Center(
              child: CircularProgressIndicator(),
            ),
            error: (err, stack) => Text('Error: $err'),
          )
        ],
      ),
    );
  }
}
