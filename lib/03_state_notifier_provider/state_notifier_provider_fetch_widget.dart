import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/04_future_provider/future_provider_widget.dart';

class PostListNotifier extends StateNotifier<AsyncValue<List<Post>>> {
  PostListNotifier({
    required this.dio,
  }) : super(const AsyncValue.loading()) {
    fetchPostsUseGuard();
  }
  final Dio dio;

  Future<void> fetchPosts() async {
    state = const AsyncValue.loading();
    try {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      final data = response.data;
      final postList = data as List<dynamic>;
      final posts = postList.map((post) => Post.fromMap(post)).toList();
      state = AsyncValue.data(posts);
    } catch (err, stack) {
      state = AsyncValue.error(err, stack);
    }
  }

  //위와 같음
  Future<void> fetchPostsUseGuard() async {
    state = const AsyncValue.loading();

    state = await AsyncValue.guard(() async {
      final response =
          await dio.get('https://jsonplaceholder.typicode.com/posts');
      final data = response.data;
      final postList = data as List<dynamic>;
      final posts = postList.map((post) => Post.fromMap(post)).toList();
      return posts;
    });
  }
}

final postListProvider =
    StateNotifierProvider.autoDispose<PostListNotifier, AsyncValue<List<Post>>>(
  (ref) {
    final dio = ref.watch(dioProvider);
    return PostListNotifier(dio: dio);
  },
);

class StateNotifierProviderFetchWidget extends ConsumerWidget {
  const StateNotifierProviderFetchWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncPosts = ref.watch(postListProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('StateNotifierProvider Fetch')),
      body: asyncPosts.when(
        data: (posts) => ListView.separated(
          itemCount: posts.length,
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
        error: (e, st) => Center(child: Text(e.toString())),
      ),
    );
  }
}
