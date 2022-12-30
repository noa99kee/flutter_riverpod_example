// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/04_future_provider/api_error.dart';

class Post {
  final int userId;
  final int id;
  final String title;
  final String body;
  Post({
    required this.userId,
    required this.id,
    required this.title,
    required this.body,
  });

  Post copyWith({
    int? userId,
    int? id,
    String? title,
    String? body,
  }) {
    return Post(
      userId: userId ?? this.userId,
      id: id ?? this.id,
      title: title ?? this.title,
      body: body ?? this.body,
    );
  }

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'userId': userId,
      'id': id,
      'title': title,
      'body': body,
    };
  }

  factory Post.fromMap(Map<String, dynamic> map) {
    return Post(
      userId: map['userId'] as int,
      id: map['id'] as int,
      title: map['title'] as String,
      body: map['body'] as String,
    );
  }

  String toJson() => json.encode(toMap());

  factory Post.fromJson(String source) =>
      Post.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() {
    return 'Post(userId: $userId, id: $id, title: $title, body: $body)';
  }

  @override
  bool operator ==(covariant Post other) {
    if (identical(this, other)) return true;

    return other.userId == userId &&
        other.id == id &&
        other.title == title &&
        other.body == body;
  }

  @override
  int get hashCode {
    return userId.hashCode ^ id.hashCode ^ title.hashCode ^ body.hashCode;
  }
}

final dioProvider = Provider<Dio>(
  (ref) {
    return Dio();
  },
);

class PostRepository {
  PostRepository({
    required this.dio,
  });
  final Dio dio;

  Future<List<Post>?> fetchPosts() async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      final data = response.data;
      final posts = data as List<dynamic>;
      return posts.map((post) => Post.fromMap(post)).toList();
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    } on DioError catch (e, s) {
      throw const APIError.notFound();
    }
  }

  Future<Post> fetchPost({required int postId}) async {
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts/$postId');
      switch (response.statusCode) {
        case 200:
          final data = response.data;
          return Post.fromMap(data);
        case 404:
          throw const APIError.notFound(); // ? 안불리는것 같다.
        default:
          throw const APIError.unknown(); // ? 안불리는것 같다.
      }
    } on SocketException catch (_) {
      throw const APIError.noInternetConnection();
    } on DioError catch (e, s) {
      throw const APIError.notFound();
    }
  }
}

final postRepositoryProvider = Provider<PostRepository>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return PostRepository(dio: dio);
  },
);

final postsProvider = FutureProvider.autoDispose<List<Post>?>(
  (ref) {
    final repository = ref.watch(postRepositoryProvider);

    return repository.fetchPosts();
  },
);

final postProvider = FutureProvider.autoDispose.family<Post, int>(
  (ref, postId) {
    final repository = ref.watch(postRepositoryProvider);

    return repository.fetchPost(postId: postId);
  },
);

class MyError {}

class FutureProviderWidget extends ConsumerWidget {
  const FutureProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPosts = ref.watch(postsProvider);

    final futurePosts = ref.watch(postsProvider.future);
    print('futurePosts : $futurePosts');
    final data = ref.watch(postsProvider).value;
    print('data : $data');

    return Scaffold(
      appBar: AppBar(title: const Text('FutureProvider')),
      //FutureBuilder 와 StreamBuilder 대신 AsyncValue
      body: asyncPosts.when(
        data: (posts) => ListView.separated(
          itemCount: posts!.length,
          itemBuilder: (context, index) {
            final post = posts[index];
            return ListTile(
                leading: DecoratedBox(
                  decoration: const BoxDecoration(
                    color: Colors.indigo,
                    //border:StadiumBorder(),
                    borderRadius: BorderRadius.all(Radius.circular(16)),
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(post.id.toString(),
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: Colors.white)),
                  ),
                ),
                title: Text(post.title,
                    style: Theme.of(context).textTheme.subtitle1),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => PostDetailWidget(postId: post.id)));
                });
          },
          separatorBuilder: (context, index) => const Divider(),
        ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (e, st) {
          print('e.runtimeType : ${e.runtimeType}');
          print('e : $e');
          if (e is APIError) {
            print(e.message);
          }
          return Center(child: Text(e.toString()));
        },
      ),
    );
  }
}

class PostDetailWidget extends ConsumerWidget {
  const PostDetailWidget({
    super.key,
    required this.postId,
  });
  final int postId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPost = ref.watch(postProvider(postId));
    return Scaffold(
      appBar: AppBar(title: Text('Post $postId')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: asyncPost.when(
          data: (post) => Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(post.title, style: Theme.of(context).textTheme.titleLarge),
              const SizedBox(height: 32),
              Text(post.body),
              const Spacer(),
            ],
          ),
          loading: () => const Center(child: CircularProgressIndicator()),
          error: (e, st) {
            return Center(child: Text(e.toString()));
          },
        ),
      ),
    );
  }
}
