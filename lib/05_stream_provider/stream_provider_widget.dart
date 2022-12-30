import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Data {
  final int id;
  final String body;
  Data({
    required this.id,
    required this.body,
  });
}

Stream<Data> generateStreamData() async* {
  await Future.delayed(Duration(milliseconds: 1000));
  yield Data(id: 0, body: '쁘미');
  await Future.delayed(Duration(milliseconds: 1000));
  yield Data(id: 1, body: '또리');
  await Future.delayed(Duration(milliseconds: 1000));
  yield Data(id: 2, body: '깜봉');
}

//Stream<Data>
final dataProvider = StreamProvider.autoDispose<Data>(
  (ref) {
    return generateStreamData();
  },
);

class StreamProviderWidget extends ConsumerWidget {
  const StreamProviderWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final asyncData = ref.watch(dataProvider);
    print('asyncData : $asyncData');
    final streamData = ref.watch(dataProvider.stream); //stream을 얻을 수 있다
    print('streamData : $streamData');
    final data = ref.watch(dataProvider).value;
    print('data : $data');

    return Scaffold(
      appBar: AppBar(title: const Text('StreamProvider')),
      body: asyncData.when(data: ((data) {
        return Center(
          child: Text(data.body),
        );
      }), error: ((error, stackTrace) {
        return Center(
          child: Text('error'),
        );
      }), loading: (() {
        return Center(
          child: CircularProgressIndicator(),
        );
      })),
    );
  }
}
