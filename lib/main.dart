import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/01_provider/provider_widget.dart';
import 'package:riverpod_example/02_state_provider/state_provider_widget.dart';
import 'package:riverpod_example/03_state_notifier_provider/state_notifier_provider_fetch_widget.dart';
import 'package:riverpod_example/03_state_notifier_provider/state_notifier_provider_todo_widget.dart';
import 'package:riverpod_example/03_state_notifier_provider/state_notifier_provider_widget.dart';
import 'package:riverpod_example/04_future_provider/future_provider_widget.dart';
import 'package:riverpod_example/05_stream_provider/stream_provider_widget.dart';
import 'package:riverpod_example/06_change_notifier_provider/change_notifier_provider_widget.dart';
import 'package:riverpod_example/07_notifier_provider/notifier_provider_widget.dart';
import 'package:riverpod_example/08_async_notifier_provider/async_notifier_provider_widget.dart';
import 'package:riverpod_example/09_riverpod_generator_tmdb/riverpod_generator_tmdb_widget.dart';
import 'package:riverpod_example/10_riverpod_generator/riverpod_generator_widget.dart';
import 'package:riverpod_example/11_pagination/pagination_widget.dart';
import 'package:riverpod_example/12_pub_search/pub_search_widget.dart';

void main() {
  runApp(
    ProviderScope(
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomeScreen(),
    );
  }
}

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Flutter Riverpod 2.0')),
      body: Container(
        width: double.infinity,
        child: Column(crossAxisAlignment: CrossAxisAlignment.center, children: [
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => ProviderWidget()),
              );
            },
            child: Text('Provider'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StateProviderWidget()),
              );
            },
            child: Text('StateProvider'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StateNotifierProviderWidget()),
              );
            },
            child: Text('StateNotifierProvider'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StateNotifierProviderTodoWidget()),
              );
            },
            child: Text('StateNotifierProviderTodo'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => StateNotifierProviderFetchWidget()),
              );
            },
            child: Text('StateNotifierProviderFetch'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ChangeNotifierProviderWidget()),
              );
            },
            child: Text('ChangeNotifierProvider'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FutureProviderWidget()),
              );
            },
            child: Text('FutureProvider'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => StreamProviderWidget()),
              );
            },
            child: Text('StreamProvider'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => NotifierProviderWidget()),
              );
            },
            child: Text('NotifierProvider'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => AsyncNotifierProviderWidget()),
              );
            },
            child: Text('AsyncNotifierProvider'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RiverpodGeneratorTMDBWidget()),
              );
            },
            child: Text('RiverpodGenerator TMDB'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => RiverpodGeneratorWidget()),
              );
            },
            child: Text('RiverpodGenerator'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PaginationWidget()),
              );
            },
            child: Text('Pagination'),
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => PubSearchWidget()),
              );
            },
            child: Text('Pub Search'),
          ),
        ]),
      ),
    );
  }
}
