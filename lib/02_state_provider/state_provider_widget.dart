import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//StateProvider는 간단한 상태 vs NotifierProvider
final counterProvider = StateProvider<int>((ref) => 0);

class StateProviderWidget extends ConsumerWidget {
  const StateProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final counter = ref.watch(counterProvider);
    return Scaffold(
      appBar: AppBar(title: const Text('StateProvider')),
      body: ElevatedButton(
        child: Text('Value : $counter'),
        onPressed: () {
          final counterNotifier = ref.read(counterProvider.notifier);
          counterNotifier.state++;
        },
      ),
    );
  }
}
