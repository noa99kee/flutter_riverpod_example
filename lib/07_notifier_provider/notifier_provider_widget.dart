import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class CounterNotifier extends AutoDisposeNotifier<int> {
  CounterNotifier() {
    print('Counter constructor');
  }
  @override
  int build() {
    ref.onDispose(() {
      print('ref onDispose');
    });
    return 0;
  }

  void increment() {
    state++;
  }
}

final counterProvider = AutoDisposeNotifierProvider<CounterNotifier, int>(
  () {
    return CounterNotifier();
  },
);
//or 생성자 분리
//final counterProvider = NotifierProvider<Counter, int>(Counter.new);

class NotifierProviderWidget extends ConsumerWidget {
  const NotifierProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('NotifierProvider')),
      body: ElevatedButton(
        child: Text('Value : $counter'),
        onPressed: () {
          final counterNotifier = ref.read(counterProvider.notifier);
          //counterNotifier.state++; //이렇게도 된다.
          counterNotifier.increment();
        },
      ),
    );
  }
}
