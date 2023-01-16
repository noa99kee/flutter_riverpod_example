import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class User {
  final String name;
  final bool isLogin;
  User({required this.name, required this.isLogin});
}

//StateNotifier 불변 상태(객체) 노출
class AuthNotifier extends StateNotifier<AsyncValue<User>> {
  AuthNotifier(this.ref) : super(AsyncValue.loading()) {
    signOut();
  }
  final Ref ref;

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

//비동기적인 초기화를 할 수 없어?
final authProvider =
    AutoDisposeStateNotifierProvider<AuthNotifier, AsyncValue<User>>(
  (ref) {
    return AuthNotifier(ref);
  },
);

class StateNotifierProviderWidget extends ConsumerWidget {
  const StateNotifierProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final authAsync = ref.watch(authProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('StateNotifierProvider')),
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
              ref.read(authProvider.notifier).signOut();
            } else {
              ref.read(authProvider.notifier).signIn();
            }
          });
        },
      ),
    );
  }
}
