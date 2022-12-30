import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_example/03_state_notifier_provider/state_notifier_provider_widget.dart';

class AuthAsyncNotifier extends AutoDisposeAsyncNotifier<User> {
  //초기 값 을 반환 비동기적인 초기화도 가능 하다. ref를 전달 할 필요가 없다.(그냥 ref 있다)
  //FutureOr<T> ==> Future<T> ro T
  @override
  FutureOr<User> build() async {
    ref.onDispose(
      () {},
    );
    //return User(name: '', isLogin: false);
    await Future.delayed(Duration(seconds: 1));
    return User(name: '', isLogin: false);
  }

  Future<void> signIn() async {
    state = const AsyncValue.loading();

    await Future.delayed(Duration(seconds: 1));
    state = AsyncValue.data(User(name: 'keesoon', isLogin: true));
  }

  Future<void> signOut() async {
    state = const AsyncValue.loading();

    await Future.delayed(Duration(seconds: 0));
    state = AsyncValue.data(User(name: '', isLogin: false));
  }
}

/*
final authAsyncProvider =
    AutoDisposeAsyncNotifierProvider<AuthAsyncNotifier, User>(
  () {
    return AuthAsyncNotifier();
  },
);
*/
final authAsyncProvider =
    AutoDisposeAsyncNotifierProvider<AuthAsyncNotifier, User>(
        AuthAsyncNotifier.new);

class AsyncNotifierProviderWidget extends ConsumerWidget {
  const AsyncNotifierProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authAsyncProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('AsyncNotifierProvider')),
      body: ElevatedButton(
        child: authAsync.when(data: ((user) {
          if (user.isLogin) {
            return Text('logOut    name : ${user.name}');
          } else {
            return Text('logIn');
          }
        }), error: ((error, stackTrace) {
          return Text('error');
        }), loading: (() {
          return Text('loading');
        })),
        onPressed: () {
          authAsync.whenData((user) {
            if (user.isLogin) {
              ref.read(authAsyncProvider.notifier).signOut();
            } else {
              ref.read(authAsyncProvider.notifier).signIn();
            }
          });
        },
      ),
    );
  }
}
