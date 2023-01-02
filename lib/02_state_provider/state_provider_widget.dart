import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

//StateProvider는 간단한 상태 vs NotifierProvider
final counterProvider = StateProvider<int>((ref) => 0);

class StateProviderWidget extends ConsumerWidget {
  const StateProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    print('build');
    final counter = ref.watch(counterProvider);
    ref.listen<int>(counterProvider, ((previous, next) {
      if (next == 5) {
        showDialog(
            context: context,
            builder: ((context) {
              return AlertDialog(
                title: Text('count:$next'),
              );
            }));
      }
    }));
    return Scaffold(
        appBar: AppBar(title: const Text('StateProvider')),
        body: Row(
          children: [
            ElevatedButton(
              child: Text('Value : $counter'),
              onPressed: () {
                final counterNotifier = ref.read(counterProvider.notifier);
                counterNotifier.state++;
              },
            ),
            ElevatedButton(
                onPressed: () {
                  //공급자의 상태를 무효화하여 공급자를 새로 고칩니다.
                  //[refresh]과는 달리 새로 고침은 즉시 수행되지 않으며 대신 다음 읽기 또는 다음 프레임으로 지연됩니다.
                  //[invalidate]를 여러 번 호출하면 공급자가 한 번만 새로 고쳐집니다.
                  //[invalidate]를 호출하면 공급자가 즉시 처리됩니다.
                  //ref.invalidate(counterProvider);

                  //공급자가 즉시 상태를 재평가하고 생성된 값을 반환하도록 강제합니다.
                  //ref.refresh(counterProvider);
                },
                child: Text('reset'))
          ],
        ));
  }
}
